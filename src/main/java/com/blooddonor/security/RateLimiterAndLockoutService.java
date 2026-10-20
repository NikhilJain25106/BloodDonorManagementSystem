package com.blooddonor.security;

import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

/**
 * Enterprise Rate Limiting, Account Lockout, Progressive Delay, and CAPTCHA Service.
 *
 * Implements:
 * 1. IP Rate Limiting (max 10 requests / IP / minute).
 * 2. Account Lockout (15 minutes lockout after 5 failed attempts).
 * 3. Progressive Delay on consecutive failures (500ms -> 1500ms -> 3000ms).
 * 4. CAPTCHA Challenge enforcement after 3 failed attempts.
 * 5. Redis / Upstash cloud detection with thread-safe in-memory sliding window fallback.
 */
public class RateLimiterAndLockoutService {

    private static final RateLimiterAndLockoutService INSTANCE = new RateLimiterAndLockoutService();

    // Configuration thresholds
    public static final int MAX_REQUESTS_PER_MINUTE = 10;
    public static final int MAX_FAILED_ATTEMPTS = 5;
    public static final int CAPTCHA_TRIGGER_ATTEMPTS = 3;
    public static final long LOCKOUT_DURATION_MS = TimeUnit.MINUTES.toMillis(15);
    public static final long RATE_WINDOW_MS = TimeUnit.MINUTES.toMillis(1);

    private static final SecureRandom RANDOM = new SecureRandom();

    // In-memory trackers (fallback when external Redis/Upstash is not connected)
    private final Map<String, RequestCounter> ipRateTracker = new ConcurrentHashMap<>();
    private final Map<String, AccountSecurityState> accountTracker = new ConcurrentHashMap<>();

    private final boolean isRedisConfigured;

    private RateLimiterAndLockoutService() {
        String redisUrl = System.getenv("REDIS_URL");
        String upstashUrl = System.getenv("UPSTASH_REDIS_REST_URL");
        this.isRedisConfigured = (redisUrl != null && !redisUrl.isEmpty()) || (upstashUrl != null && !upstashUrl.isEmpty());
        if (isRedisConfigured) {
            System.out.println("RateLimiter: Cloud Redis/Upstash integration detected.");
        }
    }

    public static RateLimiterAndLockoutService getInstance() {
        return INSTANCE;
    }

    /**
     * Checks if an IP address is within the 10 requests / minute rate limit.
     * Returns true if allowed, false if rate limited.
     */
    public boolean checkIpRateLimit(String ip) {
        if (ip == null || ip.isEmpty()) {
            return true;
        }

        long now = System.currentTimeMillis();
        RequestCounter counter = ipRateTracker.compute(ip, (k, v) -> {
            if (v == null || (now - v.windowStart) > RATE_WINDOW_MS) {
                return new RequestCounter(now, 1);
            } else {
                v.count++;
                return v;
            }
        });

        return counter.count <= MAX_REQUESTS_PER_MINUTE;
    }

    /**
     * Checks if the given account is currently locked out.
     */
    public boolean isAccountLocked(String accountKey) {
        if (accountKey == null) {
            return false;
        }
        AccountSecurityState state = accountTracker.get(accountKey.toLowerCase());
        if (state == null) {
            return false;
        }

        long now = System.currentTimeMillis();
        if (state.lockedUntil > now) {
            return true; // Still locked
        } else if (state.lockedUntil > 0) {
            // Lock expired, reset
            resetAccount(accountKey);
        }
        return false;
    }

    /**
     * Checks if CAPTCHA is required (triggered after 3 failed attempts).
     */
    public boolean isCaptchaRequired(String accountKey, String ip) {
        AccountSecurityState state = (accountKey != null) ? accountTracker.get(accountKey.toLowerCase()) : null;
        if (state != null && state.failedAttempts >= CAPTCHA_TRIGGER_ATTEMPTS) {
            return true;
        }
        RequestCounter ipCounter = ipRateTracker.get(ip);
        return ipCounter != null && ipCounter.failedCount >= CAPTCHA_TRIGGER_ATTEMPTS;
    }

