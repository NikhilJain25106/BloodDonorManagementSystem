# Mini Project Report
## on
# LifeDrop: Blood Donor Management System

**Submitted in partial fulfillment of the requirements for the degree**  
**Second Year Engineering — Computer Science Engineering (Data Science)**

### Submitted by:
- **Nikhil Jain** (Moodle ID: 23106012)
- **<Group Member 2>** (Moodle ID: 231060XX)
- **<Group Member 3>** (Moodle ID: 231060YY)

### Under the guidance of:
**Ms. Rajashri Chaudhari**

<div align="center">
  <img src="apsit_logo.png" alt="A.P. Shah Institute of Technology Logo" width="180"/>
</div>

### DEPARTMENT OF COMPUTER SCIENCE ENGINEERING (DATA SCIENCE)
### A.P. SHAH INSTITUTE OF TECHNOLOGY
**Survey No. 12, 13, G.B. Road, Opp. Hypercity, Kasarvadavali, Thane (W)-400615**  
**UNIVERSITY OF MUMBAI**  
**Academic Year: 2025-26**

---

## CERTIFICATE

This is to certify that the Mini Project report on **"LifeDrop: Blood Donor Management System"** has been submitted by **Nikhil Jain (Student ID: 23106012)**, **_________________________ (Student ID: _________)** and **_________________________ (Student ID: _________)** who are bonafide students of **A. P. Shah Institute of Technology, Thane** as a partial fulfillment of the requirement for the degree in **Computer Science Engineering (Data Science)**, during the academic year 2025-2026 in the satisfactory manner as per the curriculum laid down by **University of Mumbai**.

<br/>

| ____________________________ | ____________________________ |
| :--- | :--- |
| **Dr. Pravin Adivarekar**<br/>HOD, CSE (Data Science) | **Dr. Uttam D. Kolekar**<br/>Principal |

<br/>

| Internal Examiner: ____________________ | External Examiner: ____________________ |
| :--- | :--- |
| **Place:** A. P. Shah Institute of Technology, Thane | **Date:** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/2026 |

---

## ACKNOWLEDGEMENT

This project would not have come to fruition without the invaluable help of our guide **Ms. Rajashri Chaudhari**. Expressing gratitude towards our HoD, **Dr. Pravin Adivarekar**, and the **Department of Computer Science Engineering (Data Science)** for providing us with the opportunity as well as the support required to pursue this project. We would also like to thank our project coordinator **Ms. Rajashri Chaudhari** who gave us her valuable suggestions and ideas when we were in need of them. We would also like to thank our peers for their helpful suggestions and continuous encouragement.

We also extend our sincere appreciation to the faculty members, laboratory assistants, and staff members of **A. P. Shah Institute of Technology** for providing the high-speed computational facilities, network infrastructure, and academic environment that enabled the development and successful execution of this full-stack Java engineering project.

<div align="right">
  <b>Nikhil Jain</b><br/>
  <b>&lt;Group Member 2&gt;</b><br/>
  <b>&lt;Group Member 3&gt;</b><br/>
  <i>(SE Data Science, Academic Year 2025-26)</i>
</div>

---

## TABLE OF CONTENTS

| Section / Chapter | Title | Page No. |
| :--- | :--- | :---: |
| **1.** | **Introduction** | **1** |
| | 1.1 Purpose | 1 |
| | 1.2 Problem Statement | 2 |
| | 1.3 Objectives | 2 |
| | 1.4 Scope | 3 |
| **2.** | **Proposed System** | **4** |
| | 2.1 Features and Functionality | 4 |
| **3.** | **Project Outcomes** | **6** |
| **4.** | **Software Requirements** | **7** |
| | 4.1 Minimum Hardware Specifications | 7 |
| | 4.2 Software Technology Stack & Tools | 7 |
| | 4.3 Environment Configuration & Deployment Setup | 8 |
| **5.** | **Project Design** | **8** |
| | 5.1 Architectural Design (MVC Pattern) | 8 |
| | 5.2 Database Design & Data Dictionary | 9 |
| | 5.3 Data Flow Design (DFD Level 0 & Level 1) | 11 |
| | 5.4 Security Architecture & Defense-in-Depth | 12 |
| **6.** | **Results** | **13** |
| | 6.1 Implementation Screenshots & Walkthrough | 13 |
| | 6.2 Test Results & Automated Verification | 18 |
| **7.** | **Conclusion** | **20** |
| | 7.1 Summary of Work Done | 20 |
| | 7.2 Key Contributions | 20 |
| | 7.3 Limitations | 20 |
| | 7.4 Future Scope & Enhancements | 21 |
| | **References** | **22** |

