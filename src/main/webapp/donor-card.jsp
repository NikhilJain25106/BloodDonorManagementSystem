<%@ page import="com.blooddonor.model.Donor" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ include file="includes/header.jsp" %>

<%
    Donor d = (Donor) request.getAttribute("donor");
    if (d == null) {
        response.sendRedirect(cp + "/donorLogin");
        return;
    }

    String formattedId = String.format("LD-2026-%04d", d.getDonorId());

    // Calculate donation eligibility (standard 90 days gap)
    boolean isEligible = true;
    long daysSince = -1;
    long daysRemaining = 0;
    if (d.getLastDonationDate() != null) {
        LocalDate lastDate = d.getLastDonationDate().toLocalDate();
        LocalDate today = LocalDate.now();
        daysSince = ChronoUnit.DAYS.between(lastDate, today);
        if (daysSince < 90) {
            isEligible = false;
            daysRemaining = 90 - daysSince;
        }
    }

    String cardSuccess = (String) session.getAttribute("cardSuccess");
    if (cardSuccess != null) {
        session.removeAttribute("cardSuccess");
    }
    String cardError = (String) session.getAttribute("cardError");
    if (cardError != null) {
        session.removeAttribute("cardError");
    }
%>

<!-- HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="page-hero-icon">
                    <i class="fa-solid fa-id-card"></i>
                </div>
                <div>
                    <h1 class="page-hero-title">Personalized Donor ID Card</h1>
                    <p class="page-hero-sub">Welcome, <strong><%= d.getFullName() %></strong> &mdash; Your digital credentials & donation records</p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="<%= cp %>/donorCertificate" class="btn btn-warning btn-sm" style="font-weight:700;border-radius:10px;padding:0.5rem 1rem;background:#f59e0b;color:#fff;border:none;">
                    <i class="fa-solid fa-award me-1"></i>View Certificate
                </a>
                <button onclick="window.print()" class="btn btn-light btn-sm" style="font-weight:700;border-radius:10px;padding:0.5rem 1rem;">
                    <i class="fa-solid fa-print me-1"></i>Print ID Card
                </button>
            </div>
        </div>
    </div>
</section>

