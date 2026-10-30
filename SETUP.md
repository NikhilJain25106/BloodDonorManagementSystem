# 🚀 Quick Start Guide — Run LifeDrop on Any Device

LifeDrop is engineered to run on **any device and operating system** (Windows, macOS, Linux, Raspberry Pi, Cloud VMs) with zero complex setup.

Choose your preferred way to run below:

---

## ⚡ Option 1: One-Command Docker Setup (Recommended for Any Device)

> **Requirements:** Only [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/macOS) or Docker Engine (Linux).
> **No Java, Maven, or MySQL installation required on your host machine!**

### 1. Run the Startup Command

#### **On Windows (PowerShell or Command Prompt):**
```cmd
run.bat
```
*or using Docker Compose directly:*
```cmd
docker compose up --build -d
```

#### **On macOS / Linux / WSL / Git Bash:**
```bash
chmod +x run.sh
./run.sh
```
*or using Docker Compose directly:*
```bash
docker compose up --build -d
```

---

### 2. Access the Application

Once started, open your web browser:

| Portal | URL | Default Credentials |
|:---|:---|:---|
| **Public Home & Search** | [http://localhost:8080/](http://localhost:8080/) | *No login needed* |
| **Admin Dashboard** | [http://localhost:8080/adminLogin](http://localhost:8080/adminLogin) | **Username:** `admin`<br/>**Password:** `Admin@123` |
| **Donor Self-Service** | [http://localhost:8080/donorLogin](http://localhost:8080/donorLogin) | **Email/Phone:** `rohan.mehta@example.com` or `9876543210` |
| **Health Probe** | [http://localhost:8080/health](http://localhost:8080/health) | Returns JSON status |

---

### 3. Docker Management Commands

- **View Live Application Logs:**
  ```bash
  docker compose logs -f app
  ```
- **View Database Logs:**
  ```bash
  docker compose logs -f db
  ```
- **Stop Containers:**
  ```bash
  docker compose down
  ```
- **Stop and Reset Database:**
  ```bash
  docker compose down -v
  ```

---

## 💻 Option 2: Native Setup (Without Docker)

> **Requirements:**
> - [Java JDK 17+](https://adoptium.net/) installed (`java -version`)
> - [Apache Maven 3.9+](https://maven.apache.org/download.cgi) installed (`mvn -v`)
> - [MySQL 8.0+](https://dev.mysql.com/downloads/) running locally

### Step 1: Clone the Repository
```bash
git clone https://github.com/NikhilJain25106/BloodDonorManagementSystem.git
cd BloodDonorManagementSystem
```

### Step 2: Set Up Database Schema
Run the schema script in your local MySQL instance:
```bash
mysql -u root -p < database/schema.sql
```
*(On Windows PowerShell, run: `Get-Content database/schema.sql | mysql -u root -p`)*

### Step 3: Configure `.env`
Copy `.env.example` to `.env` and set your MySQL password:
```bash
# On Linux/macOS
cp .env.example .env

# On Windows CMD
copy .env.example .env
```
Edit `.env`:
```ini
MYSQLHOST=localhost
MYSQLPORT=3306
MYSQLDATABASE=blood_donor_db
MYSQLUSER=root
MYSQLPASSWORD=your_actual_mysql_password
```

### Step 4: Build and Run
```bash
# Package the standalone fat JAR
mvn clean package -DskipTests

# Run the embedded Tomcat server
java -XX:+UseG1GC -Djava.awt.headless=true -jar target/BloodDonorManagementSystem.jar
```
*(On Windows, you can also run `run.bat --native`)*

---

## ☁️ Option 3: Free Cloud Deployment (Railway)

LifeDrop is pre-configured for instant zero-downtime deployment on [Railway](https://railway.app):

1. Fork or push this repository to your GitHub account.
2. Sign in to [Railway](https://railway.app) with GitHub.
3. Click **"New Project"** → **"Deploy from GitHub repo"** → Select `BloodDonorManagementSystem`.
4. In your project dashboard, click **"New"** → **"Database"** → **"Add MySQL"**.
5. Connect to the MySQL database from the Railway web interface or CLI and paste `database/schema.sql`.
6. Railway automatically provisions port mapping and links your database environment variables.
7. Click the generated public domain to open LifeDrop live!

---

## 🛠 Troubleshooting & FAQ

<details>
<summary><b>1. Port 8080 is already in use by another program</b></summary>

You can change the port without modifying code:
- **In Docker:** In your `.env` or terminal: `PORT=9090 docker compose up -d`
- **In Native:** Set environment variable `PORT=9090` before running `java -jar target/BloodDonorManagementSystem.jar`.
</details>

<details>
<summary><b>2. MySQL connection failed on first start</b></summary>

When starting Docker for the very first time, MySQL takes a few seconds to initialize. The app is configured with automatic retry logic and waits for MySQL to report `healthy`. If needed, check database status with:
```bash
docker compose ps
```
</details>

<details>
<summary><b>3. How do I reset admin password?</b></summary>

Connect to MySQL (locally or via `docker exec -it lifedrop-mysql mysql -u root -prootpassword blood_donor_db`) and execute:
```sql
UPDATE admin_users
SET password_hash = '$2a$12$i1mnIQro/fBS/F9myvB7muiXTLqPdPYxuK4P/ga/vJKB4CAq0hwZe'
WHERE username = 'admin';
```
This resets the admin password back to `Admin@123`.
</details>

