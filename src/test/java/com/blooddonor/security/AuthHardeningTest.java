package com.blooddonor.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Authentication Security & Hardening Test Suite")
public class AuthHardeningTest {

    private RateLimiterAndLockoutService securityService;

    @BeforeEach
    public void setUp() {
        securityService = RateLimiterAndLockoutService.getInstance();
        securityService.setDelayEnabled(false);
    }

    // =========================================================================
    // 1. Server-Side Validation Tests
    // =========================================================================

    @Test
    @DisplayName("Should validate and sanitize valid emails")
    public void testEmailValidationSuccess() {
        String sanitized = AuthInputValidator.validateAndSanitizeEmail("  User.Test+Tag@example.COM ");
        assertEquals("user.test+tag@example.com", sanitized);
    }

    @ParameterizedTest
    @ValueSource(strings = {"invalid-email", "missing@tld", "@domain.com", "user@.com", "", "   "})
    @DisplayName("Should reject invalid or malicious email formats")
    public void testEmailValidationFailure(String invalidEmail) {
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validateAndSanitizeEmail(invalidEmail));
    }

    @ParameterizedTest
    @ValueSource(strings = {"admin", "admin_user", "dr-nikhil.jain", "john_doe99"})
    @DisplayName("Should allow whitelisted username characters (3-30 chars)")
    public void testUsernameValidationSuccess(String username) {
        String clean = AuthInputValidator.validateAndSanitizeUsername(username);
        assertEquals(username, clean);
    }

    @ParameterizedTest
    @ValueSource(strings = {"ad", "user<script>", "admin' OR 1=1--", "user name", "admin$#@!", "way_too_long_username_exceeding_thirty_characters_limit"})
    @DisplayName("Should reject usernames violating character whitelist or length bounds")
    public void testUsernameValidationFailure(String invalidUser) {
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validateAndSanitizeUsername(invalidUser));
    }

    @Test
    @DisplayName("Should validate passwords strictly with length bounds (8-128 chars)")
    public void testPasswordValidation() {
        assertEquals("ValidSecret@2026", AuthInputValidator.validatePassword("ValidSecret@2026"));
        // Too short (< 8)
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validatePassword("Short1!"));
        // Null or empty
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validatePassword(""));
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validatePassword(null));
        // Control character rejection
        assertThrows(IllegalArgumentException.class, () -> AuthInputValidator.validatePassword("Pass\u0000word123"));
    }

    @Test
    @DisplayName("Should strip HTML and JavaScript from free-text fields")
    public void testHtmlJsSanitization() {
        String malicious = "<script>alert('xss')</script>Hello <b>World</b><img src=x onerror=alert(1)>";
        String clean = AuthInputValidator.sanitizeFreeText(malicious, 50);
        assertFalse(clean.contains("<script>"));
        assertFalse(clean.contains("<b>"));
        assertFalse(clean.contains("onerror"));
        assertEquals("Hello World", clean);
    }

    // =========================================================================
    // 2. Rate Limiting, Account Lockout & CAPTCHA Tests
    // =========================================================================

    @Test
    @DisplayName("Should enforce max 10 requests per minute per IP")
    public void testIpRateLimiting() {
        String testIp = "192.168.1.100";
        // Reset state for this test IP
        securityService.recordSuccessfulAttempt(null, testIp);

        // First 10 requests should succeed
        for (int i = 1; i <= 10; i++) {
            assertTrue(securityService.checkIpRateLimit(testIp), "Request " + i + " must be allowed");
        }

        // 11th request must be rejected by rate limiter
        assertFalse(securityService.checkIpRateLimit(testIp), "11th request within 1 minute must be rate limited");
    }

    @Test
    @DisplayName("Should lock account for 15 minutes after 5 consecutive failed attempts")
    public void testAccountLockoutAfterFiveFailures() {
        String testAccount = "lockout_test_admin";
        String testIp = "10.0.0.50";
        securityService.resetAccount(testAccount);

        assertFalse(securityService.isAccountLocked(testAccount), "Account should not be locked initially");

        // Record 4 failed attempts - account should still be unlocked
        for (int i = 1; i <= 4; i++) {
            securityService.recordFailedAttempt(testAccount, testIp);
            assertFalse(securityService.isAccountLocked(testAccount), "Account should not lock after attempt " + i);
        }

        // 5th failed attempt triggers lockout
        securityService.recordFailedAttempt(testAccount, testIp);
        assertTrue(securityService.isAccountLocked(testAccount), "Account must be locked after 5 failed attempts");

        // Successful login resets state
        securityService.recordSuccessfulAttempt(testAccount, testIp);
        assertFalse(securityService.isAccountLocked(testAccount), "Successful login must clear lockout state");
    }

    @Test
    @DisplayName("Should trigger CAPTCHA requirement after 3 failed attempts")
    public void testCaptchaTriggerAfterThreeFailures() {
        String testAccount = "captcha_test_user";
        String testIp = "10.0.0.75";
        securityService.resetAccount(testAccount);

        assertFalse(securityService.isCaptchaRequired(testAccount, testIp), "CAPTCHA not required initially");

        securityService.recordFailedAttempt(testAccount, testIp); // 1
        securityService.recordFailedAttempt(testAccount, testIp); // 2
        assertFalse(securityService.isCaptchaRequired(testAccount, testIp), "CAPTCHA not required under 3 attempts");

        securityService.recordFailedAttempt(testAccount, testIp); // 3
        assertTrue(securityService.isCaptchaRequired(testAccount, testIp), "CAPTCHA must be required after 3 failed attempts");
    }

    // =========================================================================
    // 3. Password Hashing & Timing Equalization Tests
    // =========================================================================

    @Test
    @DisplayName("BCrypt hashing must use work factor 12 and built-in salting")
    public void testBcryptWorkFactorAndSalt() {
        String raw = "SecureHospitalPass#2026";
        String hash = PasswordUtil.hashPassword(raw);

        assertNotNull(hash);
        assertTrue(hash.startsWith("$2a$12$") || hash.startsWith("$2b$12$"), "Hash must specify work factor 12");
        assertEquals(60, hash.length());
        assertTrue(PasswordUtil.checkPassword(raw, hash));
        assertFalse(PasswordUtil.checkPassword("WrongPassword", hash));
    }

    @Test
    @DisplayName("Dummy verification must execute without throwing exceptions for timing equalization")
    public void testDummyVerification() {
        assertDoesNotThrow(() -> PasswordUtil.dummyVerify("CandidatePassword123"));
        assertDoesNotThrow(() -> PasswordUtil.dummyVerify(null));
    }
}
