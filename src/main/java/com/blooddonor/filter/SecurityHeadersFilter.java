package com.blooddonor.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Enterprise Security Headers Filter.
 * Applies defensive HTTP response headers across all endpoints to protect
 * against Clickjacking, MIME type confusion, XSS, and unauthorized framing.
 */
@WebFilter("/*")
public class SecurityHeadersFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            // Prevent UI redressing and clickjacking
            httpResponse.setHeader("X-Frame-Options", "SAMEORIGIN");

            // Prevent MIME-sniffing vulnerabilities
            httpResponse.setHeader("X-Content-Type-Options", "nosniff");

            // Enable browser reflective XSS filter
            httpResponse.setHeader("X-XSS-Protection", "1; mode=block");

            // Control referrer information leakage
            httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");

            // Restrict sensitive browser features
            httpResponse.setHeader("Permissions-Policy", "camera=(), microphone=(), payment=()");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No cleanup required
    }
}
