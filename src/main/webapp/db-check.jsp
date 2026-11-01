<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.blooddonor.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>LifeDrop — Live Database & Dashboard Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        body { background: #f8fafc; font-family: system-ui, sans-serif; padding: 40px 20px; }
        .status-card { border-radius: 12px; border: none; box-shadow: 0 4px 14px rgba(0,0,0,0.06); }
        .badge-success { background: #10b981; }
        .badge-danger { background: #ef4444; }
    </style>
</head>
<body>
<div class="container" style="max-width: 900px;">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-database text-primary me-2"></i>Database Connection & Dashboard Sync</h2>
            <p class="text-muted mb-0">Live real-time diagnosis for LifeDrop (MySQL + HikariCP)</p>
        </div>
        <a href="adminDashboard" class="btn btn-primary btn-sm"><i class="fa-solid fa-gauge me-1"></i>Open Admin Dashboard</a>
    </div>

    <%
        boolean connected = false;
        String dbUrl = "";
        String dbProduct = "";
        String dbVersion = "";
        String errorMsg = null;
        int totalDonors = 0;
        int maleDonors = 0;
        int femaleDonors = 0;
        int otherDonors = 0;
        int totalAdmins = 0;
        ResultSet donorsList = null;
        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
                connected = true;
                DatabaseMetaData meta = conn.getMetaData();
                dbProduct = meta.getDatabaseProductName();
                dbVersion = meta.getDatabaseProductVersion();
                dbUrl = meta.getURL();

                Statement stmt = conn.createStatement();

                // Admin check
                ResultSet rsAdmin = stmt.executeQuery("SELECT COUNT(*) AS total_admins FROM admin_users");
                if (rsAdmin.next()) {
                    totalAdmins = rsAdmin.getInt("total_admins");
                }
                rsAdmin.close();

                // Donors count & gender breakdown
                ResultSet rsCounts = stmt.executeQuery("SELECT COUNT(*) AS total_donors, "
                        + "SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) AS male_count, "
                        + "SUM(CASE WHEN gender='Female' THEN 1 ELSE 0 END) AS female_count, "
                        + "SUM(CASE WHEN gender='Other' THEN 1 ELSE 0 END) AS other_count "
                        + "FROM donors");
                if (rsCounts.next()) {
                    totalDonors = rsCounts.getInt("total_donors");
                    maleDonors = rsCounts.getInt("male_count");
                    femaleDonors = rsCounts.getInt("female_count");
                    otherDonors = rsCounts.getInt("other_count");
                }
                rsCounts.close();
            }
        } catch (Exception e) {
            connected = false;
            errorMsg = e.getMessage();
        }
    %>

    <!-- Connection Status Banner -->
    <div class="card status-card mb-4">
        <div class="card-body p-4">
            <% if (connected) { %>
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 48px; height: 48px; background: #dcfce7; color: #16a34a; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="fa-solid fa-check"></i>
                        </div>
                        <div>
                            <h5 class="mb-0 fw-bold text-success">MySQL Database is CONNECTED Properly!</h5>
                            <small class="text-muted"><%= dbProduct %> <%= dbVersion %> &bull; <%= dbUrl.replaceAll("password=[^&]*", "password=***") %></small>
                        </div>
                    </div>
                    <span class="badge bg-success px-3 py-2 fs-6">Status: ONLINE</span>
                </div>
            <% } else { %>
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 48px; height: 48px; background: #fee2e2; color: #dc2626; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                        </div>
                        <div>
                            <h5 class="mb-0 fw-bold text-danger">Database Connection FAILED</h5>
                            <small class="text-danger"><%= errorMsg %></small>
                        </div>
                    </div>
                    <span class="badge bg-danger px-3 py-2 fs-6">Status: OFFLINE</span>
                </div>
            <% } %>
        </div>
    </div>

    <% if (connected) { %>
    <!-- Dashboard Sync Metrics -->
    <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-pie text-secondary me-2"></i>Live Dashboard Data in MySQL</h5>
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card status-card p-3 text-center border-start border-4 border-danger">
                <span class="text-muted small fw-semibold">TOTAL DONORS</span>
                <h2 class="fw-bold text-danger my-1"><%= totalDonors %></h2>
                <small class="text-success"><i class="fa-solid fa-sync fa-spin me-1"></i>Live from MySQL</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card status-card p-3 text-center border-start border-4 border-success">
                <span class="text-muted small fw-semibold">MALE DONORS</span>
                <h2 class="fw-bold text-success my-1"><%= maleDonors %></h2>
                <small class="text-muted"><%= totalDonors > 0 ? Math.round(maleDonors * 100.0 / totalDonors) : 0 %>% of total</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card status-card p-3 text-center border-start border-4 border-warning">
                <span class="text-muted small fw-semibold">FEMALE DONORS</span>
                <h2 class="fw-bold text-warning my-1"><%= femaleDonors %></h2>
                <small class="text-muted"><%= totalDonors > 0 ? Math.round(femaleDonors * 100.0 / totalDonors) : 0 %>% of total</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card status-card p-3 text-center border-start border-4 border-info">
                <span class="text-muted small fw-semibold">ADMIN ACCOUNTS</span>
                <h2 class="fw-bold text-info my-1"><%= totalAdmins %></h2>
                <small class="text-muted">Active Administrators</small>
            </div>
        </div>
    </div>

    <!-- Donors Table View -->
    <div class="card status-card">
        <div class="card-header bg-white py-3 border-0">
            <h6 class="fw-bold mb-0"><i class="fa-solid fa-list me-2"></i>Registered Donors Currently Stored in Database</h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>#ID</th>
                            <th>Full Name</th>
                            <th>Blood Group</th>
                            <th>City</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Registered At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            boolean isAdminUser = (session != null && session.getAttribute("adminUsername") != null);
                            Statement stmtDonors = conn.createStatement();
                            ResultSet rsList = stmtDonors.executeQuery("SELECT * FROM donors ORDER BY created_at DESC LIMIT 15");
                            boolean hasDonors = false;
                            while (rsList.next()) {
                                hasDonors = true;
                                String p = rsList.getString("phone");
                                String maskedPhone = (isAdminUser || p == null) ? p : (p.length() >= 5 ? p.substring(0, 4) + "******" : "******");
                                String em = rsList.getString("email");
                                String maskedEmail = (isAdminUser || em == null) ? em : (em.contains("@") ? em.substring(0, Math.min(2, em.indexOf('@'))) + "***@" + em.substring(em.indexOf('@') + 1) : "******");
                        %>
                        <tr>
                            <td><strong>#<%= rsList.getInt("donor_id") %></strong></td>
                            <td><%= rsList.getString("full_name") %></td>
                            <td><span class="badge bg-danger"><%= rsList.getString("blood_group") %></span></td>
                            <td><%= rsList.getString("city") %></td>
                            <td><%= maskedPhone %></td>
                            <td><%= maskedEmail %></td>
                            <td><small class="text-muted"><%= rsList.getTimestamp("created_at") %></small></td>
                        </tr>
                        <%
                            }
                            rsList.close();
                            stmtDonors.close();
                            if (!hasDonors) {
                        %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                <em>No donor records currently found in the table.</em>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
        } // end if connected
        if (conn != null) {
            try { conn.close(); } catch(Exception ignored) {}
        }
    %>
</div>
</body>
</html>

