<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-file-contract"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Terms & Conditions</h1>
                <p class="page-hero-sub">Donor charter, user responsibilities, and guidelines for LifeDrop</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Terms of Service</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius:20px;">
                <div class="d-flex align-items-center gap-2 mb-4 text-muted" style="font-size:0.85rem;">
                    <i class="fa-regular fa-clock"></i>
                    <span>Effective Date: October 15, 2026 &middot; Version 1.0</span>
                </div>

                <h3 class="fw-700 text-dark mb-3">1. Acceptance of Terms</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    By registering, accessing, or using the LifeDrop Blood Donor Management System ("LifeDrop", "we", "our"), you agree to abide by these Terms and Conditions. If you do not agree with any part of these terms, please do not access or use the platform.
                </p>

                <h3 class="fw-700 text-dark mb-3">2. Voluntary & Non-Commercial Donation</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    LifeDrop is founded upon the humanitarian principle of <strong>voluntary, unremunerated blood donation</strong>:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>No Commercial Sale:</strong> Blood cannot be bought or sold through this platform. Any attempt to solicit money or financial gain for blood donation violates National Blood Policy and is strictly prohibited.</li>
                    <li><strong>Voluntary Consent:</strong> All donors register voluntarily and have the right to withdraw or toggle their availability at their discretion.</li>
                </ul>

                <h3 class="fw-700 text-dark mb-3">3. Donor Eligibility & Guidelines</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    To register as a blood donor on LifeDrop, you confirm that you satisfy standard clinical criteria:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>You are between 18 and 65 years of age.</li>
                    <li>You weigh at least 45 kg (or 50 kg for whole blood donation under local health norms).</li>
                    <li>You have a hemoglobin count of at least 12.5 g/dL.</li>
                    <li>At least 90 days have elapsed since your last whole blood donation.</li>
                    <li>You are free from active transmissible infections, cardiovascular conditions, or major contraindicating medications.</li>
                </ul>

                <h3 class="fw-700 text-dark mb-3">4. Emergency Verification Disclaimer</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    LifeDrop connects donors and recipients as an information facilitator. While we take rigorous measures to maintain accurate records, hospitals, doctors, and blood bank staff are ultimately responsible for standard mandatory pre-transfusion serological screenings (HIV, Hepatitis B/C, Syphilis, Malaria) and cross-matching before any transfusion takes place.
                </p>

                <h3 class="fw-700 text-dark mb-3">5. User Conduct & Zero-Tolerance Policy</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    Users agree not to:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>Register with fictitious names, falsified blood groups, or phone numbers that do not belong to them.</li>
                    <li>Harass, spam, or solicit donors for non-emergency or non-medical objectives.</li>
                    <li>Attempt to disrupt, breach security, or reverse-engineer the LifeDrop infrastructure.</li>
                </ul>

                <div class="p-4 mt-3" style="background:#f8fafc;border-radius:14px;border:1px solid #e2e8f0;">
                    <div class="fw-700 text-dark mb-2">
                        <i class="fa-solid fa-handshake-angle text-danger me-2"></i>Community Commitment
                    </div>
                    <p class="mb-0 text-secondary" style="font-size:0.9rem;line-height:1.7;">
                        Thank you for honoring the trust of recipients, hospitals, and donors. Together, our community saves thousands of precious lives each year.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
