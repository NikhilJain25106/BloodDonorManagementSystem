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
 * Handles the public Search Donors page. Anyone can search - no login
 * required - since the whole point is letting people in need find
 * donors quickly. We deliberately do NOT expose donor phone/email in
 * the results here (see search.jsp in Step 8) to protect donor privacy
 * from public scraping; only the admin dashboard shows full contact info.
 */
@WebServlet("/searchDonors")
public class SearchDonorServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bloodGroup = request.getParameter("bloodGroup");
        String city = request.getParameter("city");

        // On first visit (no search performed yet), both parameters are
        // null, so we just show the empty search form without querying.
        boolean searchPerformed = (bloodGroup != null || city != null);

        if (searchPerformed) {
            try {
                List<Donor> results = donorDAO.searchDonors(bloodGroup, city);
                request.setAttribute("results", results);
                request.setAttribute("searchPerformed", true);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Search failed. Please try again.");
            }
        }

        // Keep the submitted filter values so the form shows what was
        // searched for, instead of resetting to blank after each search.
        request.setAttribute("selectedBloodGroup", bloodGroup);
        request.setAttribute("selectedCity", city);

        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}