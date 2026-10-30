<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.blooddonor.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>LifeDrop — Live Database Auto-Seeder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        body { background: #f1f5f9; padding: 40px 15px; font-family: system-ui, sans-serif; }
        .card { border-radius: 12px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
    </style>
</head>
<body>
<div class="container" style="max-width: 800px;">
    <div class="card p-4">
        <h3 class="fw-bold mb-3"><i class="fa-solid fa-seedling text-success me-2"></i>Live Cloud Database Seeder</h3>
        <p class="text-muted">Directly provisions tables and starter sample donors into your live Aiven MySQL cluster.</p>

        <%
            String action = request.getParameter("seed");
            String message = null;
            boolean success = false;
            int totalDonors = 0;

            if ("true".equals(action)) {
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement()) {

                    // 1. Create tables
                    stmt.executeUpdate("CREATE TABLE IF NOT EXISTS admin_users ("
                            + "admin_id INT AUTO_INCREMENT PRIMARY KEY, "
                            + "username VARCHAR(50) NOT NULL UNIQUE, "
                            + "password_hash CHAR(60) NOT NULL, "
                            + "full_name VARCHAR(100) NOT NULL, "
                            + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                            + ") ENGINE=InnoDB");

                    stmt.executeUpdate("CREATE TABLE IF NOT EXISTS donors ("
                            + "donor_id INT AUTO_INCREMENT PRIMARY KEY, "
                            + "full_name VARCHAR(100) NOT NULL, "
                            + "age INT NOT NULL, "
                            + "gender ENUM('Male', 'Female', 'Other') NOT NULL, "
                            + "blood_group ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL, "
                            + "phone VARCHAR(15) NOT NULL UNIQUE, "
                            + "email VARCHAR(100) NOT NULL UNIQUE, "
                            + "address VARCHAR(255) NOT NULL, "
                            + "city VARCHAR(50) NOT NULL, "
                            + "last_donation_date DATE NULL, "
                            + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                            + ") ENGINE=InnoDB");

                    // 2. Insert admin
                    stmt.executeUpdate("INSERT INTO admin_users (username, password_hash, full_name) "
                            + "VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator') "
                            + "ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");

                    // 3. Insert 5 Donors
                    stmt.executeUpdate("INSERT IGNORE INTO donors (full_name, age, gender, blood_group, phone, email, address, city, last_donation_date) VALUES "
                            + "('Rohan Mehta', 28, 'Male', 'O+', '9876543210', 'rohan.mehta@example.com', '12 MG Road', 'Mumbai', '2026-06-15'), "
                            + "('Priya Sharma', 24, 'Female', 'A+', '9876543211', 'priya.sharma@example.com', '45 Park Street', 'Pune', NULL), "
                            + "('Aman Khan', 35, 'Male', 'B-', '9876543212', 'aman.khan@example.com', '7 Lake View', 'Mumbai', '2026-03-02'), "
                            + "('Ananya Deshmukh', 29, 'Female', 'AB+', '9876543213', 'ananya.d@example.com', '88 Bandra West', 'Mumbai', '2026-05-10'), "
                            + "('Vikram Patel', 32, 'Male', 'O-', '9876543214', 'vikram.p@example.com', '14 Shivaji Nagar', 'Pune', '2026-04-18')");

                    success = true;
                    message = "Successfully created tables and inserted 5 voluntary blood donors!";
                } catch (Exception e) {
                    success = false;
                    message = "Error: " + e.getMessage();
                }
            }

            // Check current count
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM donors")) {
                if (rs.next()) {
                    totalDonors = rs.getInt("total");
                }
            } catch (Exception ignored) {}
        %>

        <% if (message != null) { %>
            <div class="alert <%= success ? "alert-success" : "alert-danger" %> mb-4">
                <i class="fa-solid <%= success ? "fa-circle-check" : "fa-triangle-exclamation" %> me-2"></i>
                <%= message %>
            </div>
        <% } %>

        <div class="bg-light p-3 rounded mb-4 d-flex justify-content-between align-items-center">
            <div>
                <strong>Current Donors in Database:</strong>
                <span class="badge bg-primary fs-6 ms-2"><%= totalDonors %></span>
            </div>
            <a href="seed.jsp?seed=true" class="btn btn-success">
                <i class="fa-solid fa-plus me-1"></i>Seed 5 Sample Donors Now
            </a>
        </div>

        <div class="d-flex gap-2">
            <a href="searchDonors" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass me-1"></i>Search Donors Page</a>
            <a href="adminLogin" class="btn btn-outline-dark"><i class="fa-solid fa-gauge me-1"></i>Admin Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>

