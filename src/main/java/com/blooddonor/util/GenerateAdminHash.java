package com.blooddonor.util;

/**
 * ONE-TIME USE UTILITY - not part of the running web app.
 *
 * Run this once from VS Code (right-click > Run Java) to generate a
 * real BCrypt hash for your chosen admin password. Copy the printed
 * INSERT statement and run it in MySQL Workbench to create your first
 * admin login. After that, you can ignore or delete this file - the
 * admin dashboard itself never needs it again.
 */
public class GenerateAdminHash {

    public static void main(String[] args) {

        // CHANGE these two values to whatever you want your admin login to be:
        String username = "admin";
        String plainPassword = "Admin@123";
        String fullName = "System Administrator";

        String hash = PasswordUtil.hashPassword(plainPassword);

        System.out.println("=================================================");
        System.out.println("Copy the line below and run it in MySQL Workbench:");
        System.out.println("=================================================");
        System.out.println(
                "INSERT INTO admin_users (username, password_hash, full_name) VALUES ('"
                        + username + "', '" + hash + "', '" + fullName + "');");
        System.out.println("=================================================");
        System.out.println("Login credentials to use on the Admin Login page:");
        System.out.println("Username: " + username);
        System.out.println("Password: " + plainPassword);
        System.out.println("=================================================");
    }
}