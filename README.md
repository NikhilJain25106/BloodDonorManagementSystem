# LifeDrop - Blood Donor Management System

A full-stack Blood Donor Management System built as a Java college mini-project.

## Tech Stack
- **Backend:** Java Servlets, JDBC
- **Frontend:** JSP, Bootstrap 5, Font Awesome 6
- **Database:** MySQL 8
- **Server:** Apache Tomcat 9
- **Security:** BCrypt password hashing, Session authentication, PreparedStatement (SQL injection prevention)
- **Build:** Maven

## Features
- Donor registration with duplicate check (phone/email)
- Search donors by blood group and city
- Blood type compatibility chart
- Admin login with BCrypt authentication
- Admin dashboard with full CRUD (Create, Read, Update, Delete)
- Session-based authentication with filter protection
- Responsive design - works on mobile and desktop
- Contact page
- FAQ section

## Project Structure

src/main/java/com/blooddonor/
├── model/ → Donor.java, Admin.java
├── dao/ → DonorDAO.java, AdminDAO.java
├── servlet/ → RegisterDonorServlet, SearchDonorServlet,
│ AdminLoginServlet, AdminDashboardServlet,
│ UpdateDonorServlet, DeleteDonorServlet,
│ AdminLogoutServlet
├── filter/ → AdminAuthFilter.java
└── util/ → DBConnection.java, PasswordUtil.java

src/main/webapp/
├── index.jsp → Home page
├── register.jsp → Donor registration form
├── search.jsp → Search donors page
├── admin-login.jsp → Admin login
├── admin-dashboard.jsp → Admin CRUD dashboard
├── edit-donor.jsp → Edit donor form
├── contact.jsp → Contact page
├── includes/ → header.jsp, footer.jsp
└── assets/css/ → style.css


## Setup Instructions

### Prerequisites
- JDK 17
- Apache Tomcat 9
- MySQL 8
- Maven 3.9+

### Database Setup
1. Open MySQL and run:
```sql
source database/schema.sql
```

### Configure Database Password
Open `src/main/java/com/blooddonor/util/DBConnection.java` and update:
```java
private static final String DB_PASSWORD = "your_mysql_password";
```

### Create Admin Account
Run `GenerateAdminHash.java` once to generate a BCrypt hash, then insert the printed SQL into MySQL.

Default credentials: `admin` / `Admin@123`

### Build and Deploy
```bash
mvn clean package
# Copy target/BloodDonorManagementSystem.war to Tomcat webapps/
# Start Tomcat
```

### Access

http://localhost:8080/BloodDonorManagementSystem/


## Developed By
**Nikhil Jain** | Java Mini Project | 2026