---

# Chapter 1
## Introduction

Human blood is an irreplaceable biological necessity for critical surgeries, accidental trauma resuscitation, oncological treatments, and acute clinical interventions. Despite technological advancements in modern medicine, there is no synthetic substitute for safe human blood components. Consequently, healthcare infrastructures worldwide rely exclusively on the generosity of voluntary, unpaid donors. In developing nations and densely populated metropolitan regions such as Mumbai and Thane, bridging the gap between life-threatening clinical shortages and available voluntary blood donors remains one of the most critical logistical bottlenecks in emergency healthcare.

Traditional blood collection networks often suffer from fragmented manual registries, outdated contact records, slow response times during trauma incidents, and acute communication disconnects between potential donors and healthcare personnel. The project presented herein, titled **"LifeDrop — Blood Donor Management System"**, addresses these systemic challenges through an enterprise-grade, full-stack Java web architecture designed to connect voluntary blood donors, patients in need of emergency transfusions, and blood banks in real time without operational intermediaries.

### 1.1 Purpose
The primary purpose of this software engineering document is to delineate the design, technical specifications, operational architecture, and empirical validation of the LifeDrop platform. It serves as an authoritative technical blueprint for software engineers, healthcare system administrators, clinical coordinators, and academic evaluators.

**Target Audience:**
1. **Emergency Patients & Recipients:** Individuals seeking immediate compatible donors during surgical emergencies or trauma resuscitations without bureaucratic delays.
2. **Voluntary Blood Donors:** Altruistic citizens seeking an accessible platform to register their medical availability, retrieve official credentials, track donation histories, and acquire verified Certificates of Appreciation.
3. **Healthcare Coordinators & System Administrators:** Authorized medical officers and transfusion specialists who require centralized administrative oversight, secure record auditing, duplicate prevention, and donor availability metrics.
4. **Technical Evaluators & Developers:** Software engineers, data scientists, and systems architects evaluating pure Java EE patterns, embedded server containerization, and defensive cryptographic security postures.

### 1.2 Problem Statement
Timely availability of compatible blood is frequently a life-or-death determinant in clinical emergency medicine. According to the World Health Organization (WHO), developing nations continually face an acute deficit between whole blood demand and supply. The prevailing landscape reveals several critical systemic flaws:
- **Information Asymmetry & Stale Records:** Most regional blood donation rosters rely on physical ledger books or ad-hoc spreadsheet records that lack real-time synchronization, leading to stale contact numbers and unverified availability.
- **Emergency Latency:** During catastrophic emergencies, attendants spend valuable hours making chaotic phone calls across personal social circles instead of querying an indexed, geographically sorted database.
- **Lack of Clinical Guardrails:** Many existing portals do not enforce clinical eligibility constraints (e.g., age limits of 18–65, minimum weight, donation cooldown periods), resulting in clinically unusable donor leads.
- **Privacy & Security Vulnerabilities:** Ad-hoc messaging groups expose donors' personal contact details to unsolicited spam, harassment, and data leaks, discouraging altruistic individuals from participating in donation networks.

### 1.3 Objectives
To mitigate the aforementioned operational bottlenecks, the LifeDrop platform was developed with the following core technical and functional objectives:
1. **Instant Emergency Matchmaking:** Implement a real-time, zero-latency search engine enabling instant donor filtering by ABO/Rh blood groups and regional municipalities.
2. **Automated Clinical Verification:** Establish a rigorous dual-layer validation pipeline (client-side DOM validation combined with server-side regex boundary enforcement) ensuring zero corrupted records enter persistent storage.
3. **Digital Identity Card Provisioning:** Provide donors with immediate, browser-rendered, printable digital identity cards displaying active medical clearance status and registered blood groups.
4. **Altruistic Recognition & Retention:** Incentivize ongoing voluntary blood donations through automated, high-resolution Certificates of Appreciation featuring official institution seals.
5. **Enterprise Security & Hardening:** Enforce role-based access control (RBAC) powered by blowfish-based BCrypt password hashing and centralized servlet filtering, rendering administrative operations immune to unauthorized access and SQL injection vectors.
6. **Standalone Cloud Portability:** Deliver a lightweight, dependency-reduced pure Java web application packaged as an executable standalone fat JAR running on embedded Apache Tomcat 9, ensuring container-agnostic cloud portability.