<div class="container py-5">

    <% if (cardSuccess != null) { %>
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" style="border-radius:14px;">
            <i class="fa-solid fa-circle-check me-2"></i><%= cardSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (cardError != null) { %>
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" style="border-radius:14px;">
            <i class="fa-solid fa-circle-exclamation me-2"></i><%= cardError %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="row g-4 justify-content-center">

        <!-- DIGITAL DONOR CARD (Printable component) -->
        <div class="col-lg-7">
            <div class="donor-id-card-wrapper" id="printableDonorCard">
                
                <!-- CARD HEADER -->
                <div class="donor-card-top">
                    <div class="d-flex align-items-center gap-2">
                        <div class="donor-card-logo-icon">
                            <i class="fa-solid fa-droplet text-white"></i>
                        </div>
                        <div>
                            <div class="donor-card-org">LifeDrop Blood Donor Network</div>
                            <div class="donor-card-type">OFFICIAL DIGITAL DONOR PASS</div>
                        </div>
                    </div>
                    <div class="donor-card-chip">
                        <i class="fa-solid fa-microchip"></i>
                    </div>
                </div>

                <!-- CARD MAIN BODY -->
                <div class="donor-card-body">
                    <div class="row align-items-center">
                        <div class="col-8">
                            <div class="donor-card-field-label">DONOR NAME</div>
                            <div class="donor-card-name"><%= d.getFullName() %></div>
                            
                            <div class="donor-card-meta-row mt-3">
                                <div>
                                    <div class="donor-card-field-label">DONOR ID</div>
                                    <div class="donor-card-value font-monospace"><%= formattedId %></div>
                                </div>
                                <div>
                                    <div class="donor-card-field-label">AGE / GENDER</div>
                                    <div class="donor-card-value"><%= d.getAge() %> yrs / <%= d.getGender() %></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4 text-end">
                            <div class="donor-card-blood-badge">
                                <div class="blood-group-huge"><%= d.getBloodGroup() %></div>
                                <div class="blood-type-sub">BLOOD GROUP</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD CONTACT & DETAILS STRIP -->
                <div class="donor-card-details-strip">
                    <div class="row g-2">
                        <div class="col-sm-6">
                            <div class="donor-strip-item">
                                <i class="fa-solid fa-phone text-danger"></i>
                                <span><strong>Phone:</strong> <%= d.getPhone() %></span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="donor-strip-item">
                                <i class="fa-solid fa-envelope text-primary"></i>
                                <span class="text-truncate"><strong>Email:</strong> <%= d.getEmail() %></span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="donor-strip-item">
                                <i class="fa-solid fa-location-dot text-danger"></i>
                                <span><strong>City:</strong> <%= d.getCity() %></span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="donor-strip-item">
                                <i class="fa-solid fa-map-pin text-secondary"></i>
                                <span class="text-truncate"><strong>Address:</strong> <%= d.getAddress() %></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD FOOTER: Status, Last Donation, QR Barcode -->
                <div class="donor-card-footer">
                    <div>
                        <div class="donor-card-field-label">DONATION STATUS</div>
                        <% if (isEligible) { %>
                            <span class="badge-status-eligible">
                                <i class="fa-solid fa-circle-check"></i> Eligible to Donate
                            </span>
                        <% } else { %>
                            <span class="badge-status-resting">
                                <i class="fa-solid fa-clock"></i> Resting (<%= daysRemaining %> days left)
                            </span>
                        <% } %>
                        <div class="small mt-1 text-muted" style="font-size:0.75rem;">
                            Last donated: <strong><%= d.getLastDonationDate() != null ? d.getLastDonationDate().toString() : "None Recorded" %></strong>
                        </div>
                    </div>
                    
                    <!-- Simulated Secure QR code graphic -->
                    <div class="donor-card-qr-box" title="Verified LifeDrop Donor Pass">
                        <div class="qr-mock-pattern">
                            <i class="fa-solid fa-qrcode fa-3x" style="color:#0f172a;"></i>
                        </div>
                        <small style="font-size:0.6rem;color:#64748b;font-weight:700;">VERIFIED</small>
                    </div>
                </div>

                <!-- Security Watermark Ribbon -->
                <div class="donor-card-ribbon">
                    <span>GOVERNMENT COMPLIANT &bull; VOLUNTARY BLOOD DONATION &bull; LIFEDROP INDIA</span>
                </div>

            </div>

            <!-- Print Advice -->
            <div class="text-center mt-3 d-print-none text-muted small">
                <i class="fa-solid fa-circle-info me-1 text-primary"></i>Tip: Click <strong>"Print ID Card"</strong> to save as a physical wallet card or PDF.
            </div>
        </div>

        <!-- SIDEBAR: Management & Certificate Quick Access -->
        <div class="col-lg-5 d-print-none">
            
            <!-- Certificate Promo Card -->
            <div class="card app-card p-4 mb-4" style="background:linear-gradient(135deg,#fffbeb,#fef3c7);border:1.5px solid #fde68a;">
                <div class="d-flex align-items-center gap-3 mb-3">
                    <div style="width:48px;height:48px;background:#f59e0b;border-radius:14px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:1.4rem;">
                        <i class="fa-solid fa-award"></i>
                    </div>
                    <div>
                        <h5 class="fw-800 mb-0" style="color:#78350f;">Blood Donation Certificate</h5>
                        <small style="color:#92400e;">Official Certificate of Appreciation</small>
                    </div>
                </div>
                <p style="font-size:0.88rem;color:#78350f;line-height:1.6;margin-bottom:1.25rem;">
                    Awarded for your noble and selfless blood donation saving valuable human lives. Download, print, or share your official credential.
                </p>
                <a href="<%= cp %>/donorCertificate" class="btn btn-warning w-100 fw-700" style="background:#f59e0b;color:#fff;border:none;border-radius:12px;padding:0.7rem;">
                    <i class="fa-solid fa-certificate me-1"></i>Open Official Certificate &rarr;
                </a>
            </div>

            <!-- Record Donation Date Form -->
            <div class="card app-card p-4">
                <div class="d-flex align-items-center gap-2 mb-3 pb-2" style="border-bottom:1px solid #f1f5f9;">
                    <i class="fa-solid fa-heart-pulse text-danger"></i>
                    <h6 class="fw-800 mb-0">Record a Blood Donation</h6>
                </div>
                <p class="text-muted small mb-3">
                    Donated blood recently? Log the date below to update your eligibility countdown and refresh your Certificate of Appreciation!
                </p>
                <form action="<%= cp %>/donorCard" method="post">
                    <div class="mb-3">
                        <label class="form-label small fw-700">Donation Date</label>
                        <input type="date" name="lastDonationDate" class="form-control"
                            value="<%= d.getLastDonationDate() != null ? d.getLastDonationDate().toString() : LocalDate.now().toString() %>"
                            max="<%= LocalDate.now().toString() %>" required style="border-radius:10px;">
                    </div>
                    <button type="submit" class="btn btn-brand w-100" style="border-radius:10px;font-size:0.88rem;padding:0.65rem;">
                        <i class="fa-solid fa-floppy-disk me-1"></i>Save & Update Certificate
                    </button>
                </form>
            </div>

            <!-- Quick Info -->
            <div class="card app-card p-4 mt-4" style="background:#f8fafc;">
                <h6 class="fw-800 mb-2 small text-uppercase" style="letter-spacing:1px;color:var(--gray-600);">Donor Support</h6>
                <div class="d-flex flex-column gap-2 small text-muted">
                    <div><i class="fa-solid fa-phone me-2 text-danger"></i>Emergency Blood Bank: <strong>+91 98765 43210</strong></div>
                    <div><i class="fa-solid fa-envelope me-2 text-primary"></i>Support: <strong>help@lifedrop.org</strong></div>
                    <div><i class="fa-solid fa-clock me-2 text-warning"></i>Minimum gap between donations: <strong>90 days</strong></div>
                </div>
            </div>

        </div>

    </div>

</div>

<%@ include file="includes/footer.jsp" %>
