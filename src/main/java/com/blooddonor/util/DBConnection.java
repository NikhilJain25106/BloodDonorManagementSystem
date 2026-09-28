package com.blooddonor.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL;
    private static final String DB_USER;
    private static final String DB_PASSWORD;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }

        String mysqlUrl = System.getenv("MYSQL_URL");
        String mysqlUser = System.getenv("MYSQLUSER");
        String mysqlPassword = System.getenv("MYSQLPASSWORD");
        String mysqlHost = System.getenv("MYSQLHOST");
        String mysqlPort = System.getenv("MYSQLPORT");
        String mysqlDatabase = System.getenv("MYSQLDATABASE");

        if (mysqlHost != null && !mysqlHost.isEmpty()) {
            // Railway provides individual variables - build JDBC URL from parts
            String port = (mysqlPort != null) ? mysqlPort : "3306";
            String database = (mysqlDatabase != null) ? mysqlDatabase : "railway";
            DB_URL = "jdbc:mysql://" + mysqlHost + ":" + port + "/" + database
                   + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            DB_USER = mysqlUser;
            DB_PASSWORD = mysqlPassword;
        } else if (mysqlUrl != null && !mysqlUrl.isEmpty()) {
            // Fallback: parse from MYSQL_URL if individual vars not available
            // Format: mysql://user:password@host:port/database
            String stripped = mysqlUrl.replace("mysql://", "");
            String[] atSplit = stripped.split("@");
            String[] userPass = atSplit[0].split(":");
            String[] hostDb = atSplit[1].split("/");
            String[] hostPort = hostDb[0].split(":");
            String host = hostPort[0];
            String port = (hostPort.length > 1) ? hostPort[1] : "3306";
            String database = hostDb[1];
            DB_URL = "jdbc:mysql://" + host + ":" + port + "/" + database
                   + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            DB_USER = userPass[0];
            DB_PASSWORD = userPass[1];
        } else {
            // Local development fallback
            DB_URL = "jdbc:mysql://localhost:3306/blood_donor_db"
                   + "?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
            DB_USER = "root";
            DB_PASSWORD = "@NikhilJain25107045";
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}