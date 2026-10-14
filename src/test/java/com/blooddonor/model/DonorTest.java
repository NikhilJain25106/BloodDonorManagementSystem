package com.blooddonor.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Date;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Donor Model Unit Tests")
public class DonorTest {

    @Test
    @DisplayName("Should create donor with parameterized constructor and verify fields")
    public void testDonorConstructorAndGetters() {
        Date lastDonation = Date.valueOf("2026-01-15");
        Donor donor = new Donor(
                "Jane Doe",
                28,
                "Female",
                "O+",
                "9876543210",
                "jane.doe@example.com",
                "123 MG Road",
                "Bangalore",
                lastDonation
        );

        assertEquals("Jane Doe", donor.getFullName());
        assertEquals(28, donor.getAge());
        assertEquals("Female", donor.getGender());
        assertEquals("O+", donor.getBloodGroup());
        assertEquals("9876543210", donor.getPhone());
        assertEquals("jane.doe@example.com", donor.getEmail());
        assertEquals("123 MG Road", donor.getAddress());
        assertEquals("Bangalore", donor.getCity());
        assertEquals(lastDonation, donor.getLastDonationDate());
    }

    @Test
    @DisplayName("Should set and get donor fields properly using setters")
    public void testDonorSetters() {
        Donor donor = new Donor();
        donor.setDonorId(42);
        donor.setFullName("Rahul Verma");
        donor.setAge(35);
        donor.setGender("Male");
        donor.setBloodGroup("AB-");
        donor.setPhone("9123456789");
        donor.setEmail("rahul.verma@example.com");
        donor.setAddress("45 Park Street");
        donor.setCity("Kolkata");

        assertEquals(42, donor.getDonorId());
        assertEquals("Rahul Verma", donor.getFullName());
        assertEquals(35, donor.getAge());
        assertEquals("Male", donor.getGender());
        assertEquals("AB-", donor.getBloodGroup());
        assertEquals("9123456789", donor.getPhone());
        assertEquals("rahul.verma@example.com", donor.getEmail());
        assertEquals("45 Park Street", donor.getAddress());
        assertEquals("Kolkata", donor.getCity());
    }
}
