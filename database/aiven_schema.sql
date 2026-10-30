-- =====================================================================
-- LifeDrop - Aiven Cloud MySQL Initializer & Schema Setup
-- Database: defaultdb
-- =====================================================================

-- 1. Table: donors
CREATE TABLE IF NOT EXISTS donors (
    donor_id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name           VARCHAR(100)    NOT NULL,
    age                 INT             NOT NULL,
    gender              ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_group         ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-') NOT NULL,
    phone               VARCHAR(15)     NOT NULL,
    email               VARCHAR(100)    NOT NULL,
    address             VARCHAR(255)    NOT NULL,
    city                VARCHAR(50)     NOT NULL,
    last_donation_date  DATE            NULL,
    created_at          TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_donor_age CHECK (age BETWEEN 18 AND 65),
    CONSTRAINT uq_donor_phone UNIQUE (phone),
    CONSTRAINT uq_donor_email UNIQUE (email),
    INDEX idx_donors_blood_group (blood_group),
    INDEX idx_donors_city (city),
    INDEX idx_donors_search_composite (blood_group, city, last_donation_date),
    INDEX idx_donors_created_at (created_at DESC)
) ENGINE=InnoDB;

-- 2. Table: admin_users
CREATE TABLE IF NOT EXISTS admin_users (
    admin_id      INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash CHAR(60)     NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Seed Default Administrator (Username: admin | Password: Admin@123)
INSERT INTO admin_users (username, password_hash, full_name)
VALUES ('admin', '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe', 'System Administrator')
ON DUPLICATE KEY UPDATE full_name=VALUES(full_name);

-- 4. Seed Starter Donors
INSERT IGNORE INTO donors (full_name, age, gender, blood_group, phone, email, address, city, last_donation_date)
VALUES
    ('Rohan Mehta', 28, 'Male', 'O+', '9876543210', 'rohan.mehta@example.com', '12 MG Road', 'Mumbai', '2026-06-15'),
    ('Priya Sharma', 24, 'Female', 'A+', '9876543211', 'priya.sharma@example.com', '45 Park Street', 'Pune', NULL),
    ('Aman Khan', 35, 'Male', 'B-', '9876543212', 'aman.khan@example.com', '7 Lake View', 'Mumbai', '2026-03-02');
