<%@ include file="includes/header.jsp" %>
<%@ page import="com.blooddonor.model.Donor" %>

<%
    Donor d = (Donor) request.getAttribute("donor");
    if (d == null) {
        response.sendRedirect(request.getContextPath() + "/adminDashboard");
        return;
    }
%>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-pen-to-square"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Edit Donor</h1>
                <p class="page-hero-sub">Editing record for <strong style="color:#fff;"><%= d.getFullName() %></strong></p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <a href="<%= cp %>/adminDashboard">Dashboard</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Edit Donor</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger mb-4">
                    <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <div class="card app-card p-4 p-md-5">
                <!-- Section header -->
                <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid #f3f4f6;">
                    <div style="width:44px;height:44px;background:#eff6ff;border-radius:12px;display:flex;align-items:center;justify-content:center;color:#2563eb;font-size:1.2rem;flex-shrink:0;">
                        <i class="fa-solid fa-pen"></i>
                    </div>
                    <div>
                        <h5 class="fw-700 mb-0" style="color:var(--navy);">Update Donor Information</h5>
                        <p class="text-muted mb-0" style="font-size:0.82rem;">Fields marked <span style="color:var(--red);">*</span> are required</p>
                    </div>
                </div>

                <form action="<%= request.getContextPath() %>/updateDonor" method="post">
                    <input type="hidden" name="donorId" value="<%= d.getDonorId() %>">

                    <div class="row g-3">

                        <!-- Personal -->
                        <div class="col-12">
                            <p class="fw-600 mb-2" style="font-size:0.78rem;text-transform:uppercase;letter-spacing:1px;color:var(--gray-500);">Personal Details</p>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Full Name <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" name="fullName" class="form-control"
                                    value="<%= d.getFullName() != null ? d.getFullName() : "" %>" required>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Age <span style="color:var(--red);">*</span></label>
                            <input type="number" name="age" class="form-control"
                                min="18" max="65" value="<%= d.getAge() %>" required>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Gender <span style="color:var(--red);">*</span></label>
                            <select name="gender" class="form-select" required>
                                <option value="Male"   <%= "Male".equals(d.getGender())   ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= "Female".equals(d.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other"  <%= "Other".equals(d.getGender())  ? "selected" : "" %>>Other</option>
                            </select>
                        </div>

                        <!-- Blood -->
                        <div class="col-12 mt-2">
                            <p class="fw-600 mb-2" style="font-size:0.78rem;text-transform:uppercase;letter-spacing:1px;color:var(--gray-500);">Blood & Medical</p>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Blood Group <span style="color:var(--red);">*</span></label>
                            <select name="bloodGroup" class="form-select" required>
                                <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                                   for (String g : groups) { %>
                                    <option value="<%= g %>" <%= g.equals(d.getBloodGroup()) ? "selected" : "" %>><%= g %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Last Donation Date</label>
                            <input type="date" name="lastDonationDate" class="form-control"
                                value="<%= d.getLastDonationDate() != null ? d.getLastDonationDate() : "" %>">
                        </div>

                        <!-- Contact -->
                        <div class="col-12 mt-2">
                            <p class="fw-600 mb-2" style="font-size:0.78rem;text-transform:uppercase;letter-spacing:1px;color:var(--gray-500);">Contact Details</p>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Phone Number <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="tel" name="phone" class="form-control" maxlength="10"
                                    value="<%= d.getPhone() != null ? d.getPhone() : "" %>" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email Address <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="email" name="email" class="form-control"
                                    value="<%= d.getEmail() != null ? d.getEmail() : "" %>" required>
                            </div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Address <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-map-marker-alt"></i></span>
                                <input type="text" name="address" class="form-control"
                                    value="<%= d.getAddress() != null ? d.getAddress() : "" %>" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">City <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                                <input type="text" name="city" class="form-control"
                                    value="<%= d.getCity() != null ? d.getCity() : "" %>" required>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="col-12 mt-3 d-flex gap-3 flex-wrap">
                            <button type="submit" class="btn btn-brand btn-lg px-5" style="font-size:0.95rem;">
                                <i class="fa-solid fa-floppy-disk"></i> Save Changes
                            </button>
                            <a href="<%= request.getContextPath() %>/adminDashboard"
                               class="btn btn-outline-secondary btn-lg" style="border-radius:10px;font-weight:600;font-size:0.9rem;">
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
