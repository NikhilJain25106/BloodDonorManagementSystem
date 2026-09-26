<%@ include file="includes/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card app-card p-4">
                <h2 class="fw-bold mb-1"><i class="fa-solid fa-hand-holding-heart text-danger me-2"></i>Register as a Donor</h2>
                <p class="text-muted mb-4">Fill in your details below. Fields marked * are required.</p>

                <%-- Success message --%>
                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success"><i class="fa-solid fa-circle-check me-2"></i><%= request.getAttribute("successMessage") %></div>
                <% } %>

                <%-- Error message --%>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
                <% } %>

                <%
                    com.blooddonor.model.Donor d = (com.blooddonor.model.Donor) request.getAttribute("donor");
                    String v = "";
                %>

                <form action="<%= request.getContextPath() %>/registerDonor" method="post" id="registerForm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name *</label>
                            <input type="text" name="fullName" class="form-control" value="<%= d != null && d.getFullName() != null ? d.getFullName() : "" %>" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Age *</label>
                            <input type="number" name="age" class="form-control" min="18" max="65" value="<%= d != null && d.getAge() > 0 ? d.getAge() : "" %>" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Gender *</label>
                            <select name="gender" class="form-select" required>
                                <option value="">Select</option>
                                <option value="Male" <%= d != null && "Male".equals(d.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= d != null && "Female".equals(d.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= d != null && "Other".equals(d.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Blood Group *</label>
                            <select name="bloodGroup" class="form-select" required>
                                <option value="">Select</option>
                                <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                                   for (String g : groups) { %>
                                    <option value="<%= g %>" <%= d != null && g.equals(d.getBloodGroup()) ? "selected" : "" %>><%= g %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Phone Number *</label>
                            <input type="tel" name="phone" class="form-control" maxlength="10" value="<%= d != null && d.getPhone() != null ? d.getPhone() : "" %>" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Email Address *</label>
                            <input type="email" name="email" class="form-control" value="<%= d != null && d.getEmail() != null ? d.getEmail() : "" %>" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address *</label>
                            <input type="text" name="address" class="form-control" value="<%= d != null && d.getAddress() != null ? d.getAddress() : "" %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">City *</label>
                            <input type="text" name="city" class="form-control" value="<%= d != null && d.getCity() != null ? d.getCity() : "" %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Donation Date</label>
                            <input type="date" name="lastDonationDate" class="form-control" value="<%= d != null && d.getLastDonationDate() != null ? d.getLastDonationDate() : "" %>">
                        </div>
                        <div class="col-12 mt-2">
                            <button type="submit" class="btn btn-brand btn-lg px-5">
                                <i class="fa-solid fa-paper-plane me-2"></i>Register Now
                            </button>
                            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-secondary btn-lg ms-2">Cancel</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
