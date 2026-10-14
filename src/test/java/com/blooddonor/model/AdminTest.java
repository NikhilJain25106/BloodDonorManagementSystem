package com.blooddonor.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Admin Model Unit Tests")
public class AdminTest {

    @Test
    @DisplayName("Should create admin with constructor and verify fields")
    public void testAdminConstructor() {
        Admin admin = new Admin("admin1", "$2a$10$abcdefghijklmnopqrstuv", "Administrator");
        assertEquals("admin1", admin.getUsername());
        assertEquals("$2a$10$abcdefghijklmnopqrstuv", admin.getPasswordHash());
        assertEquals("Administrator", admin.getFullName());
    }

    @Test
    @DisplayName("Should update admin fields with setters")
    public void testAdminSetters() {
        Admin admin = new Admin();
        admin.setAdminId(1);
        admin.setUsername("system_root");
        admin.setPasswordHash("$2a$10$hashvalue");
        admin.setFullName("Super Admin");

        assertEquals(1, admin.getAdminId());
        assertEquals("system_root", admin.getUsername());
        assertEquals("$2a$10$hashvalue", admin.getPasswordHash());
        assertEquals("Super Admin", admin.getFullName());
    }
}
