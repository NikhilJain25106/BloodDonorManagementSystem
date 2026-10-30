# LifeDrop — System Operations & Maintenance Playbook

This document serves as the master operations and automation guide for autonomous agent management and human oversight.

---

## 🧭 System Topology

| Tier | Component | Configuration Source | Operational Control |
|:---|:---|:---|:---|
| **Web / Servlet Engine** | Embedded Apache Tomcat 9 | `src/main/java/com/blooddonor/Main.java` | Port `$PORT` (default 8080) |
| **Persistence / Pool** | HikariCP Connection Pool | `src/main/java/com/blooddonor/util/DBConnection.java` | Min: 3, Max: 15, Re-init on demand |
| **Database Engine** | MySQL 8.0 Server | `database/schema.sql`, `docker-compose.yml` | Port 3306, `blood_donor_db` |
| **Container Engine** | Multi-Stage Alpine JRE | `Dockerfile`, `docker-compose.yml` | Non-root `lifedropuser` |
| **Automation Scripts** | Shell & Batch Runners | `run.bat`, `run.sh`, `Makefile` | Path-independent wrappers |

---

## 🛠 Standard Autonomous Operations

### 1. Starting the Full Stack
- **Docker (Preferred):**
  ```cmd
  run.bat
  ```
  or
  ```bash
  docker compose up --build -d
  ```

### 2. Monitoring & Diagnostic Probes
- **Health check:** `GET http://localhost:8080/health` (Returns `{"status":"UP","service":"LifeDrop"}`)
- **Container health:** `docker compose ps`
- **Application logs:** `docker compose logs -f app`
- **Database logs:** `docker compose logs -f db`

### 3. Graceful Termination
- **Stop containers:** `docker compose down`
- **Purge volume data (hard reset):** `docker compose down -v`

### 4. Database Schema Migration
Whenever schema adjustments are needed:
1. Modify `database/schema.sql` with idempotent `CREATE TABLE IF NOT EXISTS` / `ALTER TABLE`.
2. Ensure Docker's `/docker-entrypoint-initdb.d/01-schema.sql` mount reflects the changes.
3. Update DAOs (`DonorDAO.java`, `AdminDAO.java`) and POJOs (`Donor.java`, `Admin.java`) synchronously.

### 5. Test Suite Verification
- Run: `mvn test`
- All 55 test cases in `AuthHardeningTest`, `DonorValidationTest`, `DonorTest`, and `AdminTest` must remain passing.

---

## 🔐 Credentials & Critical Secrets Reference

| Account Role | Username / Identifier | Default Password / Hash |
|:---|:---|:---|
| **System Admin** | `admin` | `Admin@123` (BCrypt work factor 12: `$2a$12$i1mn...`) |
| **Sample Donor** | `rohan.mehta@example.com` or `9876543210` | Passwordless (Verified direct login) |
| **MySQL (Docker)** | `lifedrop` / `root` | `lifedroppassword` / `rootpassword` |
| **MySQL (Host fallback)**| `root` | Configured via `.env` (`MYSQLPASSWORD`) |

