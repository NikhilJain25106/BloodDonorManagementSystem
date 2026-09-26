<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String adminUsername=(session !=null) ? (String) session.getAttribute("adminUsername") : null; String
        contextPath=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Blood Donor Management System</title>

            <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
            <link href="<%= contextPath %>/assets/css/Style.css" rel="stylesheet">
        </head>

        <body>

            <main class="app-main">