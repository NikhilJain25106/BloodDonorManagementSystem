<%@ include file="includes/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Donor" %>

<div class="container py-5">
    <h2 class="fw-bold mb-1"><i class="fa-solid fa-magnifying-glass text-danger me-2"></i>Search Donors</h2>
    <p class="text-muted mb-4">Search by blood group and/or city to find available donors near you.</p>

    <%-- Error message --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <%-- Search Form --%>
    <div class="card app-card p-4 mb-4">
        <form action="<%= request.getContextPath() %>/searchDonors" method="get" class="row g-3 align-items-end">
            <div class="col-md-4">
                <label class="form-label">Blood Group</label>
                <select name="bloodGroup" class="form-select">
                    <option value="">Any Blood Group</option>
                    <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                       String selected = (String) request.getAttribute("selectedBloodGroup");
                       for (String g : groups) { %>
                        <option value="<%= g %>" <%= g.equals(selected) ? "selected" : "" %>><%= g %></option>
                    <% } %>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label">City</label>
                <input type="text" name="city" class="form-control" placeholder="e.g. Mumbai"
                    value="<%= request.getAttribute("selectedCity") != null ? request.getAttribute("selectedCity") : "" %>">
            </div>
            <div class="col-md-4">
                <button type="submit" class="btn btn-brand w-100">
                    <i class="fa-solid fa-magnifying-glass me-2"></i>Search
                </button>
            </div>
        </form>
    </div>

    <%-- Results --%>
    <% if (Boolean.TRUE.equals(request.getAttribute("searchPerformed"))) {
        List<Donor> results = (List<Donor>) request.getAttribute("results");
        if (results == null || results.isEmpty()) { %>
            <div class="alert alert-info">
                <i class="fa-solid fa-circle-info me-2"></i>No donors found matching your search. Try a different blood group or city.
            </div>
        <% } else { %>
            <p class="text-muted mb-3">Found <strong><%= results.size() %></strong> donor(s).</p>
            <div class="row g-3">
                <% for (Donor donor : results) { %>
                <div class="col-md-6 col-lg-4">
                    <div class="card app-card h-100 p-3">
                        <div class="d-flex align-items-center mb-3">
                            <span class="blood-badge me-3"><%= donor.getBloodGroup() %></span>
                            <div>
                                <h6 class="mb-0 fw-bold"><%= donor.getFullName() %></h6>
                                <small class="text-muted"><%= donor.getGender() %>, Age <%= donor.getAge() %></small>
                            </div>
                        </div>
                        <p class="mb-1"><i class="fa-solid fa-location-dot text-danger me-2"></i><%= donor.getCity() %></p>
                        <% if (donor.getLastDonationDate() != null) { %>
                            <p class="mb-0 small text-muted">
                                <i class="fa-solid fa-calendar me-1"></i>Last donated: <%= donor.getLastDonationDate() %>
                            </p>
                        <% } else { %>
                            <p class="mb-0 small text-muted"><i class="fa-solid fa-calendar me-1"></i>No previous donation</p>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    <% } %>
</div>

<%@ include file="includes/footer.jsp" %>
