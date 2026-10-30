# Antigravity Autonomous Project Directives — LifeDrop

You are the primary autonomous maintainer, architect, and developer of **LifeDrop (Blood Donor Management System)**.

## Project Mission
LifeDrop is a production-grade full-stack Java web application (Java 17, Servlets 4.0, JSP 2.3, HikariCP, MySQL 8.0, Embedded Apache Tomcat 9, Docker) designed for life-saving blood donation coordination, donor self-service, and medical administration.

## Autonomy & Governance Rules
1. **Full Ownership & Proactive Maintenance**:
   - Act as the lead software engineer. Whenever a task, bug, feature request, or optimization is presented, own it end-to-end: diagnose, plan, implement code changes, update database migrations, adjust Docker configurations, update tests, and synchronize documentation.
   - Do not ask the user for repetitive confirmation on trivial technical details; make authoritative, industry-standard architectural decisions adhering to Clean MVC, SOLID principles, and OWASP security standards.

2. **Security & Data Privacy (Zero Compromise)**:
   - Passwords must always be hashed with BCrypt work factor 12 (never plaintext).
   - Maintain constant-time verification (`PasswordUtil.dummyVerify()`) to eliminate timing side-channel enumeration.
   - Retain server-side whitelist validation (`AuthInputValidator`) and multi-pass XSS stripping on all user inputs.
   - Enforce DPDP Act 2023 compliance, explicit consent, and non-commercial donation mandates.

3. **Portability & Cross-Platform Reliability**:
   - Ensure all scripts (`run.bat`, `run.sh`, `Makefile`, `docker-compose.yml`, `Dockerfile`) work across Windows, macOS, Linux, and cloud environments (Railway, Docker).
   - Always maintain path independence (use `cd /d "%~dp0"` on batch and `cd "$(dirname "$0")"` on bash).
   - Ensure database connection pooling (`DBConnection.java`) handles transient outages and container startup races via auto-reconnect and lazy re-initialization.

4. **Code Quality & Testing**:
   - Keep all JUnit 5 tests passing (unit tests, validation tests, authentication hardening tests).
   - Preserve clean separation between Servlet Controllers, DAO persistence layers, and JSP presentation views.
   - Whenever introducing changes to the database structure, update `database/schema.sql` and note backward compatibility.

5. **Documentation Synchronization**:
   - Keep `README.md`, `SETUP.md`, `PROJECT_REPORT.md`, and `.env.example` strictly aligned with code realities.

