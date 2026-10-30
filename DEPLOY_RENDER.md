# 🚀 100% Free Cloud Deployment Guide (Render + Aiven / TiDB)

This guide takes 3 minutes to deploy your **LifeDrop Web App** on **Render** and your **MySQL Database** on **Aiven** or **TiDB Cloud** for free.

---

## Part 1: Set Up Free Cloud MySQL (Choose Aiven or TiDB)

### Option A: Aiven for MySQL (Recommended - Dedicated MySQL 8.0)
1. Go to **[https://aiven.io](https://aiven.io)** and click **Sign Up** (Sign in with Google/GitHub, no credit card required).
2. Click **Create Service**:
   - Service: **MySQL**
   - Cloud Provider: Choose **AWS** or **Google Cloud** (any region close to you, e.g. Mumbai, Singapore, or Frankfurt).
   - Plan: Select **Free Plan**.
   - Service Name: `lifedrop-mysql`
3. Once created, go to the **Overview** tab and copy your connection parameters:
   - **Host** (e.g., `mysql-xxxxx.aivencloud.com`)
   - **Port** (e.g., `12345`)
   - **User** (e.g., `avnadmin`)
   - **Password** (click the eye icon to reveal)
   - **Database Name** (default is `defaultdb`)
4. Open the **Query Editor** tab in Aiven (or connect from your computer) and run the contents of [`database/schema.sql`](database/schema.sql) to create the tables.

---

### Option B: TiDB Serverless (Alternative - Instant Setup)
1. Go to **[https://tidb.cloud](https://tidb.cloud)** and sign in with GitHub.
2. Click **Create Cluster** → Select **Serverless (Free)**.
3. Click the **SQL Editor** tab in your TiDB dashboard and paste the contents of [`database/schema.sql`](database/schema.sql) and execute it.
4. Click **Connect** → Choose **General** / **JDBC** to get your Host, Port, User, and Password.

---

## Part 2: Deploy LifeDrop on Render

1. Go to **[https://render.com](https://render.com)** and sign in with GitHub.
2. In your dashboard, click **New +** → **Web Service**.
3. Select your repository: `BloodDonorManagementSystem`.
4. Configure the service:
   - **Name:** `lifedrop`
   - **Region:** Choose the region closest to your database
   - **Runtime:** **Docker** (Render automatically detects your [`Dockerfile`](Dockerfile) and [`render.yaml`](render.yaml))
   - **Instance Type:** **Free**
5. Scroll down to **Environment Variables** and click **Add Environment Variable**:

   | Key | Value | Example |
   |:---|:---|:---|
   | `PORT` | `8080` | `8080` |
   | `MYSQLHOST` | Your Aiven / TiDB host | `mysql-36...aivencloud.com` |
   | `MYSQLPORT` | Your Aiven / TiDB port | `18542` |
   | `MYSQLDATABASE` | Your database name | `defaultdb` or `blood_donor_db` |
   | `MYSQLUSER` | Your database username | `avnadmin` |
   | `MYSQLPASSWORD` | Your database password | `<your-db-password>` |

6. Click **Create Web Service**.
7. Render will build the Docker container and deploy your live app at:
   `https://lifedrop-xxxx.onrender.com`

---

## Part 3: Verify the Live Deployment

Once Render displays **Live**, visit:
1. **Public Site:** `https://your-app.onrender.com/`
2. **Database Diagnostic:** `https://your-app.onrender.com/db-check.jsp` (will show green ONLINE status)
3. **Admin Dashboard:** `https://your-app.onrender.com/adminLogin` (`admin` / `Admin@123`)

