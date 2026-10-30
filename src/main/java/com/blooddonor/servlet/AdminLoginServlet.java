package com.blooddonor.servlet;

import com.blooddonor.dao.AdminDAO;
import com.blooddonor.model.Admin;
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
 * Hardened Admin Authentication Controller.
 *
 * Enforces:
 * 1. Server-side validation & character whitelisting via AuthInputValidator.
 * 2. IP Rate Limiting (max 10 requests / IP / min) & Account Lockout (15 mins after 5 failures).
 * 3. Progressive Delay & CAPTCHA requirement after 3 failures.
 * 4. Constant-time BCrypt verification with dummy hash timing equalization.
 * 5. Identical generic error message: "Incorrect email or password."
 * 6. Session fixation defense via session regeneration on login.
 */
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();
    private final RateLimiterAndLockoutService securityService = RateLimiterAndLockoutService.getInstance();

    public static final String GENERIC_AUTH_ERROR = "Incorrect email or password.";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUsername") != null) {
            response.sendRedirect("adminDashboard");
            return;
        }

        String clientIp = getClientIp(request);
        if (securityService.isCaptchaRequired(null, clientIp)) {
            request.setAttribute("requiresCaptcha", true);
            request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
        }

        request.getRequestDispatcher("admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clientIp = getClientIp(request);

        // 1. Enforce IP Rate Limiting (Max 10 requests / IP / min)
        if (!securityService.checkIpRateLimit(clientIp)) {
            response.setStatus(429);
            request.setAttribute("errorMessage", "Too many requests. Please wait a minute before trying again.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        String rawUsername = request.getParameter("username");
        String rawPassword = request.getParameter("password");
        String captchaAnswer = request.getParameter("captchaAnswer");

        // 2. Validate CAPTCHA if required (after 3 failed attempts)
        boolean captchaRequired = securityService.isCaptchaRequired(rawUsername, clientIp);
        if (captchaRequired) {
            HttpSession session = request.getSession(false);
            if (!securityService.verifyCaptcha(session, captchaAnswer)) {
                securityService.recordFailedAttempt(rawUsername, clientIp);
                request.setAttribute("requiresCaptcha", true);
                request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
                request.setAttribute("errorMessage", "Incorrect CAPTCHA answer. Please try again.");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
                return;
            }
        }

        // 3. Server-side validation & character whitelisting
        String sanitizedUsername;
        String validatedPassword;
        try {
            sanitizedUsername = AuthInputValidator.validateAndSanitizeUsername(rawUsername);
            validatedPassword = AuthInputValidator.validatePassword(rawPassword);
        } catch (IllegalArgumentException e) {
            // Equalize timing even on validation errors to avoid leaking credential format rules
            PasswordUtil.dummyVerify(rawPassword);
            securityService.recordFailedAttempt(rawUsername, clientIp);
            request.setAttribute("errorMessage", GENERIC_AUTH_ERROR);
            if (securityService.isCaptchaRequired(rawUsername, clientIp)) {
                request.setAttribute("requiresCaptcha", true);
                request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
            }
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        // 4. Check Account Lockout (15 minutes after 5 failed attempts)
        if (securityService.isAccountLocked(sanitizedUsername)) {
            // Equalize timing
            PasswordUtil.dummyVerify(validatedPassword);
            request.setAttribute("errorMessage", "Account temporarily locked due to multiple failed attempts. Please try again in 15 minutes.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        try {
            Admin admin = adminDAO.getAdminByUsername(sanitizedUsername);

            boolean loginValid;
            if (admin != null) {
                // Verify password using constant-time BCrypt comparison
                loginValid = PasswordUtil.checkPassword(validatedPassword, admin.getPasswordHash());
            } else {
                // User does not exist: run dummy verification to guarantee identical execution timing!
                PasswordUtil.dummyVerify(validatedPassword);
                loginValid = false;
            }

            if (!loginValid) {
                // Record failed attempt (triggers progressive delay, account lockout, CAPTCHA flag)
                securityService.recordFailedAttempt(sanitizedUsername, clientIp);

                if (securityService.isCaptchaRequired(sanitizedUsername, clientIp)) {
                    request.setAttribute("requiresCaptcha", true);
                    request.setAttribute("captchaChallenge", securityService.generateCaptcha(request.getSession(true)));
                }

                // Identical generic error message
                request.setAttribute("errorMessage", GENERIC_AUTH_ERROR);
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
                return;
            }

            // 5. Successful Login: Clear security trackers
            securityService.recordSuccessfulAttempt(sanitizedUsername, clientIp);

            // Defend against Session Fixation: invalidate existing session and create fresh one
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession session = request.getSession(true);
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("adminFullName", admin.getFullName());
            session.setAttribute("adminId", admin.getAdminId());

            response.sendRedirect("adminDashboard");

        } catch (SQLException e) {
            System.err.println("Database error during admin authentication: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Connection Error: " + e.getMessage());
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
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