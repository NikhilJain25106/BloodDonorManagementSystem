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

    private static volatile HikariDataSource dataSource;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
        initDataSource();
    }

    /**
     * Initializes or re-initializes the HikariCP connection pool.
     * Synchronized to guarantee thread-safe idempotent startup.
     */
    public static synchronized void initDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            return;
        }

        java.util.Map<String, String> dotenv = loadDotEnv();

        String mysqlUrl = getEnvOrProp("MYSQL_URL", dotenv);
        String mysqlUser = getEnvOrProp("MYSQLUSER", dotenv);
        if (mysqlUser == null) mysqlUser = getEnvOrProp("MYSQL_USER", dotenv);
        if (mysqlUser == null) mysqlUser = getEnvOrProp("DB_USER", dotenv);

        String mysqlPassword = getEnvOrProp("MYSQLPASSWORD", dotenv);
        if (mysqlPassword == null) mysqlPassword = getEnvOrProp("MYSQL_PASSWORD", dotenv);
        if (mysqlPassword == null) mysqlPassword = getEnvOrProp("DB_PASSWORD", dotenv);

        String mysqlHost = getEnvOrProp("MYSQLHOST", dotenv);
        if (mysqlHost == null) mysqlHost = getEnvOrProp("MYSQL_HOST", dotenv);
        if (mysqlHost == null) mysqlHost = getEnvOrProp("DB_HOST", dotenv);

        String mysqlPort = getEnvOrProp("MYSQLPORT", dotenv);
        if (mysqlPort == null) mysqlPort = getEnvOrProp("MYSQL_PORT", dotenv);
        if (mysqlPort == null) mysqlPort = getEnvOrProp("DB_PORT", dotenv);

        String mysqlDatabase = getEnvOrProp("MYSQLDATABASE", dotenv);
        if (mysqlDatabase == null) mysqlDatabase = getEnvOrProp("MYSQL_DATABASE", dotenv);
        if (mysqlDatabase == null) mysqlDatabase = getEnvOrProp("DB_NAME", dotenv);

        String host = (mysqlHost != null && !mysqlHost.isEmpty()) ? mysqlHost : "localhost";
        String port = (mysqlPort != null && !mysqlPort.isEmpty()) ? mysqlPort : "3306";
        String defaultDb = (host != null && host.toLowerCase().contains("railway")) ? "railway" : "blood_donor_db";
        String database = (mysqlDatabase != null && !mysqlDatabase.isEmpty()) ? mysqlDatabase : defaultDb;
        String user = (mysqlUser != null && !mysqlUser.isEmpty()) ? mysqlUser : "root";
        String password = (mysqlPassword != null) ? mysqlPassword : "@NikhilJain25107045";

        String jdbcUrl;

        boolean isCloudDb = (!"localhost".equalsIgnoreCase(host) && !"127.0.0.1".equals(host) && !"db".equalsIgnoreCase(host));

        if (mysqlUrl != null && !mysqlUrl.isEmpty()) {
            // Full URL provided (e.g. mysql://user:pass@host:port/dbname)
            if (mysqlUrl.startsWith("mysql://")) {
                String stripped = mysqlUrl.replace("mysql://", "");
                String[] atSplit = stripped.split("@");
                if (atSplit.length > 1) {
                    String[] userPass = atSplit[0].split(":", 2);
                    user = userPass[0];
                    if (userPass.length > 1) {
                        password = userPass[1];
                    }
                    String[] hostDb = atSplit[1].split("/", 2);
                    String[] hostPort = hostDb[0].split(":", 2);
                    host = hostPort[0];
                    if (hostPort.length > 1) {
                        port = hostPort[1];
                    }
                    if (hostDb.length > 1) {
                        database = hostDb[1].split("\\?")[0];
                    }
                }
            } else if (mysqlUrl.startsWith("jdbc:mysql://")) {
                String stripped = mysqlUrl.replace("jdbc:mysql://", "");
                String[] slashSplit = stripped.split("/", 2);
                String[] hostPort = slashSplit[0].split(":", 2);
                host = hostPort[0];
                if (hostPort.length > 1) {
                    port = hostPort[1];
                }
                if (slashSplit.length > 1) {
                    database = slashSplit[1].split("\\?")[0];
                }
            }
            isCloudDb = (!"localhost".equalsIgnoreCase(host) && !"127.0.0.1".equals(host) && !"db".equalsIgnoreCase(host));
        }

        if (isCloudDb) {
            // Standard Aiven cloud parameters compatible with Connector/J 9.2
            // sslMode=PREFERRED enables TLS encryption while accepting cloud proxy certificates without throwing handshake exceptions
            jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?sslMode=PREFERRED&allowPublicKeyRetrieval=true&connectTimeout=30000&socketTimeout=60000&autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Kolkata";
        } else {
            jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?sslMode=DISABLED&allowPublicKeyRetrieval=true&autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Kolkata";
        }

        HikariDataSource ds = null;
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(jdbcUrl);
            config.setUsername(user);
            config.setPassword(password);
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            // Connection pool sizing & timeouts
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(1);
            config.setInitializationFailTimeout(-1); // Prevents app crash on startup if cloud DB has a transient delay
            config.setIdleTimeout(300000);           // 5 minutes
            config.setConnectionTimeout(30000);      // 30 seconds
            config.setMaxLifetime(1200000);          // 20 minutes
            config.setPoolName("LifeDropHikariPool");

            // MySQL statement caching optimizations
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            config.addDataSourceProperty("useServerPrepStmts", "true");

            ds = new HikariDataSource(config);
            System.out.println("=======================================================");
            System.out.println("[LifeDrop DB] HikariCP Connection Pool Initialized!");
            System.out.println("[LifeDrop DB] Target: " + jdbcUrl);
            System.out.println("[LifeDrop DB] User:   " + user);
            System.out.println("=======================================================");

            // Ensure starter schema and starter records exist automatically in cloud database
            try (Connection testConn = ds.getConnection();
                 java.sql.Statement stmt = testConn.createStatement()) {
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

                stmt.executeUpdate("CREATE TABLE IF NOT EXISTS emergency_requests ("
                        + "request_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "patient_name VARCHAR(100) NOT NULL, "
                        + "blood_group ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL, "
                        + "units_needed INT NOT NULL DEFAULT 1, "
                        + "hospital_name VARCHAR(150) NOT NULL, "
                        + "city VARCHAR(50) NOT NULL, "
                        + "contact_person VARCHAR(100) NOT NULL, "
                        + "contact_phone VARCHAR(15) NOT NULL, "
                        + "urgency VARCHAR(50) NOT NULL DEFAULT 'Critical', "
                        + "status VARCHAR(20) NOT NULL DEFAULT 'OPEN', "
                        + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                        + ") ENGINE=InnoDB");

                stmt.executeUpdate("INSERT INTO admin_users (username, password_hash, full_name) "
                        + "VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator') "
                        + "ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");

                stmt.executeUpdate("INSERT IGNORE INTO donors (full_name, age, gender, blood_group, phone, email, address, city, last_donation_date) VALUES "
                        + "('Rohan Mehta', 28, 'Male', 'O+', '9876543210', 'rohan.mehta@example.com', '12 MG Road', 'Mumbai', '2026-06-15'), "
                        + "('Priya Sharma', 24, 'Female', 'A+', '9876543211', 'priya.sharma@example.com', '45 Park Street', 'Pune', NULL), "
                        + "('Aman Khan', 35, 'Male', 'B-', '9876543212', 'aman.khan@example.com', '7 Lake View', 'Mumbai', '2026-03-02'), "
                        + "('Ananya Deshmukh', 29, 'Female', 'AB+', '9876543213', 'ananya.d@example.com', '88 Bandra West', 'Mumbai', '2026-05-10'), "
                        + "('Vikram Patel', 32, 'Male', 'O-', '9876543214', 'vikram.p@example.com', '14 Shivaji Nagar', 'Pune', '2026-04-18')");

                System.out.println("[LifeDrop DB] Schema verified & starter donors seeded successfully!");
            } catch (Exception ex) {
                System.err.println("[LifeDrop DB] Schema auto-creation notice: " + ex.getMessage());
            }
        } catch (Exception e) {
            System.err.println("=======================================================");
            System.err.println("[LifeDrop DB] WARNING: Connection Pool initialization failed or delayed: " + e.getMessage());
            System.err.println("[LifeDrop DB] Target attempted: " + jdbcUrl);
            System.err.println("[LifeDrop DB] User attempted:   " + user);
            System.err.println("=======================================================");
        }

        dataSource = ds;
    }

    /**
     * Resolves configuration key from:
     * 1. System environment variables
     * 2. JVM System properties (-Dkey=value)
     * 3. .env file
     */
    private static String getEnvOrProp(String key, java.util.Map<String, String> dotenv) {
        String val = System.getenv(key);
        if (val != null) {
            return val.trim();
        }
        val = System.getProperty(key);
        if (val != null) {
            return val.trim();
        }
        if (dotenv != null && dotenv.containsKey(key)) {
            val = dotenv.get(key);
            if (val != null) {
                return val.trim();
            }
        }
        return null;
    }

    /**
     * Minimal zero-dependency .env file parser.
     */
    private static java.util.Map<String, String> loadDotEnv() {
        java.util.Map<String, String> envMap = new java.util.HashMap<>();
        String[] candidatePaths = {
            ".env",
            "../.env",
            System.getProperty("user.dir") + java.io.File.separator + ".env"
        };

        for (String path : candidatePaths) {
            java.io.File envFile = new java.io.File(path);
            if (envFile.exists() && envFile.isFile()) {
                try (java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.FileReader(envFile))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        line = line.trim();
                        if (line.isEmpty() || line.startsWith("#")) {
                            continue;
                        }
                        int eqIdx = line.indexOf('=');
                        if (eqIdx > 0) {
                            String k = line.substring(0, eqIdx).trim();
                            String v = line.substring(eqIdx + 1).trim();
                            if ((v.startsWith("\"") && v.endsWith("\"")) || (v.startsWith("'") && v.endsWith("'"))) {
                                v = v.substring(1, v.length() - 1);
                            }
                            envMap.put(k, v);
                        }
                    }
                    System.out.println("[LifeDrop DB] Loaded database settings from " + envFile.getAbsolutePath());
                    break;
                } catch (Exception ignored) {
                }
            }
        }
        return envMap;
    }

    /**
     * Borrows an active connection from the HikariCP connection pool.
     * Automatically attempts to initialize the pool if it hasn't connected yet.
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null || dataSource.isClosed()) {
            initDataSource();
        }
        if (dataSource == null) {
            throw new SQLException("Database connection pool is not initialized. Please verify MySQL configuration.");
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