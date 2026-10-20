package com.blooddonor.servlet;

import com.blooddonor.dao.DonorDAO;
import com.blooddonor.model.Donor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

/**
 * Handles both showing the edit form pre-filled with a donor's current
 * data (GET, mapped to /editDonor) and saving changes (POST, mapped to
 * /updateDonor). Both URLs are protected by AdminAuthFilter.
 *
 * Reuses the same server-side validation rules as RegisterDonorServlet.
 * In a larger project you'd factor this into a shared validator class
 * to avoid repeating the rules in two places - flagged here as a
 * reasonable next refactor if you extend this project further.
 */
@WebServlet({ "/editDonor", "/updateDonor" })
public class UpdateDonorServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("adminDashboard");
            return;
        }

        try {
            int donorId = Integer.parseInt(idParam);
            Donor donor = donorDAO.getDonorById(donorId);

            if (donor == null) {
                request.setAttribute("errorMessage", "Donor not found.");
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
                return;
            }

            request.setAttribute("donor", donor);
            request.getRequestDispatcher("edit-donor.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("donorId");
        String fullName = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("fullName"), 100);
        String ageStr = request.getParameter("age");
        String gender = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("gender"), 20);
        String bloodGroup = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("bloodGroup"), 10);
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("address"), 255);
        String city = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("city"), 100);
        String lastDonationStr = request.getParameter("lastDonationDate");

        StringBuilder errors = new StringBuilder();
        int donorId = 0;
        int age = 0;

        try {
            donorId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("adminDashboard");
            return;
        }

        if (isBlank(fullName))
            errors.append("Full name is required. ");

        try {
            age = Integer.parseInt(ageStr.trim());
            if (age < 18 || age > 65)
                errors.append("Age must be between 18 and 65. ");
        } catch (NumberFormatException e) {
            errors.append("Age must be a valid number. ");
        }

        if (isBlank(phone) || !phone.trim().matches("\\d{10}")) {
            errors.append("Phone number must be exactly 10 digits. ");
        }

        String sanitizedEmail = null;
        try {
            sanitizedEmail = com.blooddonor.security.AuthInputValidator.validateAndSanitizeEmail(email);
        } catch (IllegalArgumentException e) {
            errors.append("A valid email address is required. ");
        }

        if (isBlank(address))
            errors.append("Address is required. ");
        if (isBlank(city))
            errors.append("City is required. ");

        if (errors.length() > 0) {
            Donor donor = new Donor();
            donor.setDonorId(donorId);
            donor.setFullName(fullName);
            donor.setAge(age);
            donor.setGender(gender);
            donor.setBloodGroup(bloodGroup);
            donor.setPhone(phone != null ? phone.trim() : "");
            donor.setEmail(sanitizedEmail != null ? sanitizedEmail : (email != null ? email.trim() : ""));
            donor.setAddress(address);
            donor.setCity(city);

            request.setAttribute("donor", donor);
            request.setAttribute("errorMessage", errors.toString());
            request.getRequestDispatcher("edit-donor.jsp").forward(request, response);
            return;
        }

        try {
            Donor donor = new Donor();
            donor.setDonorId(donorId);
            donor.setFullName(fullName.trim());
            donor.setAge(age);
            donor.setGender(gender);
            donor.setBloodGroup(bloodGroup);
            donor.setPhone(phone.trim());
            donor.setEmail(email.trim());
            donor.setAddress(address.trim());
            donor.setCity(city.trim());

            if (!isBlank(lastDonationStr)) {
                donor.setLastDonationDate(Date.valueOf(lastDonationStr));
            }

            donorDAO.updateDonor(donor);
            response.sendRedirect("adminDashboard");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Update failed due to a server error.");
            request.getRequestDispatcher("edit-donor.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}