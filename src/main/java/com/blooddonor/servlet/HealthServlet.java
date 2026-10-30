package com.blooddonor.servlet;

import com.blooddonor.util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Health check endpoint for Railway, Docker, load balancers, and monitoring.
 * Accessible at /health
 * Validates both HTTP servlet engine and live MySQL database connectivity.
 */
@WebServlet("/health")
public class HealthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        boolean dbOk = false;
        int donorCount = 0;
        String dbError = null;

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM donors")) {
            if (rs.next()) {
                donorCount = rs.getInt("cnt");
            }
            dbOk = true;
        } catch (Exception e) {
            dbError = e.getMessage();
        }

        if (dbOk) {
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write(String.format(
                "{\"status\":\"UP\",\"service\":\"LifeDrop\",\"database\":{\"connected\":true,\"total_donors\":%d}}",
                donorCount
            ));
        } else {
            resp.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            resp.getWriter().write(String.format(
                "{\"status\":\"DEGRADED\",\"service\":\"LifeDrop\",\"database\":{\"connected\":false,\"error\":\"%s\"}}",
                dbError != null ? dbError.replace("\"", "\\\"") : "Connection failed"
            ));
        }
    }
}
