package com.blooddonor.util;

/**
 * Backward compatibility wrapper delegating to hardened com.blooddonor.security.PasswordUtil.
 */
public class PasswordUtil {

    public static String hashPassword(String plainPassword) {
        return com.blooddonor.security.PasswordUtil.hashPassword(plainPassword);
    }

    public static boolean checkPassword(String plainPassword, String storedHash) {
        return com.blooddonor.security.PasswordUtil.checkPassword(plainPassword, storedHash);
    }

    public static void dummyVerify(String candidatePassword) {
        com.blooddonor.security.PasswordUtil.dummyVerify(candidatePassword);
    }
}