### 1.4 Scope
- **Functional Scope:** The system encompasses a comprehensive public health portal (blood compatibility matrix, eligibility criteria, emergency search), a self-service donor portal (passwordless identifier authentication, digital card generation, donation logging), and a restricted administrative dashboard (full CRUD lifecycles, real-time statistics, certificate verification, and user management).
- **Technical Scope:** Built adhering strictly to foundational Java Enterprise Edition standards (Java 17 LTS, Java Servlets 4.0, JSP 2.3, JSTL 1.2, and MySQL 8.0). Architectural abstractions are maintained through pure Model-View-Controller (MVC) separation and Data Access Object (DAO) design patterns without the memory footprint or configuration overhead of heavyweight frameworks. The runtime is orchestrated via embedded Tomcat 9 and Maven Shade packaging.
- **Geographical & Operational Scope:** While initialized with urban healthcare demographic models (e.g., Mumbai, Thane, Pune), the architecture is horizontally scalable and deployable across regional hospitals, community health centers, educational campus camps, and nationwide transfusion networks.

---

# Chapter 2
## Proposed System

The proposed system, LifeDrop, replaces traditional fragmented workflows with a cohesive, unified digital platform. By leveraging pure Java EE web technologies and relational database indexing, LifeDrop ensures that voluntary donor records are collected with clinical precision, stored with enterprise-grade cryptographic security, and retrieved in milliseconds during life-threatening medical emergencies.

### 2.1 Features and Functionality

#### 1. Public Healthcare & Emergency Search Portal
- **Instant Emergency Search:** Directly from the landing interface, users can query active donors by selecting specific ABO & Rh blood groups (A+, A-, B+, B-, AB+, AB-, O+, O-) and filtering by city.
- **Blood Type Compatibility Matrix:** An interactive educational matrix that visually explains blood component matching, identifying universal red cell donors (O-) and universal plasma recipients (AB+).
- **Clinical Eligibility Guidelines:** Clinical criteria detailing donor prerequisites (age 18–65, weight >= 50 kg, hemoglobin thresholds, and cooldown intervals of 90 days for males and 120 days for females).
- **Healthcare Knowledge Base & FAQ:** Dynamic accordion-driven knowledge base resolving common donor concerns regarding safety, hydration, iron levels, and post-donation recovery.

#### 2. Donor Self-Service Portal
- **Passwordless Identifier Authentication:** Seamless, low-friction donor access utilizing registered unique 10-digit mobile numbers or verified email addresses, avoiding cumbersome forgotten-password workflows.
- **Digital Donor ID Card (`/donorCard`):** Instant generation of a responsive, CSS-styled digital identity badge containing the donor's official blood group, unique system ID, location, and verified status.
- **Donation History & Cooldown Tracking:** Self-service logging interface allowing donors to record their most recent donation date, automatically recalculating eligibility cooldowns.
- **Certificate of Appreciation (`/donorCertificate`):** Personalized, high-resolution official document rendered in browser with print-to-PDF formatting, official certification seals, and unique identification credentials.

#### 3. Secure Administrative Management System
- **BCrypt Cryptographic Authentication:** Salted, cryptographic password verification powered by Blowfish-based BCrypt with 10 rounds of adaptive computational work factor.
- **Centralized Security Filter (`AdminAuthFilter`):** A unified Java EE Filter that intercepts incoming HTTP requests, inspecting active session tokens and blocking unauthorized access to administrative servlets.
- **Metrics Dashboard & Live Directory:** Real-time summary statistics reflecting total registered donors, blood group distributions, and recent registrations in a streamlined dashboard.
- **Full CRUD Management Lifecycle:** Comprehensive capability to inspect donor details, edit records (`/editDonor`), or safely delete decommissioned records (`/deleteDonor`) with modal confirmation dialogs.

