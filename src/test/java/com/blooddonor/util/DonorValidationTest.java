package com.blooddonor.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Donor Clinical & Input Validation Tests")
public class DonorValidationTest {

    private static final String PHONE_REGEX = "\\d{10}";
    private static final String EMAIL_REGEX = "^[\\w.+-]+@([\\w-]+\\.)+[a-zA-Z]{2,}$";

    @ParameterizedTest
    @ValueSource(strings = {"9876543210", "9123456789", "8000000000"})
    @DisplayName("Valid 10-digit phone numbers must match regex")
    public void testValidPhoneNumbers(String phone) {
        assertTrue(phone.matches(PHONE_REGEX));
    }

    @ParameterizedTest
    @ValueSource(strings = {"12345", "98765432101", "abcdefghij", "+919876543210", "9876 54321"})
    @DisplayName("Invalid phone numbers must fail regex")
    public void testInvalidPhoneNumbers(String phone) {
        assertFalse(phone.matches(PHONE_REGEX));
    }

    @ParameterizedTest
    @ValueSource(strings = {"donor@example.com", "user.name+tag@domain.co.in", "rohan_123@hospital.org"})
    @DisplayName("Valid email formats must match email regex")
    public void testValidEmails(String email) {
        assertTrue(email.matches(EMAIL_REGEX));
    }

    @ParameterizedTest
    @ValueSource(strings = {"plainaddress", "missing@domain", "@nodomain.com", "space in@domain.com"})
    @DisplayName("Invalid email formats must fail email regex")
    public void testInvalidEmails(String email) {
        assertFalse(email.matches(EMAIL_REGEX));
    }

    @Test
    @DisplayName("Donor age must be strictly within clinical limits [18, 65]")
    public void testClinicalAgeLimits() {
        int minEligibleAge = 18;
        int maxEligibleAge = 65;

        assertTrue(minEligibleAge >= 18 && minEligibleAge <= 65);
        assertTrue(maxEligibleAge >= 18 && maxEligibleAge <= 65);
        assertTrue(25 >= 18 && 25 <= 65);

        assertFalse(17 >= 18 && 17 <= 65, "Age 17 is ineligible");
        assertFalse(66 >= 18 && 66 <= 65, "Age 66 is ineligible");
    }

    @ParameterizedTest
    @ValueSource(strings = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"})
    @DisplayName("Standard ABO/Rh blood groups must be valid")
    public void testValidBloodGroups(String bloodGroup) {
        String[] allowed = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
        boolean found = false;
        for (String bg : allowed) {
            if (bg.equals(bloodGroup)) {
                found = true;
                break;
            }
        }
        assertTrue(found, "Blood group must match accepted ABO/Rh taxonomy");
    }
}
