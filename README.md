# 🩸 LifeDrop - Blood Donor Management System

> A full-stack web application to manage blood donors, built as a Java college mini-project from scratch.

![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=java)
![Servlet](https://img.shields.io/badge/Servlet-4.0-blue?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=flat-square&logo=bootstrap)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-yellow?style=flat-square)
![Maven](https://img.shields.io/badge/Maven-3.9-red?style=flat-square)

---

## 🌐 Live Demo

> Run locally at: `http://localhost:8080/BloodDonorManagementSystem/`

---

## 📸 Screenshots

### 🏠 Home Page
![Home Page](screenshots/home.png)

### 📝 Donor Registration
![Register](screenshots/register.png)

### 🔍 Search Donors
![Search](screenshots/search.png)

### 📊 Admin Dashboard
![Dashboard](screenshots/dashboard.png)

---

## 📌 Project Overview

**LifeDrop** is a Blood Donor Management System that connects blood donors with people who need them. It allows donors to register themselves, lets anyone search for donors by blood group and city, and provides a secure admin dashboard to manage all donor records.

This project was built entirely from scratch using **Java Servlets, JSP, JDBC, and MySQL** — following the **MVC (Model-View-Controller)** architecture pattern.

---

## 🌟 Features

### Public Features
- 🏠 **Home Page** — Hero section, quick donor search, blood group browser, compatibility chart, FAQ
- 📝 **Donor Registration** — Register with full validation (age 18-65, 10-digit phone, valid email)
- 🔍 **Search Donors** — Filter by blood group and/or city with partial matching
- 📞 **Contact Page** — Contact form with emergency contact details
- 🩸 **Blood Compatibility Chart** — Shows which blood types can donate/receive from each other
- ✅ **Eligibility Information** — Age, weight, gap between donations criteria

### Admin Features
- 🔐 **Secure Admin Login** — BCrypt password hashing, session authentication
- 📊 **Admin Dashboard** — View all donors with full contact details
- ✏️ **Edit Donor** — Update any donor's information
- 🗑️ **Delete Donor** — Remove donor records with confirmation dialog
- 🚪 **Secure Logout** — Full session invalidation

### Security Features
- 🛡️ **BCrypt Password Hashing** — Admin passwords never stored as plain text
- 💉 **SQL Injection Prevention** — Every query uses PreparedStatement
- 🔒 **Session Authentication** — Server-side session, not client-side JS flags
- 🚧 **AdminAuthFilter** — Centrally blocks all admin URLs without login
- ✔️ **Server-side Validation** — Cannot be bypassed like client-side JS
- 🚫 **Duplicate Check** — Prevents same phone/email registering twice

---

## 🛠️ Tech Stack

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
| IDE | VS Code |

---

## 📁 Project Structure

BloodDonorManagementSystem/
│
├── database/
│ └── schema.sql # MySQL schema + sample data
│
├── screenshots/ # Project screenshots
│
├── src/main/
│ ├── java/com/blooddonor/
│ │ ├── model/
│ │ │ ├── Donor.java # Donor POJO
│ │ │ └── Admin.java # Admin POJO
│ │ │
│ │ ├── dao/
│ │ │ ├── DonorDAO.java # Donor CRUD + search queries
│ │ │ └── AdminDAO.java # Admin login query
│ │ │
│ │ ├── servlet/
│ │ │ ├── RegisterDonorServlet.java # Handles registration form
│ │ │ ├── SearchDonorServlet.java # Handles donor search
│ │ │ ├── AdminLoginServlet.java # Handles admin login
│ │ │ ├── AdminLogoutServlet.java # Invalidates session
│ │ │ ├── AdminDashboardServlet.java# Loads all donors
│ │ │ ├── UpdateDonorServlet.java # Edit + update donor
│ │ │ └── DeleteDonorServlet.java # Delete donor
│ │ │
│ │ ├── filter/
│ │ │ └── AdminAuthFilter.java # Blocks unauthenticated access
│ │ │
│ │ └── util/
│ │ ├── DBConnection.java # JDBC connection helper
│ │ ├── PasswordUtil.java # BCrypt hash + verify
│ │ └── GenerateAdminHash.java # One-time admin setup utility
│ │
│ └── webapp/
│ ├── index.jsp # Home page
│ ├── register.jsp # Donor registration form
│ ├── search.jsp # Search donors page
│ ├── admin-login.jsp # Admin login form
│ ├── admin-dashboard.jsp # Admin CRUD table
│ ├── edit-donor.jsp # Edit donor form
│ ├── contact.jsp # Contact page
│ ├── includes/
│ │ ├── header.jsp # Shared navbar
│ │ └── footer.jsp # Shared footer
│ ├── assets/
│ │ ├── css/style.css # Custom healthcare theme
│ │ └── js/validation.js # Client-side validation
│ └── WEB-INF/
│ └── web.xml # App config + session timeout
│
└── pom.xml # Maven dependencies


---

## 🗄️ Database Schema

### `donors` table
| Column | Type | Description |
|--------|------|-------------|
| donor_id | INT AUTO_INCREMENT | Primary key |
| full_name | VARCHAR(100) | Donor full name |
| age | INT | Age 18-65 enforced |
| gender | ENUM | Male/Female/Other |
| blood_group | ENUM | A+/A-/B+/B-/AB+/AB-/O+/O- |
| phone | VARCHAR(15) UNIQUE | 10-digit phone |
| email | VARCHAR(100) UNIQUE | Email address |
| address | VARCHAR(255) | Street address |
| city | VARCHAR(50) | City |
| last_donation_date | DATE NULL | Nullable |
| created_at | TIMESTAMP | Auto-filled |

### `admin_users` table
| Column | Type | Description |
|--------|------|-------------|
| admin_id | INT AUTO_INCREMENT | Primary key |
| username | VARCHAR(50) UNIQUE | Login username |
| password_hash | CHAR(60) | BCrypt hash |
| full_name | VARCHAR(100) | Display name |
| created_at | TIMESTAMP | Auto-filled |

---

## ⚙️ Setup and Installation

### Prerequisites
- ✅ JDK 17
- ✅ Apache Tomcat 9
- ✅ MySQL 8.0
- ✅ Maven 3.9+
- ✅ VS Code with Extension Pack for Java

### Step 1 — Clone the repository
```bash
git clone https://github.com/NikhilJain25106/BloodDonorManagementSystem.git
cd BloodDonorManagementSystem
```

### Step 2 — Set up the database
```bash
mysql -u root -p < database/schema.sql
```

### Step 3 — Configure database password
Open `src/main/java/com/blooddonor/util/DBConnection.java` and update:
```java
private static final String DB_PASSWORD = "your_mysql_password";
```
Also update the DB_URL timezone if needed:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/blood_donor_db?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
```

### Step 4 — Create admin account
Run `GenerateAdminHash.java` in VS Code (right-click → Run Java).
Copy the printed INSERT statement and run it in MySQL:
```sql
USE blood_donor_db;
-- paste the INSERT statement here
```

### Step 5 — Build the project
```bash
mvn clean package
```

### Step 6 — Deploy to Tomcat
```powershell
copy target\BloodDonorManagementSystem.war C:\tomcat9\webapps\
C:\tomcat9\bin\startup.bat
```

### Step 7 — Open in browser

http://localhost:8080/BloodDonorManagementSystem/


---

## 🔐 Admin Login Details

| Field | Value |
|-------|-------|
| URL | `/adminLogin` |
| Username | `admin` |
| Password | `Admin@123` |

---

## 🚀 Daily Startup

```powershell
C:\tomcat9\bin\startup.bat
```
Then open `http://localhost:8080/BloodDonorManagementSystem/`

---

## 🏗️ MVC Architecture

Browser Request
↓
Servlet (Controller) ← RegisterDonorServlet, SearchDonorServlet etc.

Reads form data
Validates input
Calls DAO
↓
DAO (Data Layer) ← DonorDAO, AdminDAO
PreparedStatement SQL
Returns Model objects
↓
Model (POJO) ← Donor.java, Admin.java
↓
JSP (View) ← register.jsp, search.jsp etc.
Renders HTML
↓
Browser Response

---

## 🛡️ Security Design

| Threat | Solution |
|--------|----------|
| SQL Injection | PreparedStatement — input never concatenated into SQL |
| Plain text passwords | BCrypt hashing with random salt |
| Unauthorized dashboard access | AdminAuthFilter blocks all admin URLs |
| Bypassing client-side validation | All rules re-checked server-side |
| Session after logout | session.invalidate() destroys entire session |
| Duplicate registrations | isDuplicateDonor() checks phone + email |
| Raw SQL errors exposed | Generic message shown, real error logged server-side |

---

## 📄 Pages Reference

| Page | URL | Access |
|------|-----|--------|
| Home | `/` | Public |
| Register Donor | `/registerDonor` | Public |
| Search Donors | `/searchDonors` | Public |
| Contact | `/contact.jsp` | Public |
| Admin Login | `/adminLogin` | Public |
| Admin Dashboard | `/adminDashboard` | Admin only |
| Edit Donor | `/editDonor?id=X` | Admin only |
| Delete Donor | `/deleteDonor?id=X` | Admin only |
| Logout | `/adminLogout` | Admin only |

---

## 👨‍💻 Developer

**Nikhil Jain**
- 🐙 GitHub: [@NikhilJain25106](https://github.com/NikhilJain25106)

---

## 📄 License

This project is built as a college mini-project for educational purposes.

---

*Built with ❤️ using Java Servlets, JSP, JDBC and MySQL*
