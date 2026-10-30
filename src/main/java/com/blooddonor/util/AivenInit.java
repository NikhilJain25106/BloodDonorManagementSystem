package com.blooddonor.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Utility tool to test and initialize Aiven cloud database directly.
 * Usage: java -cp target/BloodDonorManagementSystem.jar com.blooddonor.util.AivenInit <HOST> <PORT> <DATABASE> <USER> <PASSWORD>
 */
public class AivenInit {
    public static void main(String[] args) {
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQLDATABASE");
        String user = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");

        if (args.length >= 5) {
            host = args[0].trim();
            port = args[1].trim();
            database = args[2].trim();
            user = args[3].trim();
            password = args[4].trim();
        }

        if (host == null || port == null || database == null || user == null || password == null) {
            System.out.println("Please provide connection parameters via environment variables or CLI arguments.");
            return;
        }

        String jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?useSSL=true&sslMode=PREFERRED&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8&autoReconnect=true";

        System.out.println("Connecting to Aiven MySQL: " + host + ":" + port + "/" + database + " (User: " + user + ")...");

        try (Connection conn = DriverManager.getConnection(jdbcUrl, user, password);
             Statement stmt = conn.createStatement()) {

            System.out.println("[SUCCESS] Connected to Aiven MySQL successfully!");

            // 1. Create donors table
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
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "INDEX idx_donors_blood_group (blood_group), "
                    + "INDEX idx_donors_city (city)"
                    + ") ENGINE=InnoDB");
            System.out.println("[OK] Table 'donors' verified/created.");

            // 2. Create admin_users table
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS admin_users ("
                    + "admin_id INT AUTO_INCREMENT PRIMARY KEY, "
                    + "username VARCHAR(50) NOT NULL UNIQUE, "
                    + "password_hash CHAR(60) NOT NULL, "
                    + "full_name VARCHAR(100) NOT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                    + ") ENGINE=InnoDB");
            System.out.println("[OK] Table 'admin_users' verified/created.");

            // 3. Seed admin user
            stmt.executeUpdate("INSERT INTO admin_users (username, password_hash, full_name) "
                    + "VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator') "
                    + "ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");
            System.out.println("[OK] Default admin user seeded (admin / Admin@123).");

            // 4. Seed sample donors
            stmt.executeUpdate("INSERT IGNORE INTO donors (full_name, age, gender, blood_group, phone, email, address, city, last_donation_date) VALUES "
                    + "('Rohan Mehta', 28, 'Male', 'O+', '9876543210', 'rohan.mehta@example.com', '12 MG Road', 'Mumbai', '2026-06-15'), "
                    + "('Priya Sharma', 24, 'Female', 'A+', '9876543211', 'priya.sharma@example.com', '45 Park Street', 'Pune', NULL), "
                    + "('Aman Khan', 35, 'Male', 'B-', '9876543212', 'aman.khan@example.com', '7 Lake View', 'Mumbai', '2026-03-02')");
            System.out.println("[OK] Starter donors seeded.");

            // Verify count
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM donors")) {
                if (rs.next()) {
                    System.out.println("==================================================");
                    System.out.println("  Aiven Cloud MySQL is READY! Total donors: " + rs.getInt("total"));
                    System.out.println("==================================================");
                }
            }

        } catch (Exception e) {
            System.err.println("[ERROR] Failed to connect/initialize Aiven database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

