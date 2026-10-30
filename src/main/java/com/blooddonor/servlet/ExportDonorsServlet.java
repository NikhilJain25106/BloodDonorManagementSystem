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
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Exports all registered voluntary blood donors into a clean, formatted CSV
 * spreadsheet for hospitals, healthcare authorities, and offline records.
 * Accessible to authenticated administrators at /exportDonors
 */
@WebServlet("/exportDonors")
public class ExportDonorsServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUsername") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String filename = "LifeDrop_Donors_" + timestamp + ".csv";

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        try (PrintWriter writer = response.getWriter()) {
            // Write UTF-8 BOM so Excel opens it with proper character encoding
            writer.write('\ufeff');

            // CSV Header
            writer.println("Donor ID,Full Name,Age,Gender,Blood Group,Phone,Email,City,Address,Last Donation Date,Registration Date");

            List<Donor> donors = donorDAO.getAllDonors();
            for (Donor d : donors) {
                writer.printf("%d,\"%s\",%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                        d.getDonorId(),
                        escapeCsv(d.getFullName()),
                        d.getAge(),
                        escapeCsv(d.getGender()),
                        escapeCsv(d.getBloodGroup()),
                        escapeCsv(d.getPhone()),
                        escapeCsv(d.getEmail()),
                        escapeCsv(d.getCity()),
                        escapeCsv(d.getAddress()),
                        d.getLastDonationDate() != null ? d.getLastDonationDate().toString() : "N/A",
                        d.getCreatedAt() != null ? d.getCreatedAt().toString() : "N/A"
                );
            }
        } catch (SQLException e) {
            System.err.println("Failed to export donors CSV: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to generate CSV export");
        }
    }

    private String escapeCsv(String val) {
        if (val == null) return "";
        return val.replace("\"", "\"\"");
    }
}

