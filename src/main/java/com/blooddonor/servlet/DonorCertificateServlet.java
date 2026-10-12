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
 * Serves the official Blood Donation Certificate of Appreciation.
 */
@WebServlet("/donorCertificate")
public class DonorCertificateServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer donorId = (session != null) ? (Integer) session.getAttribute("donorId") : null;

        // Admin can also view any donor's certificate via ?id=
        String queryId = request.getParameter("id");
        if (queryId != null && !queryId.trim().isEmpty() && session != null && session.getAttribute("adminUsername") != null) {
            try {
                donorId = Integer.parseInt(queryId.trim());
            } catch (NumberFormatException ignored) {}
        }

        if (donorId == null) {
            response.sendRedirect(request.getContextPath() + "/donorLogin");
            return;
        }

        try {
            Donor donor = donorDAO.getDonorById(donorId);
            if (donor == null) {
                response.sendRedirect(request.getContextPath() + "/donorLogin");
                return;
            }
            request.setAttribute("donor", donor);
            request.getRequestDispatcher("donor-certificate.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error loading certificate.");
        }
    }
}
