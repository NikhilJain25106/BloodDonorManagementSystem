<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String adminUsername = (session != null) ? (String) session.getAttribute("adminUsername") : null;
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeDrop - Blood Donor Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="<%= cp %>/assets/css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg app-navbar sticky-top" style="z-index:1000;">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="<%= cp %>/index.jsp">
            <div style="width:36px;height:36px;background:linear-gradient(135deg,#dc2626,#b91c1c);border-radius:10px;display:flex;align-items:center;justify-content:center;box-shadow:0 3px 10px rgba(220,38,38,0.35);">
                <i class="fa-solid fa-droplet text-white" style="font-size:0.9rem;"></i>
            </div>
            <span style="color:#1e3a5f;font-weight:800;letter-spacing:-0.5px;">Life<span style="color:#dc2626;">Drop</span></span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav mx-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1 text-red"></i>Home</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= cp %>/registerDonor"><i class="fa-solid fa-user-plus me-1 text-red"></i>Register</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= cp %>/searchDonors"><i class="fa-solid fa-magnifying-glass me-1 text-red"></i>Search</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= cp %>/contact.jsp"><i class="fa-solid fa-envelope me-1 text-red"></i>Contact</a></li>
                <% if (adminUsername != null) { %>
                <li class="nav-item"><a class="nav-link" href="<%= cp %>/adminDashboard"><i class="fa-solid fa-gauge me-1 text-red"></i>Dashboard</a></li>
                <% } %>
            </ul>
            <div class="d-flex align-items-center gap-2 ms-2">
                <% if (adminUsername != null) { %>
                    <span class="text-muted small me-1"><i class="fa-solid fa-circle-user me-1"></i><%= adminUsername %></span>
                    <a href="<%= cp %>/adminLogout" class="btn-admin-nav nav-link">
                        <i class="fa-solid fa-right-from-bracket me-1"></i>Logout
                    </a>
                <% } else { %>
                    <a href="<%= cp %>/adminLogin" class="btn-admin-nav nav-link">
                        <i class="fa-solid fa-user-shield me-1"></i>Admin Login
                    </a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<main class="app-main">
