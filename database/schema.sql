-- =====================================================================
-- Blood Donor Management System - Database Schema
-- =====================================================================
-- Run this file in MySQL Workbench (or via Get-Content | mysql)
-- to create the database, tables, and starter sample data.
-- =====================================================================

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS blood_donor_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE blood_donor_db;

-- ---------------------------------------------------------------------
-- Table: donors
-- Stores every donor registration submitted via register.jsp
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS donors (
    donor_id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name           VARCHAR(100)    NOT NULL,
    age                 INT             NOT NULL,
    gender              ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_group         ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    phone               VARCHAR(15)     NOT NULL,
    email                VARCHAR(100)    NOT NULL,
    address             VARCHAR(255)    NOT NULL,
    city                VARCHAR(50)     NOT NULL,
    last_donation_date  DATE            NULL,
    created_at          TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_donor_age CHECK (age BETWEEN 18 AND 65),
    CONSTRAINT uq_donor_phone UNIQUE (phone),
    CONSTRAINT uq_donor_email UNIQUE (email)
) ENGINE=InnoDB;

CREATE INDEX idx_donors_blood_group ON donors (blood_group);
CREATE INDEX idx_donors_city ON donors (city);

-- ---------------------------------------------------------------------
-- Table: admin_users
-- Stores admin login credentials. Passwords are BCrypt hashes, NEVER
-- plain text. password_hash is always exactly 60 characters for BCrypt.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admin_users (
    admin_id      INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash CHAR(60)     NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Seed data - sample donors so Search Donors has something to show
-- ---------------------------------------------------------------------
INSERT INTO donors (full_name, age, gender, blood_group, phone, email, address, city, last_donation_date)
VALUES
    ('Rohan Mehta', 28, 'Male', 'O+', '9876543210', 'rohan.mehta@example.com', '12 MG Road', 'Mumbai', '2026-06-15'),
    ('Priya Sharma', 24, 'Female', 'A+', '9876543211', 'priya.sharma@example.com', '45 Park Street', 'Pune', NULL),
    ('Aman Khan', 35, 'Male', 'B-', '9876543212', 'aman.khan@example.com', '7 Lake View', 'Mumbai', '2026-03-02');