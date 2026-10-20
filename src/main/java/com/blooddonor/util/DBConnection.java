package com.blooddonor.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Manages database connectivity using HikariCP, an enterprise-grade,
 * high-performance JDBC connection pool.
 *
 * Replaces direct DriverManager connections to prevent TCP handshake
 * overhead on every request and avoid connection exhaustion under load.
 */
public class DBConnection {

    private static final HikariDataSource dataSource;

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

        String jdbcUrl;
        String user;
        String password;

        if (mysqlHost != null && !mysqlHost.isEmpty()) {
            // Railway provides individual environment variables
            String port = (mysqlPort != null) ? mysqlPort : "3306";
            String database = (mysqlDatabase != null) ? mysqlDatabase : "railway";
            jdbcUrl = "jdbc:mysql://" + mysqlHost + ":" + port + "/" + database
                    + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            user = mysqlUser;
            password = mysqlPassword;
        } else if (mysqlUrl != null && !mysqlUrl.isEmpty()) {
            // Fallback: parse from MYSQL_URL if individual vars not available
            String stripped = mysqlUrl.replace("mysql://", "");
            String[] atSplit = stripped.split("@");
            String[] userPass = atSplit[0].split(":");
            String[] hostDb = atSplit[1].split("/");
            String[] hostPort = hostDb[0].split(":");
            String host = hostPort[0];
            String port = (hostPort.length > 1) ? hostPort[1] : "3306";
            String database = hostDb[1];
            jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            user = userPass[0];
            password = userPass[1];
        } else {
            // Local development fallback
            jdbcUrl = "jdbc:mysql://localhost:3306/blood_donor_db"
                    + "?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
            user = "root";
            password = "@NikhilJain25107045";
        }

        HikariDataSource ds = null;
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(jdbcUrl);
            config.setUsername(user);
            config.setPassword(password);
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            // Non-blocking initialization: do not crash JVM if database takes time to connect
            config.setInitializationFailTimeout(-1);

            // Connection pool sizing & timeouts
            config.setMaximumPoolSize(15);
            config.setMinimumIdle(3);
            config.setIdleTimeout(300000);       // 5 minutes
            config.setConnectionTimeout(20000);  // 20 seconds
            config.setMaxLifetime(1200000);      // 20 minutes
            config.setPoolName("LifeDropHikariPool");

            // MySQL statement caching optimizations
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            config.addDataSourceProperty("useServerPrepStmts", "true");

            ds = new HikariDataSource(config);
            System.out.println("HikariCP LifeDropHikariPool initialized successfully.");
        } catch (Exception e) {
            System.err.println("WARN: HikariDataSource initialization failed or delayed: " + e.getMessage());
        }

        dataSource = ds;
    }

    /**
     * Borrows an active connection from the HikariCP connection pool.
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("Database connection pool is not initialized. Please verify MySQL environment variables.");
        }
        return dataSource.getConnection();
    }

    /**
     * Returns the underlying HikariDataSource instance for metrics or health checks.
     */
    public static HikariDataSource getDataSource() {
        return dataSource;
    }
}