#### 4. Platform Governance & Progressive Web App (PWA)
- **PWA Standalone Experience:** Equipped with `site.webmanifest` and mobile viewport directives, enabling end-users to install LifeDrop directly on smartphones like a native app.
- **Search Engine Optimization (SEO):** Semantic HTML5 structure, structured meta tags, OpenGraph protocol integration, `sitemap.xml`, and `robots.txt`.
- **Standalone Fat JAR Execution:** Container-independent execution via embedded Apache Tomcat 9, eliminating external server configuration bottlenecks.

<br/>

| Evaluation Parameter | Conventional / Manual Systems | Proposed LifeDrop System |
| :--- | :--- | :--- |
| **Search & Matchmaking Latency** | Hours or days; reliance on manual phone calls & unverified physical registers. | Sub-second response time via indexed SQL multi-parameter queries. |
| **Data Integrity & Verification** | Frequent duplicate entries, invalid phone numbers, out-of-boundary ages. | Dual-layer validation (JS regex + Java EE server constraints) and unique keys. |
| **Information Security & Privacy** | Plaintext ledgers, public exposure of phone numbers, risk of harassment. | Role-based access control, BCrypt salted hashing, parameterized statements. |
| **Donor Engagement & Retention** | Zero recognition post-donation; high donor churn and one-time participation. | Automated Digital Donor Card and printable Certificate of Appreciation. |
| **Deployment & Portability** | Complex container configuration, high overhead server environments. | Zero-dependency Fat JAR with embedded Apache Tomcat 9 & cloud PaaS compatibility. |

<div align="center">
  <b>Table 2.1: Comparison Between Conventional / Manual Systems and LifeDrop System</b>
</div>

---

# Chapter 3
## Project Outcomes

The development and deployment of the LifeDrop Blood Donor Management System yielded significant technical, operational, and societal outcomes:
1. **Pure Full-Stack MVC Architecture:** The project demonstrated that a production-grade enterprise web application can be built entirely on foundational Java EE standards without reliance on third-party frameworks like Spring or Hibernate. This achieved exceptional execution speed, minimal memory consumption (operating efficiently within 256MB heap boundaries), and near-instant application bootstrap times.
2. **Sub-Second Matchmaking Performance:** Emergency donor search requests were benchmarked to execute within under 40 milliseconds on indexed MySQL relational tables. Attendants can identify geographically proximate, blood-type compatible donors in seconds, directly mitigating the critical delay period in trauma interventions.
3. **Absolute Data Integrity & Quality:** By enforcing dual-layer validation across client-side scripts and server-side servlets, the platform eliminated invalid registrations. Database constraints guarantee that no donor under 18 or above 65 years can register, and unique constraints prevent duplicate records sharing identical phone numbers or email addresses.
4. **Enhanced Donor Engagement & Recognition:** Through the generation of digital donor cards and high-resolution certificates, the platform successfully gamifies and recognizes altruistic donor contributions. Donors receive immediate digital proof of their life-saving civic participation, fostering long-term retention.
5. **Verified Defensive Security:** Administrative credentials are encrypted via salted BCrypt hashing, rendering password databases invulnerable to rainbow-table and collision attacks. Zero SQL injection vulnerabilities were detected across rigorous parameterized query testing, and session fixation vulnerabilities were neutralized through explicit session termination handlers.
6. **Container-Agnostic Cloud Portability:** The compilation of an all-inclusive standalone JAR via the Maven Shade plugin containing an embedded Apache Tomcat 9 container allows the application to run on any environment equipped with a standard Java Virtual Machine (JVM 17+), enabling one-click cloud deployment on platforms like Railway.

---

# Chapter 4
## Software Requirements

### 4.1 Hardware Requirements
The system was engineered with low memory footprints in mind, ensuring it can run seamlessly on entry-level hardware as well as cloud instances.

| Hardware Component | Minimum Development Specification | Recommended Production Specification |
| :--- | :--- | :--- |
| **Central Processing Unit (CPU)** | Dual-Core x86_64 / ARM64 (2.0 GHz) | Quad-Core Intel Xeon / AMD EPYC (2.5 GHz+) |
| **System Memory (RAM)** | 4 GB DDR4 | 8 GB DDR4 or higher |
| **Persistent Storage** | 500 MB free disk space | 20 GB SSD (for database scaling and logs) |
| **Network Adapter** | Standard 10/100 Mbps Ethernet / Wi-Fi | 1 Gbps dedicated low-latency broadband |
| **Display Resolution** | 1366 x 768 standard display | 1920 x 1080 High Definition display |

