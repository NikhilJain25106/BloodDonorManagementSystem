<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-hand-holding-heart"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Register as a Donor</h1>
                <p class="page-hero-sub">Join thousands of heroes saving lives every day</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Register</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <%-- Success message --%>
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success mb-4 p-4" style="border-radius:16px;">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fa-solid fa-circle-check fa-lg"></i>
                        <h6 class="mb-0 fw-800"><%= request.getAttribute("successMessage") %></h6>
                    </div>
                    <p class="mb-3 small">Your registration is complete. You can now view and download your personalized LifeDrop Donor ID Card or your Certificate of Appreciation.</p>
                    <div class="d-flex gap-2 flex-wrap">
                        <a href="<%= cp %>/donorCard" class="btn btn-brand btn-sm" style="font-size:0.85rem;padding:0.5rem 1.2rem;">
                            <i class="fa-solid fa-id-card me-1"></i>View My Donor ID Card
                        </a>
                        <a href="<%= cp %>/donorCertificate" class="btn btn-outline-secondary btn-sm" style="font-size:0.85rem;padding:0.5rem 1.2rem;background:#fff;">
                            <i class="fa-solid fa-certificate me-1"></i>View Certificate
                        </a>
                    </div>
                </div>
            <% } %>

            <%-- Error message --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger mb-4"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <%
                com.blooddonor.model.Donor d = (com.blooddonor.model.Donor) request.getAttribute("donor");
            %>

            <div class="card app-card p-4 p-md-5">
                <!-- Section header -->
                <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid #f3f4f6;">
                    <div style="width:44px;height:44px;background:var(--red-light);border-radius:12px;display:flex;align-items:center;justify-content:center;color:var(--red);font-size:1.2rem;flex-shrink:0;">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <div>
                        <h5 class="fw-700 mb-0" style="color:var(--navy);">Donor Information</h5>
                        <p class="text-muted mb-0" style="font-size:0.82rem;">Fields marked <span style="color:var(--red);">*</span> are required</p>
                    </div>
                </div>

                <form action="<%= request.getContextPath() %>/registerDonor" method="post" id="registerForm">
                    <div class="row g-3">

                        <!-- Personal Details -->
                        <div class="col-12">
                            <p class="fw-600 mb-2" style="font-size:0.78rem;text-transform:uppercase;letter-spacing:1px;color:var(--gray-500);">Personal Details</p>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Full Name <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" name="fullName" class="form-control"
                                    value="<%= d != null && d.getFullName() != null ? d.getFullName() : "" %>"
                                    placeholder="e.g. Nikhil Jain" required>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Age <span style="color:var(--red);">*</span></label>
                            <input type="number" name="age" class="form-control" min="18" max="65"
                                value="<%= d != null && d.getAge() > 0 ? d.getAge() : "" %>"
                                placeholder="18–65" required>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Gender <span style="color:var(--red);">*</span></label>
                            <select name="gender" class="form-select" required>
                                <option value="">Select</option>
                                <option value="Male"   <%= d != null && "Male".equals(d.getGender())   ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= d != null && "Female".equals(d.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other"  <%= d != null && "Other".equals(d.getGender())  ? "selected" : "" %>>Other</option>
                            </select>
                        </div>

                        <!-- Blood & Medical -->
                        <div class="col-12 mt-2">
                            <p class="fw-600 mb-2" style="font-size:0.78rem;text-transform:uppercase;letter-spacing:1px;color:var(--gray-500);">Blood & Medical</p>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Blood Group <span style="color:var(--red);">*</span></label>
                            <select name="bloodGroup" class="form-select" required>
                                <option value="">Select</option>
                                <% String[] groups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                                   for (String g : groups) { %>
                                    <option value="<%= g %>" <%= d != null && g.equals(d.getBloodGroup()) ? "selected" : "" %>><%= g %></option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Last Donation Date</label>
                            <input type="date" name="lastDonationDate" class="form-control"
                                value="<%= d != null && d.getLastDonationDate() != null ? d.getLastDonationDate() : "" %>">
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
                                    value="<%= d != null && d.getPhone() != null ? d.getPhone() : "" %>"
                                    placeholder="10-digit mobile" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email Address <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="email" name="email" class="form-control"
                                    value="<%= d != null && d.getEmail() != null ? d.getEmail() : "" %>"
                                    placeholder="you@example.com" required>
                            </div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Address <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-map-marker-alt"></i></span>
                                <input type="text" name="address" class="form-control"
                                    value="<%= d != null && d.getAddress() != null ? d.getAddress() : "" %>"
                                    placeholder="Street / Society / Area" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">City <span style="color:var(--red);">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                                <input type="text" name="city" class="form-control"
                                    value="<%= d != null && d.getCity() != null ? d.getCity() : "" %>"
                                    placeholder="e.g. Mumbai" required>
                            </div>
                        </div>

                        <!-- Statutory DPDP Act & Medical Consent -->
                        <div class="col-12 mt-4 p-3 rounded-3" style="background:#f8fafc;border:1px solid #e2e8f0;">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="consentDpdp" id="consentDpdp" value="true" required>
                                <label class="form-check-label" for="consentDpdp" style="font-size:0.85rem;color:#334155;line-height:1.5;">
                                    <strong>Statutory DPDP Consent:</strong> I give free, specific, and informed consent under the <em>Digital Personal Data Protection (DPDP) Act, 2023</em> for LifeDrop to process and display my blood group, city, and contact coordinates to emergency patients and hospitals seeking blood, as detailed in the <a href="<%= request.getContextPath() %>/privacy.jsp" target="_blank" class="text-danger fw-600">Privacy Policy</a>. <span style="color:var(--red);">*</span>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="consentTerms" id="consentTerms" value="true" required>
                                <label class="form-check-label" for="consentTerms" style="font-size:0.85rem;color:#334155;line-height:1.5;">
                                    <strong>Voluntary & Medical Declaration:</strong> I agree to the <a href="<%= request.getContextPath() %>/terms.jsp" target="_blank" class="text-danger fw-600">Terms & Conditions</a>. I confirm that I am donating 100% voluntarily without financial compensation and satisfy standard clinical eligibility criteria (18–65 years, weight ≥ 50kg). <span style="color:var(--red);">*</span>
                                </label>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="col-12 mt-3 d-flex gap-3 flex-wrap">
                            <button type="submit" class="btn btn-brand btn-lg px-5" style="font-size:0.95rem;" aria-label="Submit voluntary blood donor registration">
                                <i class="fa-solid fa-heart-pulse me-1" aria-hidden="true"></i> Submit Voluntary Registration
                            </button>
                            <a href="<%= request.getContextPath() %>/index.jsp"
                               class="btn btn-outline-secondary btn-lg" style="border-radius:10px;font-weight:600;font-size:0.9rem;" aria-label="Cancel registration and return to homepage">
                                Cancel
                            </a>
                        </div>

                    </div>
                </form>
            </div>

            <!-- Reassurance bar -->
            <div class="d-flex flex-wrap justify-content-center gap-4 mt-4" style="font-size:0.82rem;color:var(--gray-500);">
                <span><i class="fa-solid fa-shield-check me-1" style="color:#10b981;"></i>Free to register</span>
                <span><i class="fa-solid fa-lock me-1" style="color:#3b82f6;"></i>Data is secure</span>
                <span><i class="fa-solid fa-clock me-1" style="color:#f59e0b;"></i>Takes under 2 minutes</span>
            </div>

        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
