package com.blooddonor.servlet;

import com.blooddonor.dao.AdminDAO;
import com.blooddonor.model.Admin;
import com.blooddonor.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles admin login. On success, stores the admin's identity in the
 * HttpSession - this session attribute is what AdminAuthFilter (next
 * file) checks to decide whether a request is allowed into the
 * dashboard, not a JS flag or a hidden form field, which could be
 * faked by anyone.
 */
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If already logged in, skip straight to the dashboard instead
        // of showing the login form again.
        HttpSession session = request.getSession(false); // false = don't create a new one just to check
        if (session != null && session.getAttribute("adminUsername") != null) {
            response.sendRedirect("adminDashboard");
            return;
        }
        request.getRequestDispatcher("admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        try {
            Admin admin = adminDAO.getAdminByUsername(username.trim());

            // Deliberately generic error message whether the username
            // doesn't exist OR the password is wrong - see AdminDAO
            // comments for why this matters.
            boolean loginValid = (admin != null) && PasswordUtil.checkPassword(password, admin.getPasswordHash());

            if (!loginValid) {
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
                return;
            }

            // ---- Login successful: create a session ----
            HttpSession session = request.getSession(true); // true = create if doesn't exist
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("adminFullName", admin.getFullName());
            session.setAttribute("adminId", admin.getAdminId());

            response.sendRedirect("adminDashboard");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed due to a server error. Please try again.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}