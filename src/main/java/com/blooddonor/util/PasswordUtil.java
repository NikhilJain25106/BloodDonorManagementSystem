package com.blooddonor.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Wraps jBCrypt so the rest of the app never touches plain-text
 * passwords or writes its own hashing logic. Always hash before
 * storing, always verify with checkPassword - never compare
 * plain-text strings directly.
 */
public class PasswordUtil {

    /**
     * Hashes a plain-text password for storage in admin_users.password_hash.
     * BCrypt automatically generates and embeds a random salt, so two
     * identical passwords will produce two different hashes - that's
     * expected and correct.
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Verifies a login attempt against the stored hash.
     * Returns true only if the plain-text password matches.
     */
    public static boolean checkPassword(String plainPassword, String storedHash) {
        return BCrypt.checkpw(plainPassword, storedHash);
    }
}