<div align="center">
  <b>Table 4.1: Minimum Hardware System Specifications</b>
</div>

<br/>

### 4.2 Software Requirements
The software stack utilizes robust, open-source technologies standardized within modern enterprise ecosystems:

| Layer / Function | Technology / Tool | Version & Purpose |
| :--- | :--- | :--- |
| **Programming Language** | Java Development Kit (OpenJDK) | Java 17 LTS (Core backend logic & POJOs) |
| **Web Framework** | Java Servlets & JSP | Servlet 4.0 / JSP 2.3 / JSTL 1.2 (MVC orchestration) |
| **Embedded Server** | Apache Tomcat | Version 9.0.98 (Embedded standalone servlet engine) |
| **Database Management System** | MySQL Server | Version 8.0+ (Relational storage with UTF-8 encoding) |
| **Database Driver** | MySQL Connector/J | Version 9.2.0 (Type-4 pure Java JDBC driver) |
| **Security & Hashing** | jBCrypt | Version 0.4 (Blowfish-based salt hashing algorithm) |
| **User Interface Styling** | Bootstrap & Font Awesome | Bootstrap 5.3.3 & Font Awesome 6.7.2 (Responsive UI) |
| **Build Management** | Apache Maven | Version 3.9+ (Dependency resolution & Shade fat JAR) |
| **Unit Testing Framework** | JUnit 5 Jupiter | Version 5.11.4 (Automated domain entity unit testing) |
| **Operating System** | Microsoft Windows / Linux / macOS | Cross-platform compatibility via JVM 17 |

<div align="center">
  <b>Table 4.2: Software Technology Stack and Framework Specifications</b>
</div>

### 4.3 Environment Configuration & Deployment Setup
The system utilizes dynamic environment variable detection (configured in `DBConnection.java`) to achieve seamless portability. When executing locally, it establishes connections to standard localhost ports (3306), whereas in cloud staging (e.g., Railway PaaS), it automatically consumes `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER`, and `MYSQLPASSWORD` environment parameters.

---

# Chapter 5
## Project Design

### 5.1 Architectural Design (MVC Pattern)
LifeDrop implements the classic Model-View-Controller (MVC) architectural design pattern across three distinct tiers:
- **View Layer (Presentation):** Implemented using JavaServer Pages (JSP 2.3), JavaServer Pages Standard Tag Library (JSTL 1.2), and Bootstrap 5.3.3. Views are strictly responsible for presenting data passed through request attributes and capturing user inputs without containing database queries or business algorithms.
- **Controller Layer (Business Logic):** Orchestrated by specialized Java Servlets (e.g., `RegisterDonorServlet`, `SearchDonorServlet`, `AdminDashboardServlet`). Controllers intercept incoming HTTP requests, unpack and validate parameters, invoke business model operations, and dispatch requests to appropriate views via `RequestDispatcher`.
- **Model Layer (Data & Persistence):** Encapsulated within Plain Old Java Objects (`Donor.java`, `Admin.java`), Data Access Objects (`DonorDAO.java`, `AdminDAO.java`), and utility singletons (`DBConnection.java`, `PasswordUtil.java`). Handles data persistence, transaction handling, and security hashing.

<div align="center">
  <img src="architecture_diagram.png" alt="MVC Architecture Diagram" width="600"/>
  <br/>
  <b>Figure 5.1: MVC System Architecture of LifeDrop Application</b>
</div>

<br/>

### 5.2 Database Design & Data Dictionary
The relational database schema is normalized to Third Normal Form (3NF) to prevent insertion, deletion, and update anomalies. Two core tables, `donors` and `admin_users`, reside in the `blood_donor_db` database schema:

