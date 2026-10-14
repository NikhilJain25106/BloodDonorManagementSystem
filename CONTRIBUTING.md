# Contributing to LifeDrop

Thank you for your interest in contributing to **LifeDrop - Blood Donor Management System**! 🩸

LifeDrop is an open-source platform designed to connect voluntary blood donors with recipients and healthcare centers in urgent need of life-saving donations. Contributions of all kinds—bug reports, documentation enhancements, design improvements, and feature pull requests—are warmly welcomed.

---

## Code of Conduct

All contributors and participants are expected to adhere to our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it to ensure a respectful and welcoming environment for everyone.

---

## Getting Started

### Prerequisites

Make sure you have installed:
- **Java Development Kit (JDK) 17+**
- **Apache Maven 3.8+**
- **MySQL Server 8.0+**
- A modern web browser and IDE (IntelliJ IDEA, Eclipse, or VS Code)

### Setting Up Local Environment

1. **Fork and Clone the Repository**
   ```bash
   git clone https://github.com/NikhilJain25106/BloodDonorManagementSystem.git
   cd BloodDonorManagementSystem
   ```

2. **Database Setup**
   - Open MySQL client or workbench and execute:
     ```sql
     CREATE DATABASE blood_donor_db;
     ```
   - Import the schema from [database/schema.sql](database/schema.sql):
     ```bash
     mysql -u root -p blood_donor_db < database/schema.sql
     ```

3. **Configure Environment**
   - Copy `.env.example` to `.env` or set environment variables `MYSQLHOST`, `MYSQLUSER`, `MYSQLPASSWORD`, `MYSQLDATABASE`.

4. **Build and Run**
   ```bash
   mvn clean compile
   mvn package
   java -jar target/BloodDonorManagementSystem.jar
   ```
   Open your browser to `http://localhost:8080/`.

---

## Development Workflow

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

2. **Commit your changes**:
   - Write meaningful, clear commit messages:
     ```bash
     git commit -m "feat: add SMS notification hook for urgent blood requests"
     git commit -m "fix: resolve date formatting on donor certificate"
     ```

3. **Run tests & verify build**:
   ```bash
   mvn test
   ```

4. **Submit a Pull Request**:
   - Push your branch to GitHub:
     ```bash
     git push origin feature/your-feature-name
     ```
   - Open a Pull Request against the `main` branch.
   - Describe what problem your PR solves and reference any open issues (`Fixes #12`).

---

## Coding Standards

- **Java**: Follow standard Java naming conventions (CamelCase for classes, lowerCamelCase for methods/variables).
- **Security**: Never hardcode credentials, passwords, or API keys. Always use parameterized JDBC queries (`PreparedStatement`) to prevent SQL injection.
- **Frontend**: Keep JSP pages responsive, accessible, and aligned with LifeDrop's visual design system.
- **Formatting**: Respect rules defined in `.editorconfig`.

---

## Reporting Issues

- Search existing issues before creating a new one to avoid duplicates.
- Use our issue templates for [Bug Reports](.github/ISSUE_TEMPLATE/bug_report.md) or [Feature Requests](.github/ISSUE_TEMPLATE/feature_request.md).
- Include steps to reproduce, expected behavior, screenshots if applicable, and browser/system details.

Thank you for helping us make blood donation management easier and faster! ❤️
