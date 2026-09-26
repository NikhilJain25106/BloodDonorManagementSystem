<%@ include file="includes/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Donor" %>

<div class="container-fluid py-4 px-4">

    <%-- Header row --%>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-0"><i class="fa-solid fa-gauge text-danger me-2"></i>Admin Dashboard</h2>
            <p class="text-muted mb-0">Welcome, <%= session.getAttribute("adminFullName") %></p>
        </div>
        <a href="<%= request.getContextPath() %>/adminLogout" class="btn btn-outline-danger">
            <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
        </a>
    </div>

    <%-- Error message --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <%-- Stats row --%>
    <%
        List<Donor> donors = (List<Donor>) request.getAttribute("donors");
        int total = (donors != null) ? donors.size() : 0;
    %>
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card app-card p-3 text-center">
                <i class="fa-solid fa-users fa-2x text-danger mb-2"></i>
                <h3 class="fw-bold mb-0"><%= total %></h3>
                <small class="text-muted">Total Donors</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card app-card p-3 text-center">
                <i class="fa-solid fa-droplet fa-2x text-danger mb-2"></i>
                <h3 class="fw-bold mb-0">8</h3>
                <small class="text-muted">Blood Groups</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card app-card p-3 text-center">
                <i class="fa-solid fa-user-plus fa-2x text-danger mb-2"></i>
                <a href="<%= request.getContextPath() %>/registerDonor" class="btn btn-brand btn-sm mt-2">Add Donor</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card app-card p-3 text-center">
                <i class="fa-solid fa-magnifying-glass fa-2x text-danger mb-2"></i>
                <a href="<%= request.getContextPath() %>/searchDonors" class="btn btn-outline-danger btn-sm mt-2">Search Donors</a>
            </div>
        </div>
    </div>

    <%-- Donor Table --%>
    <div class="card app-card">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold">All Registered Donors</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Blood Group</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>City</th>
                            <th>Last Donation</th>
                            <th>Registered</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (donors == null || donors.isEmpty()) { %>
                            <tr>
                                <td colspan="11" class="text-center py-4 text-muted">
                                    <i class="fa-solid fa-inbox fa-2x mb-2 d-block"></i>No donors registered yet.
                                </td>
                            </tr>
                        <% } else {
                            int i = 1;
                            for (Donor donor : donors) { %>
                            <tr>
                                <td><%= i++ %></td>
                                <td class="fw-semibold"><%= donor.getFullName() %></td>
                                <td><span class="blood-badge"><%= donor.getBloodGroup() %></span></td>
                                <td><%= donor.getAge() %></td>
                                <td><%= donor.getGender() %></td>
                                <td><%= donor.getPhone() %></td>
                                <td><%= donor.getEmail() %></td>
                                <td><%= donor.getCity() %></td>
                                <td><%= donor.getLastDonationDate() != null ? donor.getLastDonationDate() : "-" %></td>
                                <td><small><%= donor.getCreatedAt() %></small></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/editDonor?id=<%= donor.getDonorId() %>"
                                       class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/deleteDonor?id=<%= donor.getDonorId() %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete <%= donor.getFullName() %>? This cannot be undone.')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