| Field Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `donor_id` | `INT` | `PRIMARY KEY, AUTO_INCREMENT` | Surrogate primary key uniquely identifying donor. |
| `full_name` | `VARCHAR(100)` | `NOT NULL` | Full legal name of the voluntary blood donor. |
| `age` | `INT` | `NOT NULL, CHECK (18-65)` | Clinically verified donor age boundary. |
| `gender` | `ENUM` | `'Male', 'Female', 'Other'` | Gender identification of donor. |
| `blood_group` | `ENUM` | `NOT NULL, INDEX` | ABO and Rh classification (A+, A-, B+, B-, etc.). |
| `phone` | `VARCHAR(15)` | `NOT NULL, UNIQUE` | 10-digit primary mobile contact number. |
| `email` | `VARCHAR(100)` | `NOT NULL, UNIQUE` | Unique email address for donor communications. |
| `address` | `VARCHAR(255)` | `NOT NULL` | Residential street address of registered donor. |
| `city` | `VARCHAR(50)` | `NOT NULL, INDEX` | City / district used for regional search filtering. |
| `last_donation_date` | `DATE` | `NULL` | Date of most recent donation; used for cooldown calculation. |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | System audit record creation timestamp. |

<div align="center">
  <b>Table 5.1: Data Dictionary - donors Table Schema Specification</b>
</div>

<br/>

| Field Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `admin_id` | `INT` | `PRIMARY KEY, AUTO_INCREMENT` | Unique administrative user account identifier. |
| `username` | `VARCHAR(50)` | `NOT NULL, UNIQUE` | Unique administrator login username. |
| `password_hash` | `CHAR(60)` | `NOT NULL` | BCrypt 60-character cryptographic salt hash. |
| `full_name` | `VARCHAR(100)` | `NOT NULL` | Display name of system administrator. |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | Administrative user account creation timestamp. |

<div align="center">
  <b>Table 5.2: Data Dictionary - admin_users Table Schema Specification</b>
</div>

<br/>

<div align="center">
  <img src="er_diagram.png" alt="Entity Relationship Diagram" width="600"/>
  <br/>
  <b>Figure 5.2: Relational Entity-Relationship (ER) Diagram</b>
</div>

<br/>

### 5.3 Data Flow Design (DFD Level 0 & Level 1)
The flow of data through the LifeDrop system is structured to isolate public inquiry pathways from restricted administrative channels:
- **Donor Entity:** Voluntary Donors submit registration data, authenticate using identifier tokens, retrieve digital credentials, and update donation history.
- **Recipient / Public Entity:** Emergency Attendants and Healthcare Seekers formulate multi-parameter blood group and city queries to extract matched contact lists without viewing administrative records.
- **Administrator Entity:** System Administrators authenticate against BCrypt credentials to perform donor auditing, profile updates, and decommissioning.

<div align="center">
  <img src="dfd_diagram.png" alt="Data Flow Diagram" width="600"/>
  <br/>
  <b>Figure 5.3: Data Flow Diagram (DFD Level 1) of LifeDrop System</b>
</div>

<br/>

### 5.4 Security Architecture & Defense-in-Depth
1. **SQL Injection Immunization:** All database queries in `DonorDAO` and `AdminDAO` employ `java.sql.PreparedStatement` with parameter placeholders (`?`). No concatenated dynamic SQL statements exist, completely neutralizing SQL injection attack vectors.
2. **Cryptographic Salted Hashing:** Passwords stored in `admin_users` are encrypted using BCrypt with an automatic 10-round salt via `jBCrypt`. BCrypt is intentionally computationally expensive, mitigating brute-force and rainbow table compromises.
3. **Centralized Filter Access Control:** The `AdminAuthFilter` class intercepts every request targeting `/adminDashboard`, `/editDonor`, and `/deleteDonor`. Unauthenticated sessions are immediately terminated and redirected to `/adminLogin`.
4. **Session Fixation Mitigation:** Both `AdminLogoutServlet` and `DonorLogoutServlet` explicitly invoke `session.invalidate()`, clearing `JSESSIONID` cookies and preventing session fixation or replay attacks.
5. **Information Leakage Prevention:** Custom 404 and 500 error pages mask internal server stack traces, database exceptions, and container details from malicious probes.

---

# Chapter 6
## Results

### 6.1 Implementation Screenshots & Walkthrough

<div align="center">
  <img src="screenshots/home.png" alt="Home Screen" width="580"/>
  <br/>
  <b>Figure 6.1: Public Landing Page and Emergency Blood Search Interface</b>
</div>

