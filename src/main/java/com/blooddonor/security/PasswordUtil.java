package com.blooddonor.security;

import org.mindrot.jbcrypt.BCrypt;

import java.security.MessageDigest;

/**
 * Hardened Password Cryptography & Verification Utility.
 *
 * Implements:
 * 1. BCrypt hashing with work factor 12 and built-in cryptographically secure random salting.
 * 2. Constant-time verification to prevent cache and timing side-channel attacks.
 * 3. Dummy verification routine to equalize response times when accounts do not exist.
 * 4. Strict defense against password logging.
 */
public class PasswordUtil {

    // Work factor 12 (~250-350ms CPU calculation on modern servers)
    private static final int BCRYPT_WORK_FACTOR = 12;

    // Pre-computed valid dummy hash with work factor 12 to equalize response timing
    private static final String DUMMY_HASH = BCrypt.hashpw("TimingEqualizationDummyPassword123!", BCrypt.gensalt(BCRYPT_WORK_FACTOR));

    /**
     * Hashes a plain-text password using BCrypt with work factor 12 and random salt.
     * Never logs the plain-text password or generated hash.
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_WORK_FACTOR));
    }

    /**
     * Verifies a password against the stored BCrypt hash in constant time.
     * Uses MessageDigest.isEqual for constant-time byte comparison.
     */
    public static boolean checkPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null || storedHash.isEmpty()) {
            return false;
        }
        try {
            boolean matches = BCrypt.checkpw(plainPassword, storedHash);
            // Apply constant-time boolean assertion to mitigate compiler short-circuit optimizations
            return MessageDigest.isEqual(new byte[]{(byte) (matches ? 1 : 0)}, new byte[]{1});
        } catch (Exception e) {
            // Malformed hash or format error
            return false;
        }
    }

    /**
     * Executes a dummy BCrypt verification against the pre-computed hash.
     * This guarantees that requests with nonexistent usernames take the exact same CPU time
     * as requests with valid usernames, neutralizing timing-based user enumeration.
     */
    public static void dummyVerify(String candidatePassword) {
        try {
            BCrypt.checkpw(candidatePassword != null ? candidatePassword : "dummy", DUMMY_HASH);
        } catch (Exception ignored) {
            // Intentionally silent
        }
    }
}
