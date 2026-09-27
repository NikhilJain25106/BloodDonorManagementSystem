package com.blooddonor.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL;
    private static final String DB_USER;
    private static final String DB_PASSWORD;

    static {
        // Railway provides MYSQL_URL, MYSQLUSER, MYSQLPASSWORD
        // Fall back to local dev values if not set
        String railwayUrl = System.getenv("MYSQL_URL");
        if (railwayUrl != null && !railwayUrl.isEmpty()) {
            DB_URL = railwayUrl + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            DB_USER = System.getenv("MYSQLUSER");
            DB_PASSWORD = System.getenv("MYSQLPASSWORD");
        } else {
            DB_URL = "jdbc:mysql://localhost:3306/blood_donor_db?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
            DB_USER = "root";
            DB_PASSWORD = "@NikhilJain25107045";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
