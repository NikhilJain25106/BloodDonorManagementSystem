package com.blooddonor.servlet;

import com.blooddonor.dao.EmergencyDAO;
import com.blooddonor.model.EmergencyRequest;
import com.blooddonor.security.AuthInputValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/emergency")
public class EmergencyServlet extends HttpServlet {

    private final EmergencyDAO emergencyDAO = new EmergencyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<EmergencyRequest> requests = emergencyDAO.getActiveRequests();
            request.setAttribute("activeRequests", requests);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to load emergency broadcasts: " + e.getMessage());
        }
        request.getRequestDispatcher("/emergency.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String patientName = request.getParameter("patientName");
        String bloodGroup = request.getParameter("bloodGroup");
        String unitsStr = request.getParameter("unitsNeeded");
        String hospitalName = request.getParameter("hospitalName");
        String city = request.getParameter("city");
        String contactPerson = request.getParameter("contactPerson");
        String contactPhone = request.getParameter("contactPhone");
        String urgency = request.getParameter("urgency");

        try {
            patientName = AuthInputValidator.sanitizeFreeText(patientName, 100);
            hospitalName = AuthInputValidator.sanitizeFreeText(hospitalName, 150);
            city = AuthInputValidator.sanitizeFreeText(city, 50);
            contactPerson = AuthInputValidator.sanitizeFreeText(contactPerson, 100);
            contactPhone = AuthInputValidator.validatePhone(contactPhone);
            int units = (unitsStr != null && !unitsStr.isEmpty()) ? Integer.parseInt(unitsStr) : 1;
            if (urgency == null || urgency.isEmpty()) urgency = "Critical";

            EmergencyRequest req = new EmergencyRequest(patientName, bloodGroup, units, hospitalName, city, contactPerson, contactPhone, urgency);
            emergencyDAO.insertRequest(req);

            response.sendRedirect(request.getContextPath() + "/emergency?broadcast=success");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to broadcast emergency: " + e.getMessage());
            doGet(request, response);
        }
    }
}

