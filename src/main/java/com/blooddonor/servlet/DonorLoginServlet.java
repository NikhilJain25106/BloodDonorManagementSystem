package com.blooddonor.servlet;

import com.blooddonor.dao.DonorDAO;
import com.blooddonor.model.Donor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Handles donor / user login.
 * Allows registered donors to access their personalized Digital Donor Card,
 * update donation records, and generate/download their Donation Certificate.
 */
@WebServlet("/donorLogin")
public class DonorLoginServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("donorId") != null) {
            response.sendRedirect(request.getContextPath() + "/donorCard");
            return;
        }
        request.getRequestDispatcher("donor-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identifier = request.getParameter("identifier");

        if (identifier == null || identifier.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter your registered email address or phone number.");
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
            return;
        }

        try {
            Donor donor = donorDAO.findByEmailOrPhone(identifier.trim());

            if (donor == null) {
                request.setAttribute("errorMessage", "No donor record found for '" + identifier.trim() + "'. Please check the details or register as a new donor.");
                request.setAttribute("enteredIdentifier", identifier.trim());
                request.getRequestDispatcher("donor-login.jsp").forward(request, response);
                return;
            }

            // Login successful: initialize donor session
            HttpSession session = request.getSession(true);
            session.setAttribute("donorId", donor.getDonorId());
            session.setAttribute("donorName", donor.getFullName());
            session.setAttribute("donorEmail", donor.getEmail());
            session.setAttribute("donorBloodGroup", donor.getBloodGroup());
            session.setAttribute("donorUser", donor);

            response.sendRedirect(request.getContextPath() + "/donorCard");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed due to a database error. Please try again.");
            request.getRequestDispatcher("donor-login.jsp").forward(request, response);
        }
    }
}
