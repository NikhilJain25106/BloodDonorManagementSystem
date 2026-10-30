# 🚀 One-Click Cloud Deployment: Render

This repository is pre-configured with **`render.yaml`** and a multi-stage **`Dockerfile`** for zero-configuration, automated deployments on Render.

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/NikhilJain25106/BloodDonorManagementSystem)

---

### Step 1: Click the "Deploy to Render" Button Above
Or open:
👉 **[https://render.com/deploy?repo=https://github.com/NikhilJain25106/BloodDonorManagementSystem](https://render.com/deploy?repo=https://github.com/NikhilJain25106/BloodDonorManagementSystem)**

### Step 2: Enter Database Environment Variables
Render will automatically read [`render.yaml`](render.yaml) and ask for your MySQL database variables:
- `MYSQLHOST`
- `MYSQLPORT`
- `MYSQLDATABASE`
- `MYSQLUSER`
- `MYSQLPASSWORD`

*(If you created an Aiven MySQL free tier service at [aiven.io](https://aiven.io), paste those 5 values here).*

### Step 3: Click "Apply"
Render will automatically build the container and issue a free live URL:
`https://lifedrop-app.onrender.com`