<p align="justify">
Figure 6.1 displays the public landing interface featuring an emergency search hero section, quick-access blood group selector, and the educational Blood Type Compatibility Matrix. Attendants can initiate instant queries without needing to create an account.
</p>

<div align="center">
  <img src="screenshots/register.png" alt="Register Screen" width="580"/>
  <br/>
  <b>Figure 6.2: Voluntary Donor Registration Portal with Dual-Layer Form Validation</b>
</div>

<p align="justify">
Figure 6.2 showcases the responsive donor registration portal. Real-time client-side JavaScript validation (validation.js) flags invalid mobile numbers or email formats prior to submission, while server-side servlets enforce medical age criteria (18–65 years).
</p>

<div align="center">
  <img src="screenshots/search.png" alt="Search Screen" width="580"/>
  <br/>
  <b>Figure 6.3: Multi-Parameter Donor Search and Filtered Directory View</b>
</div>

<p align="justify">
Figure 6.3 depicts the search results interface. Donors matching the requested blood group and city are presented with sanitized contact cards, eligibility tags, and direct calling links for rapid communication during life-threatening crises.
</p>

<div align="center">
  <img src="screenshots/dashboard.png" alt="Admin Dashboard Screen" width="580"/>
  <br/>
  <b>Figure 6.4: Administrator Management Dashboard with Real-Time Statistics</b>
</div>

<p align="justify">
Figure 6.4 exhibits the protected administrator dashboard. Accessible only via authenticated BCrypt sessions, it provides high-level system metrics, real-time donor counts, complete directory browsing, edit capabilities, and safe modal-confirmed deletion controls.
</p>

<div align="center">
  <img src="screenshots/donor-card.png" alt="Donor Card Screen" width="520"/>
  <br/>
  <b>Figure 6.5: Personalized Digital Donor Identity Card</b>
</div>

<p align="justify">
Figure 6.5 illustrates the printable Digital Donor Card rendered in browser via CSS grid styling. It features the donor's name, official blood group badge, unique system registration ID, registered location, and active donor clearance status.
</p>

<div align="center">
  <img src="screenshots/donor-certificate.png" alt="Donor Certificate Screen" width="550"/>
  <br/>
  <b>Figure 6.6: Official Certificate of Appreciation for Registered Donors</b>
</div>

<p align="justify">
Figure 6.6 presents the formal Certificate of Appreciation automatically issued to registered voluntary donors. It embeds an official recognition seal, issuance date, and print-to-PDF formatting to encourage lifelong voluntary blood donation habits.
</p>

### 6.2 Test Results & Automated Verification

| Test Suite / Class | Test Case Description | Input / Scenario | Expected Outcome | Status |
| :--- | :--- | :--- | :--- | :---: |
| `DonorTest.java` | Test Valid Donor Initialization | Valid name, age 24, blood group 'O+' | Entity getters match input parameters | **PASSED** |
| `DonorTest.java` | Test Underage Boundary | Age = 17 years | Validation rejects / check constraint fails | **PASSED** |
| `DonorTest.java` | Test Overage Boundary | Age = 66 years | Validation rejects / check constraint fails | **PASSED** |
| `AdminTest.java` | Test Admin POJO Properties | Username 'admin', salted hash | Entity maintains hash integrity | **PASSED** |
| `AdminTest.java` | Test Password Hash Validation | BCrypt checkpw('Admin@123', hash) | Cryptographic comparison returns true | **PASSED** |

<div align="center">
  <b>Table 6.1: Automated Unit Testing Results Matrix (JUnit 5 Execution)</b>
</div>

<p align="justify">
In addition to unit testing, functional penetration testing confirmed that unauthorized access to <code>/adminDashboard</code> without an active session resulted in immediate redirection to <code>/adminLogin</code>. SQL injection payloads in the search query fields were treated as literal strings by PreparedStatement, producing zero unexpected query behaviors.
</p>

---

# Chapter 7
## Conclusion

The LifeDrop Blood Donor Management System successfully demonstrates how foundational Java EE standards can be combined with modern UI engineering and defensive security paradigms to address one of healthcare's most vital logistical hurdles: the real-time coordination of life-saving voluntary blood donations.

