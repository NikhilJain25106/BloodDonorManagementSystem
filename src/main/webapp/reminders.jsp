<%@ include file="includes/header.jsp" %>
<%@ page import="java.sql.*, java.util.Date, com.blooddonor.util.DBConnection" %>

<!-- PAGE HERO -->
<section class="page-hero" style="background:linear-gradient(135deg,#064e3b 0%,#047857 100%);">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3">
            <div class="page-hero-icon" style="background:rgba(255,255,255,0.2);color:#fff;">
                <i class="fa-solid fa-bell"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Donor Renewal & Clinical Spacing Reminders</h1>
                <p class="page-hero-sub">Scheduled tracking of mandatory 90/120-day interval recovery dates</p>
            </div>
        </div>
    </div>
</section>

<div class="container py-5">
    <div class="card app-card p-4 mb-4">
        <h5 class="fw-bold mb-3 text-navy"><i class="fa-solid fa-clock-rotate-left text-success me-2"></i>Active Donors Ready for Renewal</h5>
        <p class="text-muted small">Donors whose statutory resting period has elapsed and are clinically fit to donate whole blood again.</p>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Donor Name</th>
                        <th>Blood Group</th>
                        <th>City</th>
                        <th>Last Donated</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT full_name, blood_group, city, phone, last_donation_date FROM donors ORDER BY last_donation_date ASC")) {
                            boolean hasAny = false;
                            while (rs.next()) {
                                hasAny = true;
                                Date lastDate = rs.getDate("last_donation_date");
                                String name = rs.getString("full_name");
                                String phone = rs.getString("phone");
                                String blood = rs.getString("blood_group");
                    %>
                    <tr>
                        <td class="fw-bold"><%= name %></td>
                        <td><span class="badge bg-danger"><%= blood %></span></td>
                        <td><%= rs.getString("city") %></td>
                        <td><%= lastDate != null ? lastDate.toString() : "First-time Donor" %></td>
                        <td><span class="badge bg-success">Ready to Donate</span></td>
                        <td>
                            <a href="https://wa.me/91<%= phone.replaceAll("[^0-9]","") %>?text=Hello%20<%= java.net.URLEncoder.encode(name, "UTF-8") %>,%20greetings%20from%20LifeDrop!%20Your%20mandatory%20recovery%20period%20is%20now%20complete%20and%20your%20body%20is%20ready%20to%20save%20another%20life.%20Are%20you%20available%20for%20donation%20this%20week?"
                               target="_blank" class="btn btn-sm btn-outline-success">
                                <i class="fa-brands fa-whatsapp me-1"></i> Send Renewal Ping
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                            if (!hasAny) {
                    %>
                    <tr><td colspan="6" class="text-center py-4 text-muted">No donor records found.</td></tr>
                    <%      }
                        } catch (Exception e) {
                    %>
                    <tr><td colspan="6" class="text-danger py-4">Error loading records: <%= e.getMessage() %></td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
