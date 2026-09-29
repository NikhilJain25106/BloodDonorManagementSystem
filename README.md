# LifeDrop - Blood Donor Management System

A full-stack web application to manage blood donors, built as a Java college mini-project from scratch.

## Live Demo

Live Site: https://lifedrop-app.up.railway.app

GitHub: https://github.com/NikhilJain25106/BloodDonorManagementSystem

Admin Login: username = admin | password = Admin@123

## Screenshots

### Home Page
![Home Page](screenshots/home.png)

### Donor Registration
![Register](screenshots/register.png)

### Search Donors
![Search](screenshots/search.png)

### Admin Dashboard
![Dashboard](screenshots/dashboard.png)

## Project Overview

LifeDrop is a Blood Donor Management System that connects blood donors with people who need them. Built entirely from scratch using Java Servlets, JSP, JDBC and MySQL following the MVC architecture pattern.

## Features

- Donor Registration with validation (age 18-65, 10-digit phone, valid email)
- Search Donors by blood group and city
- Blood Compatibility Chart
- Secure Admin Login with BCrypt password hashing
- Admin Dashboard with full CRUD (Create, Read, Update, Delete)
- Session authentication with AdminAuthFilter protection
- SQL Injection prevention via PreparedStatement
- Duplicate donor check (phone and email)
- Contact page
- Responsive Bootstrap 5 UI
- Deployed live on Railway with cloud MySQL

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 17 |
| Web Layer | Java Servlets 4.0 + JSP |
| Database | MySQL 8.0 |
| DB Access | JDBC with PreparedStatement |
| Security | jBCrypt 0.4 |
| Frontend | Bootstrap 5.3 + Font Awesome 6.5 |
| Server | Apache Tomcat 9 |
| Build Tool | Maven 3.9 |
| Deployment | Railway |

## Setup Instructions

### Prerequisites
- JDK 17
- Apache Tomcat 9
- MySQL 8.0
- Maven 3.9+

### Step 1 - Clone
git clone https://github.com/NikhilJain25106/BloodDonorManagementSystem.git

### Step 2 - Database setup
mysql -u root -p < database/schema.sql

### Step 3 - Configure password
Open DBConnection.java and set your MySQL root password in the local fallback.

### Step 4 - Create admin account
Run GenerateAdminHash.java once in VS Code (right-click Run Java).
Copy the INSERT statement and run it in MySQL.

### Step 5 - Build
mvn clean package

### Step 6 - Deploy
Copy target/BloodDonorManagementSystem.war to your Tomcat webapps folder.
Start Tomcat with startup.bat

### Step 7 - Open
http://localhost:8080/BloodDonorManagementSystem/

## Daily Startup
C:\tomcat9\bin\startup.bat

## Security Design

| Threat | Solution |
|--------|----------|
| SQL Injection | PreparedStatement |
| Plain text passwords | BCrypt hashing |
| Unauthorized access | AdminAuthFilter |
| Client-side bypass | Server-side validation |
| Session after logout | session.invalidate() |
| Duplicate registrations | isDuplicateDonor() check |

## Pages

| Page | URL | Access |
|------|-----|--------|
| Home | / | Public |
| Register | /registerDonor | Public |
| Search | /searchDonors | Public |
| Contact | /contact.jsp | Public |
| Admin Login | /adminLogin | Public |
| Dashboard | /adminDashboard | Admin only |
| Edit Donor | /editDonor | Admin only |
| Delete Donor | /deleteDonor | Admin only |

## Developer

Nikhil Jain
GitHub: https://github.com/NikhilJain25106

Built with Java Servlets, JSP, JDBC and MySQL