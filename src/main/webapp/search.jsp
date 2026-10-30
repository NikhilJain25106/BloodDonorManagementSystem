<%@ include file="includes/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Donor" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Find Blood Donors</h1>
                <p class="page-hero-sub">Search by blood group and city to find available donors near you</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Search Donors</span>
        </nav>
    </div>
</section>

<div class="container py-5">

    <%-- Error message --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
    <% } %>

    <%-- Search Form --%>
    <div class="card app-card p-4 mb-5">
        <div class="d-flex align-items-center gap-2 mb-3">
            <i class="fa-solid fa-filter" style="color:var(--red);"></i>
            <h6 class="fw-700 mb-0">Filter Donors</h6>
        </div>
        <form action="<%= request.getContextPath() %>/searchDonors" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Blood Group Needed</label>
                    <select name="bloodGroup" class="form-select">
                        <option value="">Any Blood Group</option>
                        <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                           String selected = (String) request.getAttribute("selectedBloodGroup");
                           for (String g : groups) { %>
                            <option value="<%= g %>" <%= g.equals(selected) ? "selected" : "" %>><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">City</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                        <input type="text" name="city" class="form-control"
                            placeholder="e.g. Mumbai, Delhi, Pune..."
                            value="<%= request.getAttribute("selectedCity") != null ? request.getAttribute("selectedCity") : "" %>">
                    </div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-brand w-100" style="padding:0.7rem;justify-content:center;" aria-label="Search registered blood donors">
                        <i class="fa-solid fa-magnifying-glass me-1" aria-hidden="true"></i> Search Donors
                    </button>
                </div>
            </div>
        </form>
    </div>

    <%-- Results --%>
    <% if (Boolean.TRUE.equals(request.getAttribute("searchPerformed"))) {
        List<Donor> results = (List<Donor>) request.getAttribute("results");
        if (results == null || results.isEmpty()) { %>
            <div class="text-center py-5">
                <div style="width:80px;height:80px;background:var(--red-light);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 1.25rem;">
                    <i class="fa-solid fa-circle-xmark fa-2x" style="color:var(--red);"></i>
                </div>
                <h5 class="fw-700 mb-1" style="color:var(--navy);">No Donors Found</h5>
                <p class="text-muted" style="font-size:0.9rem;max-width:360px;margin:0 auto;">Try a different blood group or city. You can also leave city blank to search all locations.</p>
            </div>
        <% } else { %>
            <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
                <span class="result-count-badge">
                    <i class="fa-solid fa-users"></i> <%= results.size() %> Donor<%= results.size() != 1 ? "s" : "" %> Found
                </span>
                <span style="font-size:0.8rem;color:var(--gray-500);">Contact donors directly — details shown below</span>
            </div>
            <div class="row g-3">
                <% for (Donor donor : results) { %>
                <div class="col-md-6 col-lg-4">
                    <div class="donor-result-card h-100">

                        <!-- Header row: blood badge + name -->
                        <div class="d-flex align-items-start gap-3 mb-3">
                            <div>
                                <span class="blood-badge" style="font-size:1.1rem;min-width:60px;height:44px;">
                                    <%= donor.getBloodGroup() %>
                                </span>
                            </div>
                            <div style="flex:1;min-width:0;">
                                <h6 class="fw-700 mb-0" style="color:var(--navy);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                                    <%= donor.getFullName() %>
                                </h6>
                                <small class="text-muted"><%= donor.getGender() %>, Age <%= donor.getAge() %></small>
                            </div>
                            <span style="display:inline-flex;align-items:center;gap:4px;background:#ecfdf5;color:#059669;font-size:0.7rem;font-weight:700;padding:0.25rem 0.65rem;border-radius:50px;white-space:nowrap;flex-shrink:0;">
                                <i class="fa-solid fa-circle" style="font-size:0.45rem;"></i>Available
                            </span>
                        </div>

                        <!-- Details -->
                        <div class="d-flex flex-column gap-2" style="font-size:0.84rem;">
                            <div class="d-flex align-items-center gap-2">
                                <i class="fa-solid fa-location-dot" style="color:var(--red);width:16px;text-align:center;"></i>
                                <span style="color:#374151;"><%= donor.getCity() %></span>
                            </div>
                            <% if (donor.getLastDonationDate() != null) { %>
                            <div class="d-flex align-items-center gap-2">
                                <i class="fa-solid fa-calendar-check" style="color:#3b82f6;width:16px;text-align:center;"></i>
                                <span class="text-muted">Last donated: <strong style="color:#374151;"><%= donor.getLastDonationDate() %></strong></span>
                            </div>
                            <% } else { %>
                            <div class="d-flex align-items-center gap-2">
                                <i class="fa-solid fa-calendar" style="color:#9ca3af;width:16px;text-align:center;"></i>
                                <span class="text-muted">First-time donor</span>
                            </div>
                            <% } %>
                        </div>

                        <!-- Contact CTA -->
                        <div class="mt-3 pt-3 d-flex gap-2" style="border-top:1px solid #f3f4f6;">
                            <%
                                String dPhone = donor.getPhone() != null ? donor.getPhone() : "";
                                String dCleanPhone = dPhone.replaceAll("[^0-9]", "");
                                String dName = donor.getFullName() != null ? donor.getFullName() : "Donor";
                                String dBlood = donor.getBloodGroup() != null ? donor.getBloodGroup() : "";
                            %>
                            <a href="tel:<%= dPhone %>" class="btn btn-sm btn-outline-danger flex-fill" style="font-size:0.8rem;border-radius:8px;">
                                <i class="fa-solid fa-phone me-1"></i> Call
                            </a>
                            <a href="https://wa.me/91<%= dCleanPhone %>?text=Hello%20<%= java.net.URLEncoder.encode(dName, "UTF-8") %>,%20I%20found%20your%20profile%20on%20LifeDrop%20and%20urgently%20need%20<%= java.net.URLEncoder.encode(dBlood, "UTF-8") %>%20blood%20donation." 
                               target="_blank" rel="noopener noreferrer" 
                               class="btn btn-sm btn-success flex-fill" style="font-size:0.8rem;border-radius:8px;background:#25D366;border-color:#25D366;">
                                <i class="fa-brands fa-whatsapp me-1"></i> WhatsApp
                            </a>
                        </div>

                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    <% } else { %>
        <!-- Landing state: blood group shortcuts -->
        <div class="text-center mb-5">
            <span class="section-label">Quick Access</span>
            <h2 class="section-heading mt-2 mb-2">Browse by Blood Type</h2>
            <p class="text-muted" style="font-size:0.9rem;">Click any blood group to instantly find available donors</p>
        </div>
        <div class="row g-3 justify-content-center">
            <% String[] bgroups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
               for (String bg : bgroups) { %>
            <div class="col-6 col-sm-4 col-md-3 col-lg-auto">
                <a href="<%= cp %>/searchDonors?bloodGroup=<%= bg %>" class="blood-group-card">
                    <div class="blood-type"><%= bg %></div>
                    <div class="find-text"><i class="fa-solid fa-magnifying-glass me-1"></i>Find Donors</div>
                </a>
            </div>
            <% } %>
        </div>
    <% } %>

</div>

<%@ include file="includes/footer.jsp" %>
