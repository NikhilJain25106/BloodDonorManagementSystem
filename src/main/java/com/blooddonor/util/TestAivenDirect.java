package com.blooddonor.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestAivenDirect {
    public static void main(String[] args) {
        System.out.println("Testing DBConnection with current configuration...");
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("Connected to: " + conn.getMetaData().getURL());
            try (Statement stmt = conn.createStatement()) {
                // Ensure tables exist in defaultdb
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

                stmt.executeUpdate("INSERT INTO admin_users (username, password_hash, full_name) "
                        + "VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator') "
                        + "ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");

                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM admin_users")) {
                    if (rs.next()) {
                        System.out.println("Total Admins in DB: " + rs.getInt("cnt"));
                    }
                }
            }
            System.out.println("SUCCESS: Database initialized & admin user is ready!");
        } catch (Exception e) {
            System.err.println("FAILED: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

