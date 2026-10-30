<%@ include file="includes/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Donor" %>

<%
    List<Donor> donors = (List<Donor>) request.getAttribute("donors");
    int total = (donors != null) ? donors.size() : 0;

    // Count by gender
    int male = 0, female = 0, other = 0;
    if (donors != null) {
        for (Donor donor : donors) {
            if ("Male".equals(donor.getGender()))        male++;
            else if ("Female".equals(donor.getGender())) female++;
            else                                          other++;
        }
    }
%>

<!-- PAGE HERO -->
<section class="page-hero" style="background:linear-gradient(135deg,#1e3a5f 0%,#1a3355 100%);">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="page-hero-icon">
                    <i class="fa-solid fa-gauge"></i>
                </div>
                <div>
                    <h1 class="page-hero-title">Admin Dashboard</h1>
                    <p class="page-hero-sub">Welcome back, <strong style="color:#fff;"><%= session.getAttribute("adminFullName") %></strong></p>
                </div>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a href="<%= request.getContextPath() %>/exportDonors"
                   class="btn btn-success btn-sm d-flex align-items-center gap-1 shadow-sm"
                   style="border-radius:10px;font-weight:600;font-size:0.85rem;padding:0.5rem 1.1rem;">
                    <i class="fa-solid fa-file-csv"></i> Export CSV
                </a>
                <a href="<%= request.getContextPath() %>/adminLogout"
                   class="btn btn-outline-secondary btn-sm"
                   style="border-radius:10px;font-weight:600;color:rgba(255,255,255,0.8);border-color:rgba(255,255,255,0.3);background:rgba(255,255,255,0.08);font-size:0.85rem;padding:0.5rem 1.1rem;">
                    <i class="fa-solid fa-right-from-bracket me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>
</section>