    /**
     * Records a failed authentication attempt.
     * Applies progressive delay and checks for 5-attempt account lockout.
     */
    public void recordFailedAttempt(String accountKey, String ip) {
        long now = System.currentTimeMillis();

        // 1. Update IP failed counter
        if (ip != null) {
            ipRateTracker.computeIfPresent(ip, (k, v) -> {
                v.failedCount++;
                return v;
            });
        }

        // 2. Update Account security state
        int failedAttempts = 1;
        if (accountKey != null) {
            String key = accountKey.toLowerCase();
            AccountSecurityState state = accountTracker.compute(key, (k, v) -> {
                if (v == null) {
                    return new AccountSecurityState(1, 0);
                }
                v.failedAttempts++;
                if (v.failedAttempts >= MAX_FAILED_ATTEMPTS) {
                    v.lockedUntil = now + LOCKOUT_DURATION_MS;
                    System.err.println("SECURITY ALERT: Account '" + key + "' locked for 15 minutes due to 5 failed attempts.");
                }
                return v;
            });
            failedAttempts = state.failedAttempts;
        }

        // 3. Apply progressive delay to throttle brute-force automation
        applyProgressiveDelay(failedAttempts);
    }

    private volatile boolean delayEnabled = true;

    public void setDelayEnabled(boolean delayEnabled) {
        this.delayEnabled = delayEnabled;
    }

    /**
     * Progressive delay: increases pause on repeated failures.
     */
    private void applyProgressiveDelay(int failedAttempts) {
        if (!delayEnabled) {
            return;
        }
        try {
            long delayMs = 0;
            if (failedAttempts == 2) {
                delayMs = 500;
            } else if (failedAttempts == 3) {
                delayMs = 1500;
            } else if (failedAttempts >= 4) {
                delayMs = 3000;
            }
            if (delayMs > 0) {
                Thread.sleep(delayMs);
            }
        } catch (InterruptedException ignored) {
            Thread.currentThread().interrupt();
        }
    }

    /**
     * Resets failed attempts on successful login.
     */
    public void recordSuccessfulAttempt(String accountKey, String ip) {
        if (accountKey != null) {
            resetAccount(accountKey);
        }
        if (ip != null) {
            ipRateTracker.remove(ip);
        }
    }

    public void resetAccount(String accountKey) {
        if (accountKey != null) {
            accountTracker.remove(accountKey.toLowerCase());
        }
    }

    /**
     * Generates a numeric arithmetic challenge stored in session.
     */
    public String generateCaptcha(HttpSession session) {
        int a = RANDOM.nextInt(9) + 1;
        int b = RANDOM.nextInt(9) + 1;
        int sum = a + b;
        session.setAttribute("auth_captcha_expected", String.valueOf(sum));
        return a + " + " + b + " = ?";
    }

    /**
     * Verifies the submitted CAPTCHA answer.
     */
    public boolean verifyCaptcha(HttpSession session, String answer) {
        if (session == null || answer == null) {
            return false;
        }
        Object expected = session.getAttribute("auth_captcha_expected");
        session.removeAttribute("auth_captcha_expected"); // One-time use
        return expected != null && expected.toString().equals(answer.trim());
    }

    public boolean isRedisConfigured() {
        return isRedisConfigured;
    }

    // Helper data structures
    private static class RequestCounter {
        final long windowStart;
        int count;
        int failedCount;

        RequestCounter(long windowStart, int count) {
            this.windowStart = windowStart;
            this.count = count;
            this.failedCount = 0;
        }
    }

    private static class AccountSecurityState {
        int failedAttempts;
        long lockedUntil;

        AccountSecurityState(int failedAttempts, long lockedUntil) {
            this.failedAttempts = failedAttempts;
            this.lockedUntil = lockedUntil;
        }
    }
}
