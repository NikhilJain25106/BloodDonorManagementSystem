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
import java.sql.Date;
import java.sql.SQLException;

/**
 * Serves the personalized Digital Donor ID Card.
 * Allows donors to view all their details, print/save their official ID card,
 * and record recent blood donations to generate updated certificates.
 */
@WebServlet("/donorCard")
public class DonorCardServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer donorId = (session != null) ? (Integer) session.getAttribute("donorId") : null;

        if (donorId == null) {
            response.sendRedirect(request.getContextPath() + "/donorLogin");
            return;
        }

        try {
            Donor donor = donorDAO.getDonorById(donorId);
            if (donor == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/donorLogin");
                return;
            }
            // Update session with freshest info
            session.setAttribute("donorUser", donor);
            request.setAttribute("donor", donor);
            request.getRequestDispatcher("donor-card.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error loading donor card.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer donorId = (session != null) ? (Integer) session.getAttribute("donorId") : null;

        if (donorId == null) {
            response.sendRedirect(request.getContextPath() + "/donorLogin");
            return;
        }

        String donationDateStr = request.getParameter("lastDonationDate");
        if (donationDateStr != null && !donationDateStr.trim().isEmpty()) {
            try {
                Date donationDate = Date.valueOf(donationDateStr.trim());
                donorDAO.updateLastDonationDate(donorId, donationDate);
                request.getSession().setAttribute("cardSuccess", "Donation recorded successfully! Your updated Certificate of Appreciation is now ready.");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("cardError", "Could not update donation date. Please check the date format.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/donorCard");
    }
}
