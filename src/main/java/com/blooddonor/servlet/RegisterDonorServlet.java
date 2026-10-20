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

        // ---- Step 1: Read and sanitize raw form fields ----
        String fullName = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("fullName"), 100);
        String ageStr = request.getParameter("age");
        String gender = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("gender"), 20);
        String bloodGroup = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("bloodGroup"), 10);
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("address"), 255);
        String city = com.blooddonor.security.AuthInputValidator.sanitizeFreeText(request.getParameter("city"), 100);
        String lastDonationStr = request.getParameter("lastDonationDate"); // may be empty

        // ---- Step 2: Server-side validation ----
        StringBuilder errors = new StringBuilder();

        if (isBlank(fullName)) {
            errors.append("Full name is required. ");
        }

        int age = 0;
        if (isBlank(ageStr)) {
            errors.append("Age is required. ");
        } else {
            try {
                age = Integer.parseInt(ageStr.trim());
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

        if (isBlank(phone) || !phone.trim().matches("\\d{10}")) {
            errors.append("Phone number must be exactly 10 digits. ");
        }

        String sanitizedEmail = null;
        try {
            sanitizedEmail = com.blooddonor.security.AuthInputValidator.validateAndSanitizeEmail(email);
        } catch (IllegalArgumentException e) {
            errors.append("A valid email address is required. ");
        }

        if (isBlank(address)) {
            errors.append("Address is required. ");
        }

        if (isBlank(city)) {
            errors.append("City is required. ");
        }

        // Server-side enforcement of statutory DPDP consent and voluntary declaration
        String consentDpdp = request.getParameter("consentDpdp");
        String consentTerms = request.getParameter("consentTerms");
        if (isBlank(consentDpdp) || !"true".equalsIgnoreCase(consentDpdp.trim())) {
            errors.append("You must provide consent under the DPDP Act 2023 to register as a donor. ");
        }
        if (isBlank(consentTerms) || !"true".equalsIgnoreCase(consentTerms.trim())) {
            errors.append("You must agree to the Terms & Conditions and voluntary donation declaration. ");
        }

        // If any validation failed, stop here and re-show the form
        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            request.setAttribute("donor", buildDonorFromRequest(request)); // to repopulate form
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // ---- Step 3: Duplicate check ----
        try {
            if (donorDAO.isDuplicateDonor(phone.trim(), sanitizedEmail)) {
                request.setAttribute("errorMessage",
                        "A donor with this phone number or email is already registered.");
                request.setAttribute("donor", buildDonorFromRequest(request));
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // ---- Step 4: Build the Donor object and insert ----
            Donor donor = new Donor();
            donor.setFullName(fullName);
            donor.setAge(age);
            donor.setGender(gender);
            donor.setBloodGroup(bloodGroup);
            donor.setPhone(phone.trim());
            donor.setEmail(sanitizedEmail);
            donor.setAddress(address);
            donor.setCity(city);

            if (!isBlank(lastDonationStr)) {
                donor.setLastDonationDate(Date.valueOf(lastDonationStr.trim()));
            }

            donorDAO.insertDonor(donor);

            // Fetch newly created record and establish donor session
            Donor saved = donorDAO.findByEmailOrPhone(donor.getEmail());
            if (saved != null) {
                javax.servlet.http.HttpSession session = request.getSession(true);
                session.setAttribute("donorId", saved.getDonorId());
                session.setAttribute("donorName", saved.getFullName());
                session.setAttribute("donorEmail", saved.getEmail());
                session.setAttribute("donorBloodGroup", saved.getBloodGroup());
                session.setAttribute("donorUser", saved);
                request.setAttribute("registeredDonor", saved);
            }

            request.setAttribute("successMessage", "Registration successful! Your Personalized Donor ID Card and Certificate are now ready.");
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