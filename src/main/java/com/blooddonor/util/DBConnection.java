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
                jdbcUrl = mysqlUrl;
            }
            isCloudDb = (!"localhost".equalsIgnoreCase(host) && !"127.0.0.1".equals(host) && !"db".equalsIgnoreCase(host));
        }

        if (isCloudDb) {
            // Modern Connector/J 9.2+ parameters for Aiven cloud MySQL
            // Uses sslMode=REQUIRED (uppercase) and enables public key retrieval for caching_sha2_password
            jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?sslMode=REQUIRED&allowPublicKeyRetrieval=true&connectTimeout=30000&socketTimeout=60000&autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Kolkata";
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