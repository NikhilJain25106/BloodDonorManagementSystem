package com.blooddonor.servlet;

import com.blooddonor.dao.DonorDAO;
import com.blooddonor.model.Donor;
import com.blooddonor.security.AuthInputValidator;
import com.blooddonor.security.PasswordUtil;
import com.blooddonor.security.RateLimiterAndLockoutService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Hardened Donor Portal Authentication Controller.
 *
 * Enforces:
 * 1. Strict input validation and sanitization via AuthInputValidator.
 * 2. IP Rate Limiting (max 10 requests / IP / min) & Account Lockout (15 mins after 5 failures).
 * 3. Progressive Delay & CAPTCHA requirement after 3 failures.
 * 4. Timing equalization to prevent user enumeration.
 * 5. Identical generic error message: "Incorrect email or password."
 * 6. Session fixation defense.
 */
@WebServlet("/donorLogin")
public class DonorLoginServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();
    private final RateLimiterAndLockoutService securityService = RateLimiterAndLockoutService.getInstance();

    public static final String GENERIC_AUTH_ERROR = "Incorrect email or password.";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("donorId") != null) {
            response.sendRedirect(request.getContextPath() + "/donorCard");
            return;
        }

        String clientIp = getClientIp(request);
        if (securityService.isCaptchaRequired(null, clientIp)) {
            request.setAttribute("requiresCaptcha", true);
            request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
        }

        request.getRequestDispatcher("donor-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clientIp = getClientIp(request);

        // 1. Enforce IP Rate Limiting (max 10 requests / IP / min)
        if (!securityService.checkIpRateLimit(clientIp)) {
            response.setStatus(429);
            request.setAttribute("errorMessage", "Too many requests. Please wait a minute before trying again.");
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
            return;
        }

        String rawIdentifier = request.getParameter("identifier");
        String captchaAnswer = request.getParameter("captchaAnswer");

        // 2. Validate CAPTCHA if required (after 3 failures)
        boolean captchaRequired = securityService.isCaptchaRequired(rawIdentifier, clientIp);
        if (captchaRequired) {
            HttpSession session = request.getSession(false);
            if (!securityService.verifyCaptcha(session, captchaAnswer)) {
                securityService.recordFailedAttempt(rawIdentifier, clientIp);
                request.setAttribute("requiresCaptcha", true);
                request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
                request.setAttribute("errorMessage", "Incorrect CAPTCHA answer. Please try again.");
                request.getRequestDispatcher("donor-login.jsp").forward(request, response);
                return;
            }
        }

        // 3. Server-side validation & sanitization
        String sanitizedIdentifier;
        try {
            sanitizedIdentifier = AuthInputValidator.validateAndSanitizeIdentifier(rawIdentifier);
        } catch (IllegalArgumentException e) {
            PasswordUtil.dummyVerify(rawIdentifier);
            securityService.recordFailedAttempt(rawIdentifier, clientIp);
            request.setAttribute("errorMessage", GENERIC_AUTH_ERROR);
            if (securityService.isCaptchaRequired(rawIdentifier, clientIp)) {
                request.setAttribute("requiresCaptcha", true);
                request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
            }
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
            return;
        }

        // 4. Check Account Lockout
        if (securityService.isAccountLocked(sanitizedIdentifier)) {
            PasswordUtil.dummyVerify(sanitizedIdentifier);
            request.setAttribute("errorMessage", "Account temporarily locked due to multiple failed attempts. Please try again in 15 minutes.");
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
            return;
        }

        try {
            Donor donor = donorDAO.findByEmailOrPhone(sanitizedIdentifier);

            if (donor == null) {
                // Equalize response timing so absence of user cannot be enumerated
                PasswordUtil.dummyVerify(sanitizedIdentifier);
                securityService.recordFailedAttempt(sanitizedIdentifier, clientIp);

                if (securityService.isCaptchaRequired(sanitizedIdentifier, clientIp)) {
                    request.setAttribute("requiresCaptcha", true);
                    request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
                }

                request.setAttribute("errorMessage", GENERIC_AUTH_ERROR);
                request.getRequestDispatcher("donor-login.jsp").forward(request, response);
                return;
            }

            // 5. Successful Login: Clear security trackers
            securityService.recordSuccessfulAttempt(sanitizedIdentifier, clientIp);

            // Defend against Session Fixation
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession session = request.getSession(true);
            session.setAttribute("donorId", donor.getDonorId());
            session.setAttribute("donorName", donor.getFullName());
            session.setAttribute("donorEmail", donor.getEmail());
            session.setAttribute("donorBloodGroup", donor.getBloodGroup());
            session.setAttribute("donorUser", donor);

            response.sendRedirect(request.getContextPath() + "/donorCard");

        } catch (SQLException e) {
            System.err.println("Database error during donor authentication: " + e.getMessage());
            request.setAttribute("errorMessage", "Authentication service temporarily unavailable. Please try again.");
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
        }
    }

    private String getClientIp(HttpServletRequest request) {
        String xf = request.getHeader("X-Forwarded-For");
        if (xf != null && !xf.isEmpty()) {
            return xf.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
}
