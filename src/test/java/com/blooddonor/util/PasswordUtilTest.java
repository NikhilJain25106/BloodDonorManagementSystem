package com.blooddonor.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Password Utility BCrypt Tests")
public class PasswordUtilTest {

    @Test
    @DisplayName("Should hash password and successfully verify with correct plain-text")
    public void testHashAndVerifySuccess() {
        String rawPassword = "AdminSecurePassword@2026";
        String hashed = PasswordUtil.hashPassword(rawPassword);

        assertNotNull(hashed);
        assertTrue(hashed.startsWith("$2a$") || hashed.startsWith("$2b$"));
        assertEquals(60, hashed.length(), "BCrypt hash length must always be 60 characters");

        assertTrue(PasswordUtil.checkPassword(rawPassword, hashed), "Matching password must verify to true");
    }

    @Test
    @DisplayName("Should reject verification when wrong password is supplied")
    public void testVerifyFailureOnWrongPassword() {
        String rawPassword = "CorrectPassword123";
        String hashed = PasswordUtil.hashPassword(rawPassword);

        assertFalse(PasswordUtil.checkPassword("WrongPassword456", hashed), "Mismatched password must verify to false");
    }

    @Test
    @DisplayName("Two identical passwords must yield distinct hashes due to random salt")
    public void testRandomSaltGeneration() {
        String rawPassword = "IdenticalPassword!";
        String hash1 = PasswordUtil.hashPassword(rawPassword);
        String hash2 = PasswordUtil.hashPassword(rawPassword);

        assertNotEquals(hash1, hash2, "BCrypt must salt each hash independently");
        assertTrue(PasswordUtil.checkPassword(rawPassword, hash1));
        assertTrue(PasswordUtil.checkPassword(rawPassword, hash2));
    }
}
