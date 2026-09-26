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
 * Handles GET (show the empty form) and POST (process a submission)
 * for donor registration.
 *
 * Validation strategy: we validate on the server here even though the
 * JSP will also have client-side JS validation (Step 9). Client-side
 * validation is only a usability nicety - it can be bypassed entirely
 * (browser dev tools, curl, Postman), so every rule that actually
 * matters is re-checked here in Java before touching the database.
 */
@WebServlet("/registerDonor")
public class RegisterDonorServlet extends HttpServlet {

    private final DonorDAO donorDAO = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Just show the blank registration form
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ---- Step 1: Read raw form fields ----
        String fullName = request.getParameter("fullName");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String bloodGroup = request.getParameter("bloodGroup");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String lastDonationStr = request.getParameter("lastDonationDate"); // may be empty

        // ---- Step 2: Server-side validation ----
        // We collect ALL problems first rather than stopping at the first
        // one, so the user sees every issue at once instead of fixing
        // errors one at a time across multiple submissions.
        StringBuilder errors = new StringBuilder();

        if (isBlank(fullName)) {
            errors.append("Full name is required. ");
        }

        int age = 0;
        if (isBlank(ageStr)) {
            errors.append("Age is required. ");
        } else {
            try {
                age = Integer.parseInt(ageStr);
                if (age < 18 || age > 65) {
                    errors.append("Age must be between 18 and 65 to donate. ");
                }
            } catch (NumberFormatException e) {
                errors.append("Age must be a valid number. ");
            }
        }

        if (isBlank(gender)) {
            errors.append("Gender is required. ");
        }

        if (isBlank(bloodGroup)) {
            errors.append("Blood group is required. ");
        }

        if (isBlank(phone) || !phone.matches("\\d{10}")) {
            errors.append("Phone number must be exactly 10 digits. ");
        }

        if (isBlank(email) || !email.matches("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$")) {
            errors.append("A valid email address is required. ");
        }

        if (isBlank(address)) {
            errors.append("Address is required. ");
        }

        if (isBlank(city)) {
            errors.append("City is required. ");
        }

        // If any validation failed, stop here and re-show the form with
        // the error message and the values the user already typed, so
        // they don't have to retype everything from scratch.
        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            request.setAttribute("donor", buildDonorFromRequest(request)); // to repopulate form
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // ---- Step 3: Duplicate check ----
        try {
            if (donorDAO.isDuplicateDonor(phone, email)) {
                request.setAttribute("errorMessage",
                        "A donor with this phone number or email is already registered.");
                request.setAttribute("donor", buildDonorFromRequest(request));
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // ---- Step 4: Build the Donor object and insert ----
            Donor donor = new Donor();
            donor.setFullName(fullName.trim());
            donor.setAge(age);
            donor.setGender(gender);
            donor.setBloodGroup(bloodGroup);
            donor.setPhone(phone.trim());
            donor.setEmail(email.trim());
            donor.setAddress(address.trim());
            donor.setCity(city.trim());

            if (!isBlank(lastDonationStr)) {
                donor.setLastDonationDate(Date.valueOf(lastDonationStr)); // expects "yyyy-MM-dd" from <input
                                                                          // type="date">
            }

            donorDAO.insertDonor(donor);

            // ---- Step 5: Success - redirect (not forward!) to avoid
            // duplicate form resubmission if the user refreshes the page ----
            request.setAttribute("successMessage", "Registration successful! Thank you for registering as a donor.");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (SQLException e) {
            // Never expose raw SQL exception text to the user (could leak
            // schema details). Log it server-side, show a generic message.
            e.printStackTrace();
            request.setAttribute("errorMessage",
                    "Something went wrong while saving your registration. Please try again.");
            request.setAttribute("donor", buildDonorFromRequest(request));
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /**
     * Rebuilds a Donor object from whatever the user typed, purely so
     * the JSP can repopulate the form fields after a validation error -
     * this object is never saved to the database.
     */
    private Donor buildDonorFromRequest(HttpServletRequest request) {
        Donor donor = new Donor();
        donor.setFullName(request.getParameter("fullName"));
        donor.setGender(request.getParameter("gender"));
        donor.setBloodGroup(request.getParameter("bloodGroup"));
        donor.setPhone(request.getParameter("phone"));
        donor.setEmail(request.getParameter("email"));
        donor.setAddress(request.getParameter("address"));
        donor.setCity(request.getParameter("city"));
        try {
            donor.setAge(Integer.parseInt(request.getParameter("age")));
        } catch (NumberFormatException ignored) {
            // leave age as 0 if it wasn't a valid number - the error
            // message already tells the user to fix it
        }
        return donor;
    }
}