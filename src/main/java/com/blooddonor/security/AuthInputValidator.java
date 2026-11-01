package com.blooddonor.security;

import java.util.regex.Pattern;

/**
 * Enterprise Server-Side Validation and Sanitization Engine.
 *
 * Implements strict character whitelisting, length constraints,
 * and HTML/JS sanitization for all authentication and user inputs.
 * Never relies on client-side validation.
 */
public class AuthInputValidator {

    // Strict RFC 5322 compatible email pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,15}$"
    );

    // Whitelist for usernames: alphanumeric, underscore, dot, hyphen (3 to 30 chars)
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_.-]{3,30}$");

    // Whitelist for 10-digit Indian phone numbers
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    // Complete script and style block stripping (including body content)
    private static final Pattern SCRIPT_BLOCK_PATTERN = Pattern.compile("(?is)<script.*?>.*?</script>");
    private static final Pattern STYLE_BLOCK_PATTERN = Pattern.compile("(?is)<style.*?>.*?</style>");

    // HTML tag stripping regex
    private static final Pattern HTML_TAG_PATTERN = Pattern.compile("<[^>]*>");

    // JavaScript protocol or inline handler patterns
    private static final Pattern SCRIPT_PATTERN = Pattern.compile("(?i)(javascript:|onerror=|onload=|onclick=|<script)");

    /**
     * Validates and sanitizes an email address.
     * Returns sanitized email or throws IllegalArgumentException.
     */
    public static String validateAndSanitizeEmail(String email) {
        if (email == null) {
            throw new IllegalArgumentException("Email is required.");
        }
        String clean = email.trim();
        if (clean.length() < 5 || clean.length() > 254) {
            throw new IllegalArgumentException("Email length must be between 5 and 254 characters.");
        }
        if (!EMAIL_PATTERN.matcher(clean).matches()) {
            throw new IllegalArgumentException("Invalid email format.");
        }
        return clean.toLowerCase();
    }

    /**
     * Validates and sanitizes a username.
     * Enforces character whitelist (letters, numbers, underscore, dot, hyphen).
     */
    public static String validateAndSanitizeUsername(String username) {
        if (username == null) {
            throw new IllegalArgumentException("Username is required.");
        }
        String clean = username.trim();
        if (!USERNAME_PATTERN.matcher(clean).matches()) {
            throw new IllegalArgumentException("Username must be 3-30 characters containing only letters, numbers, hyphens, dots, or underscores.");
        }
        return clean;
    }

    /**
     * Validates a password against security constraints.
     * Enforces min 8, max 128 characters to protect against BCrypt DoS and truncation.
     * Rejects control characters and null bytes.
     */
    public static String validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password is required.");
        }
        if (password.length() < 8) {
            throw new IllegalArgumentException("Password must be at least 8 characters long.");
        }
        if (password.length() > 128) {
            throw new IllegalArgumentException("Password exceeds maximum allowable length of 128 characters.");
        }
        // Disallow null bytes or dangerous control characters
        for (char c : password.toCharArray()) {
            if (c < 32 || c == 127) {
                throw new IllegalArgumentException("Password contains invalid control characters.");
            }
        }
        return password;
    }

    /**
     * Validates donor login identifier (either valid 10-digit phone or valid email).
     */
    public static String validateAndSanitizeIdentifier(String identifier) {
        if (identifier == null) {
            throw new IllegalArgumentException("Identifier is required.");
        }
        String clean = sanitizeFreeText(identifier, 100);
        if (clean.isEmpty()) {
            throw new IllegalArgumentException("Identifier cannot be blank.");
        }

        // Check if phone or email
        boolean isPhone = PHONE_PATTERN.matcher(clean).matches();
        boolean isEmail = EMAIL_PATTERN.matcher(clean).matches();

        if (!isPhone && !isEmail) {
            throw new IllegalArgumentException("Identifier must be a valid 10-digit mobile number or email address.");
        }
        return clean;
    }

    /**
     * Validates a 10-digit phone number.
     */
    public static String validatePhone(String phone) {
        if (phone == null) {
            throw new IllegalArgumentException("Phone number is required.");
        }
        String clean = phone.trim().replaceAll("[^0-9]", "");
        if (clean.length() == 12 && clean.startsWith("91")) {
            clean = clean.substring(2);
        } else if (clean.length() == 11 && clean.startsWith("0")) {
            clean = clean.substring(1);
        }
        if (clean.length() != 10) {
            throw new IllegalArgumentException("Phone number must be exactly 10 digits.");
        }
        return clean;
    }

    /**
     * Strips all HTML/JS and harmful control characters from free-text inputs.
     * Protects against Cross-Site Scripting (XSS) and parameter pollution.
     */
    public static String sanitizeFreeText(String input, int maxLength) {
        if (input == null) {
            return "";
        }
        // 1. Strip script and style blocks completely including inner text
        String stripped = SCRIPT_BLOCK_PATTERN.matcher(input).replaceAll("");
        stripped = STYLE_BLOCK_PATTERN.matcher(stripped).replaceAll("");
        // 2. Strip remaining HTML tags
        stripped = HTML_TAG_PATTERN.matcher(stripped).replaceAll("");
        // 3. Strip script protocol or inline handlers
        stripped = SCRIPT_PATTERN.matcher(stripped).replaceAll("");
        // 4. Trim and truncate to maxLength
        stripped = stripped.trim();
        if (stripped.length() > maxLength) {
            stripped = stripped.substring(0, maxLength);
        }
        return stripped;
    }

    /**
     * Resolves the real client IP address, safely checking proxy headers like X-Forwarded-For.
     */
    public static String getClientIp(javax.servlet.http.HttpServletRequest request) {
        if (request == null) return "127.0.0.1";
        String xf = request.getHeader("X-Forwarded-For");
        if (xf != null && !xf.isEmpty()) {
            return xf.split(",")[0].trim();
        }
        return request.getRemoteAddr() != null ? request.getRemoteAddr() : "127.0.0.1";
    }
}