<div class="container-fluid py-4 px-4">

    <%-- Error message --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <!-- Stat Cards -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
            <div class="admin-stat-card red">
                <div class="d-flex align-items-start justify-content-between mb-3">
                    <div>
                        <div class="admin-stat-number"><%= total %></div>
                        <div class="admin-stat-label">Total Donors</div>
                    </div>
                    <div class="admin-stat-icon red"><i class="fa-solid fa-users"></i></div>
                </div>
                <a href="<%= request.getContextPath() %>/registerDonor" class="btn btn-brand" style="font-size:0.78rem;padding:0.4rem 0.9rem;gap:6px;">
                    <i class="fa-solid fa-plus"></i>Add New
                </a>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="admin-stat-card blue">
                <div class="d-flex align-items-start justify-content-between mb-3">
                    <div>
                        <div class="admin-stat-number">8</div>
                        <div class="admin-stat-label">Blood Groups</div>
                    </div>
                    <div class="admin-stat-icon blue"><i class="fa-solid fa-droplet"></i></div>
                </div>
                <a href="<%= request.getContextPath() %>/searchDonors" class="btn btn-outline-secondary" style="font-size:0.78rem;padding:0.4rem 0.9rem;border-radius:8px;font-weight:600;">
                    <i class="fa-solid fa-magnifying-glass me-1"></i>Search
                </a>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="admin-stat-card green">
                <div class="d-flex align-items-start justify-content-between mb-3">
                    <div>
                        <div class="admin-stat-number"><%= male %></div>
                        <div class="admin-stat-label">Male Donors</div>
                    </div>
                    <div class="admin-stat-icon green"><i class="fa-solid fa-person"></i></div>
                </div>
                <span style="font-size:0.78rem;color:var(--gray-500);">
                    <%= total > 0 ? Math.round(male * 100.0 / total) : 0 %>% of total
                </span>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="admin-stat-card amber">
                <div class="d-flex align-items-start justify-content-between mb-3">
                    <div>
                        <div class="admin-stat-number"><%= female %></div>
                        <div class="admin-stat-label">Female Donors</div>
                    </div>
                    <div class="admin-stat-icon amber"><i class="fa-solid fa-person-dress"></i></div>
                </div>
                <span style="font-size:0.78rem;color:var(--gray-500);">
                    <%= total > 0 ? Math.round(female * 100.0 / total) : 0 %>% of total
                </span>
            </div>
        </div>
    </div>

    <!-- Chart.js Interactive Analytics Dashboard -->
    <div class="row g-3 mb-4">
        <div class="col-lg-6">
            <div class="card app-card p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h6 class="fw-bold mb-0 text-navy"><i class="fa-solid fa-chart-pie text-danger me-2"></i>Blood Group Supply Distribution</h6>
                    <small class="text-muted">ABO & Rh Taxonomy</small>
                </div>
                <div style="height: 250px;">
                    <canvas id="bloodChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card app-card p-4 h-100">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h6 class="fw-bold mb-0 text-navy"><i class="fa-solid fa-chart-column text-primary me-2"></i>Demographics & City Density</h6>
                    <small class="text-muted">Regional Availability</small>
                </div>
                <div style="height: 250px;">
                    <canvas id="cityChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Donor Table -->
    <div class="card app-card overflow-hidden">
        <!-- Table header with search -->
        <div class="card-header bg-white py-3 px-4 d-flex align-items-center justify-content-between flex-wrap gap-3" style="border-bottom:1px solid #f3f4f6;">
            <div class="d-flex align-items-center gap-2">
                <i class="fa-solid fa-table-list" style="color:var(--red);"></i>
                <h5 class="mb-0 fw-700">All Registered Donors</h5>
                <span class="result-count-badge ms-1"><%= total %></span>
            </div>
            <div class="d-flex gap-2 align-items-center">
                <div class="input-group" style="width:220px;">
                    <span class="input-group-text" style="border-radius:10px 0 0 10px;padding:0.45rem 0.75rem;">
                        <i class="fa-solid fa-search" style="font-size:0.8rem;"></i>
                    </span>
                    <input type="text" id="tableSearch" class="form-control" placeholder="Filter table..."
                        style="border-radius:0 10px 10px 0;font-size:0.85rem;padding:0.45rem 0.75rem;"
                        oninput="filterTable(this.value)">
                </div>
                <a href="<%= request.getContextPath() %>/registerDonor" class="btn btn-brand" style="white-space:nowrap;padding:0.5rem 1rem;font-size:0.85rem;gap:6px;">
                    <i class="fa-solid fa-plus"></i>Add Donor
                </a>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="donorTable">
                    <thead>
                        <tr>
                            <th style="width:40px;">#</th>
                            <th>Name</th>
                            <th>Blood</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>City</th>
                            <th>Last Donation</th>
                            <th>Registered</th>
                            <th style="width:80px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (donors == null || donors.isEmpty()) { %>
                            <tr>
                                <td colspan="11" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-inbox fa-3x mb-3 d-block" style="opacity:0.3;"></i>
                                    <p class="mb-1 fw-600">No donors registered yet</p>
                                    <a href="<%= request.getContextPath() %>/registerDonor" class="btn btn-brand btn-sm mt-1">
                                        <i class="fa-solid fa-plus me-1"></i>Add First Donor
                                    </a>
                                </td>
                            </tr>
                        <% } else {
                               int i = 1;
                               for (Donor donor : donors) { %>
                            <tr>
                                <td class="text-muted" style="font-size:0.8rem;"><%= i++ %></td>
                                <td>
                                    <div class="fw-600" style="color:var(--navy);"><%= donor.getFullName() %></div>
                                </td>
                                <td><span class="blood-badge"><%= donor.getBloodGroup() %></span></td>
                                <td><%= donor.getAge() %></td>
                                <td>
                                    <span style="font-size:0.8rem;background:#f3f4f6;padding:0.2rem 0.55rem;border-radius:6px;font-weight:500;">
                                        <%= donor.getGender() %>
                                    </span>
                                </td>
                                <td><a href="tel:<%= donor.getPhone() %>" style="color:inherit;text-decoration:none;"><%= donor.getPhone() %></a></td>
                                <td style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                    <a href="mailto:<%= donor.getEmail() %>" style="color:inherit;text-decoration:none;font-size:0.83rem;"><%= donor.getEmail() %></a>
                                </td>
                                <td><%= donor.getCity() %></td>
                                <td>
                                    <%= donor.getLastDonationDate() != null
                                        ? "<span style='color:#374151;font-size:0.83rem;'>" + donor.getLastDonationDate() + "</span>"
                                        : "<span style='color:#9ca3af;font-size:0.8rem;'>—</span>" %>
                                </td>
                                <td><small style="color:var(--gray-500);font-size:0.78rem;"><%= donor.getCreatedAt() %></small></td>
                                <td>
                                    <div class="d-flex gap-1">
                                        <a href="<%= request.getContextPath() %>/editDonor?id=<%= donor.getDonorId() %>"
                                           class="action-btn edit" title="Edit donor">
                                            <i class="fa-solid fa-pen" style="font-size:0.75rem;"></i>
                                        </a>
                                        <a href="<%= request.getContextPath() %>/deleteDonor?id=<%= donor.getDonorId() %>"
                                           class="action-btn delete" title="Delete donor"
                                           onclick="return confirm('Delete <%= donor.getFullName() %>? This cannot be undone.')">
                                            <i class="fa-solid fa-trash" style="font-size:0.75rem;"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Parse donor stats for charts
<%
    int op = 0, on = 0, ap = 0, an = 0, bp = 0, bn = 0, abp = 0, abn = 0;
    java.util.Map<String, Integer> cityCounts = new java.util.HashMap<>();
    if (donors != null) {
        for (Donor d : donors) {
            String bg = d.getBloodGroup();
            if ("O+".equals(bg)) op++;
            else if ("O-".equals(bg)) on++;
            else if ("A+".equals(bg)) ap++;
            else if ("A-".equals(bg)) an++;
            else if ("B+".equals(bg)) bp++;
            else if ("B-".equals(bg)) bn++;
            else if ("AB+".equals(bg)) abp++;
            else if ("AB-".equals(bg)) abn++;

            String c = d.getCity() != null ? d.getCity().trim() : "Unknown";
            cityCounts.put(c, cityCounts.getOrDefault(c, 0) + 1);
        }
    }
%>

// Chart 1: Blood Group Doughnut
const ctxBlood = document.getElementById('bloodChart').getContext('2d');
new Chart(ctxBlood, {
    type: 'doughnut',
    data: {
        labels: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'],
        datasets: [{
            data: [<%= op %>, <%= on %>, <%= ap %>, <%= an %>, <%= bp %>, <%= bn %>, <%= abp %>, <%= abn %>],
            backgroundColor: ['#e11d48', '#f43f5e', '#2563eb', '#3b82f6', '#10b981', '#34d399', '#f59e0b', '#fbbf24']
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'right' } }
    }
});

// Chart 2: City Density Bar Chart
const ctxCity = document.getElementById('cityChart').getContext('2d');
new Chart(ctxCity, {
    type: 'bar',
    data: {
        labels: [<% for (String c : cityCounts.keySet()) { %>'<%= c %>',<% } %>],
        datasets: [{
            label: 'Donors Registered',
            data: [<% for (Integer cnt : cityCounts.values()) { %><%= cnt %>,<% } %>],
            backgroundColor: '#3b82f6',
            borderRadius: 6
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } },
        plugins: { legend: { display: false } }
    }
});

function filterTable(query) {
    const rows = document.querySelectorAll('#donorTable tbody tr');
    const q = query.toLowerCase();
    rows.forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>

<%@ include file="includes/footer.jsp" %>