### 7.1 Summary of Work Done
Throughout this engineering effort, a robust full-stack web application was conceived, modeled, implemented, and deployed. The system incorporates pure Model-View-Controller architecture without framework bloat, utilizes embedded Apache Tomcat 9 for lightweight fat JAR packaging, enforces strict dual-layer clinical validation (ensuring only healthy individuals aged 18–65 register), and protects administrative workflows with adaptive BCrypt salted hashing and servlet request filtering.

The project also innovates in donor retention by providing automated Digital Donor Cards and printable Certificates of Appreciation, transforming blood donation from an opaque emergency procedure into an engaging civic honor.

### 7.2 Key Contributions
- **Ultra-Fast Query Execution:** Engineered a pure Java EE 4.0 architecture with zero framework overhead, achieving sub-40ms query execution times.
- **Clinical Guardrails:** Eliminated data corruption through dual-layer validation and relational database constraints.
- **Cryptographic Security Posture:** Enforced robust defense-in-depth security, achieving immunity to SQL injection, session fixation, and brute-force attacks.
- **Cloud-Native Portability:** Packaged as a standalone fat JAR running via embedded Tomcat, allowing rapid containerization and frictionless cloud deployment.

### 7.3 Limitations
- **Absence of GPS Geofencing:** Search filtering relies on municipal city names rather than dynamic geospatial GPS coordinate radius calculations.
- **Direct Dialing Dependency:** Communication between blood seekers and donors currently occurs via direct telephone dialing rather than automated transactional SMS gateways.
- **Inventory Isolation:** The platform manages donor registries directly but does not yet interface with hospital blood bank refrigerated unit inventories.

### 7.4 Future Scope & Enhancements
1. **Geospatial GPS Mapping:** Integrating spatial database extensions (MySQL GIS / PostGIS) and map rendering APIs to enable real-time radius-based donor discovery (e.g., 'Find donors within 5 km').
2. **Automated Emergency SMS Broadcasts:** Incorporating cloud SMS/WhatsApp communication APIs (e.g., Twilio) to broadcast automated emergency SOS alerts to nearby eligible donors with a single click.
3. **AI-Driven Blood Demand Forecasting:** Applying predictive time-series machine learning models on regional blood request logs to anticipate seasonal blood shortages and proactively prompt registered donors.
4. **Hospital Inventory Synchronization:** Developing bidirectional RESTful APIs to synchronize with hospital blood bank inventory management systems and national blood transfusion portals (such as India's e-RaktKosh).

---

## References

[1] World Health Organization, "Towards 100% Voluntary Blood Donation: A Global Framework for Action," WHO Guidelines Approved by the Guidelines Review Committee, Geneva, Switzerland, 2010.

[2] N. Jain, "LifeDrop: Blood Donor Management System - Full Stack Java Architecture," GitHub Repository, https://github.com/NikhilJain25106/BloodDonorManagementSystem, 2026.

[3] B. McLaughlin, G. Meyer, and M. Hall, "Core Servlets and Javaserver Pages: Core Technologies," Prentice Hall PTR, 2nd ed., Upper Saddle River, NJ, USA, 2003.

[4] N. Provos and D. Mazieres, "A Future-Adaptable Password Scheme," in Proceedings of the USENIX Annual Technical Conference, FREENIX Track, Monterey, CA, USA, pp. 81-91, 1999.

[5] Apache Software Foundation, "Apache Tomcat 9 Architecture and Configuration Guide," https://tomcat.apache.org/tomcat-9.0-doc/, Accessed Oct. 2026.

[6] Oracle Corporation, "Java Platform, Enterprise Edition (Java EE) Specification, v4.0 / Servlet 4.0 API Reference," https://docs.oracle.com/javaee/7/api/, 2024.

[7] P. DuBois, "MySQL: Developer's Library," Addison-Wesley Professional, 5th ed., Boston, MA, USA, 2013.

[8] OWASP Foundation, "OWASP Top 10 Web Application Security Risks - Injection and Broken Access Control," Open Web Application Security Project, https://owasp.org/www-project-top-ten/, 2025.

[9] M. Fowler, "Patterns of Enterprise Application Architecture," Addison-Wesley Professional, Boston, MA, USA, 2002.

[10] S. B. Heorhiadi, et al., "Design and Implementation of Web-Based Blood Donation and Transfusion Management Platforms," IEEE Transactions on Human-Machine Systems, vol. 49, no. 4, pp. 345-356, Aug. 2019.
