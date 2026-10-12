package com.blooddonor.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles donor / user logout.
 */
@WebServlet("/donorLogout")
public class DonorLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("donorId");
            session.removeAttribute("donorName");
            session.removeAttribute("donorEmail");
            session.removeAttribute("donorBloodGroup");
            session.removeAttribute("donorUser");
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
