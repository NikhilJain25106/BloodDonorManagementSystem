<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String adminUsername = (session != null) ? (String) session.getAttribute("adminUsername") : null;
    Integer donorId = (session != null) ? (Integer) session.getAttribute("donorId") : null;
    String donorName = (session != null) ? (String) session.getAttribute("donorName") : null;
    String donorBlood = (session != null) ? (String) session.getAttribute("donorBloodGroup") : null;
    String cp = request.getContextPath();
    String currentPage = request.getRequestURI();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="LifeDrop - India's Blood Donor Management System. Find blood donors near you or register as a donor to save lives.">
    <meta name="theme-color" content="#e11d48">

    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="LifeDrop &mdash; Blood Donor Management System">
    <meta property="og:description" content="Find voluntary blood donors instantly or register to save lives in emergencies.">
    <meta property="og:image" content="<%= cp %>/assets/images/favicon.svg">

    <!-- Twitter -->
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="LifeDrop &mdash; Blood Donor Management System">
    <meta name="twitter:description" content="Connecting blood donors with patients and hospitals in real time.">

    <!-- Favicon & PWA Icons -->
    <link rel="icon" type="image/svg+xml" href="<%= cp %>/assets/images/favicon.svg">
    <link rel="manifest" href="<%= cp %>/site.webmanifest">

    <title>LifeDrop &mdash; Blood Donor Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
    <link href="<%= cp %>/assets/css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg app-navbar sticky-top" style="z-index:1000;">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="<%= cp %>/index.jsp">
            <div style="width:38px;height:38px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:11px;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 12px rgba(225,29,72,0.35);">
                <i class="fa-solid fa-droplet text-white" style="font-size:0.95rem;"></i>
            </div>
            <span style="color:#0f172a;font-weight:800;letter-spacing:-0.5px;font-size:1.2rem;">Life<span style="color:#e11d48;">Drop</span></span>
        </a>
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu" style="color:var(--gray-600);">
            <i class="fa-solid fa-bars" style="font-size:1.1rem;"></i>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav mx-auto align-items-center gap-1 text-center">
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("index") ? " active" : "" %>" href="<%= cp %>/index.jsp">
                        <i class="fa-solid fa-house me-1" style="font-size:0.8rem;"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("register") ? " active" : "" %>" href="<%= cp %>/registerDonor">
                        <i class="fa-solid fa-user-plus me-1" style="font-size:0.8rem;"></i>Register
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("search") ? " active" : "" %>" href="<%= cp %>/searchDonors">
                        <i class="fa-solid fa-magnifying-glass me-1" style="font-size:0.8rem;"></i>Search
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("contact") ? " active" : "" %>" href="<%= cp %>/contact.jsp">
                        <i class="fa-solid fa-envelope me-1" style="font-size:0.8rem;"></i>Contact
                    </a>
                </li>
                <% if (donorId != null) { %>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("donorCard") ? " active" : "" %>" href="<%= cp %>/donorCard">
                        <i class="fa-solid fa-id-card me-1 text-red" style="font-size:0.8rem;"></i>My Donor Card
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("donorCertificate") ? " active" : "" %>" href="<%= cp %>/donorCertificate">
                        <i class="fa-solid fa-certificate me-1" style="color:#f59e0b;font-size:0.8rem;"></i>Certificate
                    </a>
                </li>
                <% } %>
                <% if (adminUsername != null) { %>
                <li class="nav-item">
                    <a class="nav-link<%= currentPage.contains("admin") ? " active" : "" %>" href="<%= cp %>/adminDashboard">
                        <i class="fa-solid fa-gauge me-1" style="font-size:0.8rem;"></i>Dashboard
                    </a>
                </li>
                <% } %>
            </ul>

            <!-- Auth Buttons Section: Centered on mobile view, right-aligned on desktop -->
            <div class="nav-actions-wrap d-flex align-items-center justify-content-center justify-content-lg-end flex-wrap gap-2 mt-3 mt-lg-0 ms-lg-2">
                <% if (donorId != null) { %>
                    <a href="<%= cp %>/donorCard" class="donor-nav-pill text-decoration-none">
                        <span class="blood-badge mini"><%= donorBlood != null ? donorBlood : "ID" %></span>
                        <span><%= donorName != null ? donorName.split(" ")[0] : "Donor" %></span>
                    </a>
                    <a href="<%= cp %>/donorLogout" class="btn btn-outline-secondary btn-sm" style="border-radius:10px;font-size:0.82rem;padding:0.42rem 0.85rem;font-weight:600;" title="Logout">
                        <i class="fa-solid fa-right-from-bracket me-1"></i>Logout
                    </a>
                <% } else if (adminUsername != null) { %>
                    <div style="display:flex;align-items:center;gap:8px;background:var(--gray-100);border-radius:50px;padding:0.3rem 0.75rem 0.3rem 0.5rem;border:1px solid var(--gray-200);">
                        <div style="width:28px;height:28px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-user text-white" style="font-size:0.7rem;"></i>
                        </div>
                        <span style="font-size:0.8rem;font-weight:700;color:var(--gray-700);"><%= adminUsername %></span>
                    </div>
                    <a href="<%= cp %>/adminLogout" class="btn-admin-nav nav-link" style="padding:0.45rem 1rem !important;">
                        <i class="fa-solid fa-right-from-bracket me-1"></i>Logout
                    </a>
                <% } else { %>
                    <a href="<%= cp %>/donorLogin" class="btn-donor-nav nav-link">
                        <i class="fa-solid fa-id-card me-1 text-red"></i>Donor Login
                    </a>
                    <a href="<%= cp %>/adminLogin" class="btn-admin-nav nav-link">
                        <i class="fa-solid fa-user-shield me-1"></i>Admin Login
                    </a>
                <% } %>
            </div>

        </div>
    </div>
</nav>

<main class="app-main">
