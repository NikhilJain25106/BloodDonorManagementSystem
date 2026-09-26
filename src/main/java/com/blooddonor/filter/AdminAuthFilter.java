package com.blooddonor.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Runs before every request to any admin-only URL (see the urlPatterns
 * below) and checks whether a valid admin session exists. If not, the
 * request is redirected to the login page instead of reaching the
 * servlet at all.
 *
 * WHY THIS MATTERS: without this filter, someone could type
 * http://yoursite/adminDashboard directly into their browser and see
 * the full donor list - including phone numbers and emails - without
 * ever logging in, even if the JSP "hides" the dashboard link from
 * logged-out users. Hiding a link in the UI is not security; the
 * server must refuse the request itself. This filter is that refusal.
 */
@WebFilter(urlPatterns = { "/adminDashboard", "/deleteDonor", "/updateDonor", "/editDonor" })
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No setup needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false); // false = don't create one just to check
        boolean isLoggedIn = (session != null && session.getAttribute("adminUsername") != null);

        if (isLoggedIn) {
            // Authenticated - let the request continue to the actual servlet
            chain.doFilter(req, res);
        } else {
            // Not authenticated - redirect to login instead of proceeding.
            // Using the full context path ensures this works no matter
            // which admin URL was originally requested.
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}