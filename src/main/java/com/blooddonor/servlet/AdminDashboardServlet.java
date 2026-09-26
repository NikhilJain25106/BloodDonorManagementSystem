package com.blooddonor.servlet;

import com.blooddonor.dao.DonorDAO;
import com.blooddonor.model.Donor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Shows the full donor list to a logged-in admin, including contact
 * details (phone/email) that the public search page deliberately
 * hides. This servlet itself does NOT check the session - that check
 * already happened in AdminAuthFilter before this servlet's code even
 * runs. Keeping the auth check in the filter (not duplicated here)
 * means every admin-only servlet is protected the same way from one
 * central place.
 */
@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Donor> donors = donorDAO.getAllDonors();
            request.setAttribute("donors", donors);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load donor list.");
        }

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}