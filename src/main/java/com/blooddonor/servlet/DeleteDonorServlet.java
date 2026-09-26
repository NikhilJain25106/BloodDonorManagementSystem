package com.blooddonor.servlet;

import com.blooddonor.dao.DonorDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Deletes a single donor. Protected by AdminAuthFilter (matches
 * "/deleteDonor" in its urlPatterns), so this code only ever runs for
 * a logged-in admin.
 *
 * Uses GET here for simplicity (a link with ?id=5 from the dashboard
 * table), which is a common simplification in student projects. Note
 * for your report: a stricter production app would use POST with a
 * confirmation step for any destructive action, since GET requests
 * can be triggered accidentally (e.g. a browser prefetching a link,
 * or the URL being shared/bookmarked). We mitigate this partially
 * with a JavaScript confirm() dialog in the dashboard JSP (Step 9).
 */
@WebServlet("/deleteDonor")
public class DeleteDonorServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("adminDashboard");
            return;
        }

        try {
            int donorId = Integer.parseInt(idParam);
            donorDAO.deleteDonor(donorId);
        } catch (NumberFormatException e) {
            // Invalid id format - silently ignore and just go back to
            // the dashboard rather than showing a raw error page.
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminDashboard");
    }
}