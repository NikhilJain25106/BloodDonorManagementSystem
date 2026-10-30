package com.blooddonor.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBDiagnostic {
    public static void main(String[] args) {
        System.out.println("=================================================");
        System.out.println("    LifeDrop Database Diagnostic & Health Check   ");
        System.out.println("=================================================");

        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("[SUCCESS] Successfully connected to MySQL database!");
            System.out.println("[METADATA] Product: " + conn.getMetaData().getDatabaseProductName());
            System.out.println("[METADATA] Version: " + conn.getMetaData().getDatabaseProductVersion());
            System.out.println("[METADATA] Catalog: " + conn.getCatalog());
            System.out.println();

            try (Statement stmt = conn.createStatement()) {
                // Ensure schema & starter tables exist if database was empty
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

                stmt.executeUpdate("CREATE TABLE IF NOT EXISTS admin_users ("
                        + "admin_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "username VARCHAR(50) NOT NULL UNIQUE, "
                        + "password_hash CHAR(60) NOT NULL, "
                        + "full_name VARCHAR(100) NOT NULL, "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                        + ") ENGINE=InnoDB");

                // Seed default admin if missing
                stmt.executeUpdate("INSERT INTO admin_users (username, password_hash, full_name) "
                        + "VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator') "
                        + "ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");

                // Check Admin Users
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total_admins FROM admin_users")) {
                    if (rs.next()) {
                        System.out.println("[ADMIN USERS] Count in DB: " + rs.getInt("total_admins"));
                    }
                }

                // Check Donors & Dashboard Metrics
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total_donors, "
                        + "SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) AS male_count, "
                        + "SUM(CASE WHEN gender='Female' THEN 1 ELSE 0 END) AS female_count, "
                        + "SUM(CASE WHEN gender='Other' THEN 1 ELSE 0 END) AS other_count "
                        + "FROM donors")) {
                    if (rs.next()) {
                        int total = rs.getInt("total_donors");
                        int male = rs.getInt("male_count");
                        int female = rs.getInt("female_count");
                        int other = rs.getInt("other_count");

                        System.out.println("[DASHBOARD METRICS - CURRENT DB STATE]");
                        System.out.println("  • Total Donors:  " + total);
                        System.out.println("  • Male Donors:   " + male + (total > 0 ? " (" + Math.round(male * 100.0 / total) + "%)" : ""));
                        System.out.println("  • Female Donors: " + female + (total > 0 ? " (" + Math.round(female * 100.0 / total) + "%)" : ""));
                        System.out.println("  • Other Donors:  " + other);
                    }
                }

                // List recent donors
                System.out.println();
                System.out.println("[DONOR RECORDS IN DATABASE]");
                try (ResultSet rs = stmt.executeQuery("SELECT donor_id, full_name, blood_group, city, phone, email, created_at FROM donors ORDER BY created_at DESC LIMIT 10")) {
                    boolean found = false;
                    while (rs.next()) {
                        found = true;
                        System.out.printf("  #%-3d | %-16s | %-4s | %-10s | %-12s | %-25s | %s%n",
                                rs.getInt("donor_id"),
                                rs.getString("full_name"),
                                rs.getString("blood_group"),
                                rs.getString("city"),
                                rs.getString("phone"),
                                rs.getString("email"),
                                rs.getTimestamp("created_at"));
                    }
                    if (!found) {
                        System.out.println("  (No donor records found in table 'donors')");
                    }
                }
            }

            System.out.println();
            System.out.println("=================================================");
            System.out.println("[RESULT] Database is fully operational & updated.");
            System.out.println("=================================================");
        } catch (Exception e) {
            System.err.println();
            System.err.println("[ERROR] Database connection failed:");
            System.err.println("  Message: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
