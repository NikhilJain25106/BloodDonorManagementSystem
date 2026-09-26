package com.blooddonor.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Central place that opens a JDBC connection to MySQL.
 *
 * IMPORTANT (read before deploying anywhere public):
 * The DB_USER / DB_PASSWORD below are hardcoded for local development
 * convenience, which is normal for a college project running on your
 * own machine. If you ever deploy this to a public server, move these
 * three values out of source code (e.g. into environment variables or
 * a .properties file that is NOT committed to Git) so your database
 * password is never visible in your GitHub repository.
 */
public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/blood_donor_db?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "@NikhilJain25107045";

    static {
        try {
            // Loads the MySQL JDBC driver class so DriverManager knows
            // how to handle "jdbc:mysql://" URLs. Required once per app.
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Check pom.xml dependency.", e);
        }
    }

    /**
     * Opens and returns a new database connection.
     * Caller is responsible for closing it (use try-with-resources).
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
