<%@ include file="includes/header.jsp" %>
<%@ page import="com.blooddonor.model.Donor" %>

<%
    Donor d = (Donor) request.getAttribute("donor");
    if (d == null) {
        response.sendRedirect(request.getContextPath() + "/adminDashboard");
        return;
    }
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card app-card p-4">
                <h2 class="fw-bold mb-1">
                    <i class="fa-solid fa-pen text-danger me-2"></i>Edit Donor
                </h2>
                <p class="text-muted mb-4">Editing record for <strong><%= d.getFullName() %></strong></p>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/updateDonor" method="post">
                    <%-- Hidden field carries the donor ID so the servlet knows which row to UPDATE --%>
                    <input type="hidden" name="donorId" value="<%= d.getDonorId() %>">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name *</label>
                            <input type="text" name="fullName" class="form-control"
                                value="<%= d.getFullName() != null ? d.getFullName() : "" %>" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Age *</label>
                            <input type="number" name="age" class="form-control"
                                min="18" max="65" value="<%= d.getAge() %>" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Gender *</label>
                            <select name="gender" class="form-select" required>
                                <option value="Male" <%= "Male".equals(d.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= "Female".equals(d.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= "Other".equals(d.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Blood Group *</label>
                            <select name="bloodGroup" class="form-select" required>
                                <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                                   for (String g : groups) { %>
                                    <option value="<%= g %>" <%= g.equals(d.getBloodGroup()) ? "selected" : "" %>><%= g %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Phone Number *</label>
                            <input type="tel" name="phone" class="form-control" maxlength="10"
                                value="<%= d.getPhone() != null ? d.getPhone() : "" %>" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Email Address *</label>
                            <input type="email" name="email" class="form-control"
                                value="<%= d.getEmail() != null ? d.getEmail() : "" %>" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address *</label>
                            <input type="text" name="address" class="form-control"
                                value="<%= d.getAddress() != null ? d.getAddress() : "" %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">City *</label>
                            <input type="text" name="city" class="form-control"
                                value="<%= d.getCity() != null ? d.getCity() : "" %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Donation Date</label>
                            <input type="date" name="lastDonationDate" class="form-control"
                                value="<%= d.getLastDonationDate() != null ? d.getLastDonationDate() : "" %>">
                        </div>
                        <div class="col-12 mt-2">
                            <button type="submit" class="btn btn-brand btn-lg px-5">
                                <i class="fa-solid fa-floppy-disk me-2"></i>Save Changes
                            </button>
                            <a href="<%= request.getContextPath() %>/adminDashboard" class="btn btn-outline-secondary btn-lg ms-2">
                                Cancel
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
