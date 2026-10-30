# =============================================================================
# LifeDrop - Consolidated Deployment & Hosting Guide
# =============================================================================

This single guide covers both **Local Execution** and **100% Free Cloud Deployment**.

---

## ☁️ 1. Free Cloud Deployment (Render + Aiven Cloud MySQL)

### Step 1: Deploy Web Service on Render
Click the 1-click deploy blueprint:
👉 **[https://render.com/deploy?repo=https://github.com/NikhilJain25106/BloodDonorManagementSystem](https://render.com/deploy?repo=https://github.com/NikhilJain25106/BloodDonorManagementSystem)**

Render reads [`render.yaml`](render.yaml) automatically, sets port 8080, and configures the environment.

### Step 2: Set Database Environment Variable in Render
In your **Render Dashboard** -> **Environment**:
Add either `MYSQL_URL` or the individual database parameters:
- `MYSQL_URL`: `mysql://avnadmin:AVNS_lHp0SNhnO1zx8LYPSo_@mysql-33813183-lifedropbm-77.a.aivencloud.com:22772/defaultdb?ssl-mode=REQUIRED`

---

## 💻 2. Local Execution (Docker or Native)

### Option A: Docker (Recommended)
```cmd
run.bat
```
*(Automatically spins up MySQL 8.0, initializes schema, builds fat JAR, and serves on port 8080)*.

### Option B: Native (JDK 17 + Local MySQL)
```cmd
run.bat --native
```

---

## 🩺 3. Verification & Diagnostic Endpoints

- **Public Home:** `http://localhost:8080/` or `https://your-app.onrender.com/`
- **Database Diagnostic:** `http://localhost:8080/db-check.jsp`
- **Health Check:** `http://localhost:8080/health`
- **Admin Dashboard:** `http://localhost:8080/adminLogin` (`admin` / `Admin@123`)
- **Donor Login:** `http://localhost:8080/donorLogin` (`rohan.mehta@example.com`)
