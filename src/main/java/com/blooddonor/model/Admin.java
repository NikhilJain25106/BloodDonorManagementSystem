package com.blooddonor.model;

/**
 * Represents a single row from the "admin_users" table.
 * Note: passwordHash holds a BCrypt hash, never a plain-text password.
 */
public class Admin {

    private int adminId;
    private String username;
    private String passwordHash;
    private String fullName;

    public Admin() {
    }

    public Admin(String username, String passwordHash, String fullName) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}