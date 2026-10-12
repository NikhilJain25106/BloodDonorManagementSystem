<%@ page import="com.blooddonor.model.Donor" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="includes/header.jsp" %>

<%
    Donor d = (Donor) request.getAttribute("donor");
    if (d == null) {
        response.sendRedirect(cp + "/donorLogin");
        return;
    }

    String formattedId = String.format("LD-2026-%04d", d.getDonorId());
    String certDate = (d.getLastDonationDate() != null) ? d.getLastDonationDate().toString() : LocalDate.now().toString();
    String certNo = "CERT-LD-" + d.getDonorId() + "-" + certDate.replace("-", "");
%>

<!-- HERO (Screen only) -->
<section class="page-hero d-print-none">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="page-hero-icon" style="background:linear-gradient(135deg,#f59e0b,#d97706);color:#fff;">
                    <i class="fa-solid fa-award"></i>
                </div>
                <div>
                    <h1 class="page-hero-title">Blood Donation Certificate</h1>
                    <p class="page-hero-sub">Official Certificate of Appreciation for <strong><%= d.getFullName() %></strong></p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="<%= cp %>/donorCard" class="btn btn-outline-secondary btn-sm" style="border-radius:10px;font-weight:600;padding:0.5rem 1rem;background:#fff;">
                    <i class="fa-solid fa-id-card me-1 text-red"></i>Back to Donor Card
                </a>
                <button onclick="window.print()" class="btn btn-brand btn-sm" style="font-weight:700;border-radius:10px;padding:0.5rem 1.25rem;">
                    <i class="fa-solid fa-print me-1"></i>Print / Download Certificate
                </button>
            </div>
        </div>
    </div>
</section>

<div class="container py-5">

    <!-- Print Tip notice (Hidden in print) -->
    <div class="alert alert-light border d-print-none mb-4 d-flex align-items-center justify-content-between flex-wrap gap-2" style="border-radius:14px;background:#fefce8;border-color:#fef08a !important;">
        <div class="d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-check text-warning fa-lg"></i>
            <span style="font-size:0.88rem;color:#713f12;">Official verification: This certificate acknowledges voluntary blood donation under <strong>LifeDrop Foundation</strong>.</span>
        </div>
        <button onclick="window.print()" class="btn btn-warning btn-sm fw-700" style="background:#f59e0b;color:#fff;border:none;border-radius:8px;">
            <i class="fa-solid fa-file-pdf me-1"></i>Save as PDF
        </button>
    </div>

    <!-- CERTIFICATE CONTAINER -->
    <div class="certificate-outer-wrapper">
        <div class="certificate-inner-border">
            
            <!-- Corner ornaments -->
            <div class="cert-corner tl"></div>
            <div class="cert-corner tr"></div>
            <div class="cert-corner bl"></div>
            <div class="cert-corner br"></div>

            <!-- Header with logo and emblem -->
            <div class="cert-header text-center">
                <div class="d-inline-flex align-items-center gap-2 mb-2">
                    <div style="width:42px;height:42px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:12px;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 14px rgba(225,29,72,0.35);">
                        <i class="fa-solid fa-droplet text-white fa-lg"></i>
                    </div>
                    <span style="font-size:1.6rem;font-weight:900;letter-spacing:-0.5px;color:#0f172a;">Life<span style="color:#e11d48;">Drop</span></span>
                </div>
                <div class="cert-authority-title">NATIONAL BLOOD DONOR RECOGNITION PROGRAM</div>
                <h1 class="cert-main-title">Certificate of Appreciation</h1>
                <div class="cert-ribbon-sub">HONORING A HERO WHO GAVE THE NOBLE GIFT OF LIFE</div>
            </div>

            <!-- Recipient name -->
            <div class="cert-body text-center my-4">
                <p class="cert-intro-text">THIS CERTIFICATE IS PROUDLY PRESENTED TO</p>
                <div class="cert-recipient-name"><%= d.getFullName() %></div>
                
                <div class="cert-divider-line"></div>

                <p class="cert-statement">
                    In deep gratitude for your voluntary and selfless donation of blood. By generously contributing 
                    Blood Group <span class="cert-highlight-blood"><%= d.getBloodGroup() %></span> on <strong><%= certDate %></strong>, 
                    you have saved lives and brought new hope to patients in critical care. Your compassion exemplifies humanity at its finest.
                </p>
            </div>

            <!-- Credentials row -->
            <div class="cert-credentials-row">
                <div class="cert-cred-item">
                    <span class="cred-label">DONOR ID</span>
                    <span class="cred-val font-monospace"><%= formattedId %></span>
                </div>
                <div class="cert-cred-item">
                    <span class="cred-label">BLOOD GROUP</span>
                    <span class="cred-val"><%= d.getBloodGroup() %></span>
                </div>
                <div class="cert-cred-item">
                    <span class="cred-label">LOCATION</span>
                    <span class="cred-val"><%= d.getCity() %></span>
                </div>
                <div class="cert-cred-item">
                    <span class="cred-label">CERTIFICATE ID</span>
                    <span class="cred-val font-monospace"><%= certNo %></span>
                </div>
            </div>

            <!-- Bottom: Seal and Signatures -->
            <div class="cert-footer-row mt-5">
                
                <!-- Signature 1 -->
                <div class="cert-sig-block text-center">
                    <div class="cert-signature-img">
                        <i class="fa-solid fa-signature fa-2x text-muted"></i>
                    </div>
                    <div class="cert-sig-line"></div>
                    <div class="cert-sig-name">Dr. Arvind Sharma, M.D.</div>
                    <div class="cert-sig-role">Chief of Transfusion Medicine</div>
                </div>

                <!-- Golden Seal -->
                <div class="cert-golden-seal-box text-center">
                    <div class="cert-golden-seal">
                        <div class="seal-inner">
                            <i class="fa-solid fa-star mb-1" style="color:#d97706;font-size:0.75rem;"></i>
                            <div class="seal-text-top">LIFEDROP</div>
                            <div class="seal-badge-center">
                                <i class="fa-solid fa-award"></i>
                            </div>
                            <div class="seal-text-bot">OFFICIAL SEAL</div>
                        </div>
                    </div>
                    <div class="seal-verified-text">OFFICIAL RECORD</div>
                </div>

                <!-- Signature 2 -->
                <div class="cert-sig-block text-center">
                    <div class="cert-signature-img">
                        <i class="fa-solid fa-signature fa-2x text-muted"></i>
                    </div>
                    <div class="cert-sig-line"></div>
                    <div class="cert-sig-name">Nikhil Jain</div>
                    <div class="cert-sig-role">Director, LifeDrop Network</div>
                </div>

            </div>

        </div>
    </div>

</div>

<%@ include file="includes/footer.jsp" %>
