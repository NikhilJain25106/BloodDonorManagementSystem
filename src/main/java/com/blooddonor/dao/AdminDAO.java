package com.blooddonor.dao;

import com.blooddonor.model.Admin;
import com.blooddonor.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for the "admin_users" table.
 * Handles looking up an admin's stored password hash by username so
 * AdminLoginServlet can verify it with PasswordUtil.checkPassword().
 *
 * Note: this class never receives or compares plain-text passwords
 * itself - it only fetches the stored hash. The actual verification
 * happens in the servlet using PasswordUtil, keeping password logic
 * out of the DAO and in one dedicated utility class.
 */
public class AdminDAO {

    /**
     * Looks up an admin by username. Returns null if no such username
     * exists - the servlet treats "unknown username" and "wrong
     * password" identically in its error message, so a login attempt
     * can't be used to guess which usernames are valid.
     */
    public Admin getAdminByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM admin_users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPasswordHash(rs.getString("password_hash"));
                    admin.setFullName(rs.getString("full_name"));
                    return admin;
                }
                return null;
            }
        }
    }
}