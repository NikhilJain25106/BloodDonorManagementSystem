<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon" aria-hidden="true">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Privacy Policy</h1>
                <p class="page-hero-sub">Compliance with India's Digital Personal Data Protection (DPDP) Act, 2023 & global privacy standards</p>
            </div>
        </div>
        <nav class="breadcrumb-custom" aria-label="Breadcrumb navigation">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1" aria-hidden="true"></i>Home</a>
            <span aria-hidden="true"><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current" aria-current="page">Privacy Policy</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius:20px;">
                <div class="d-flex align-items-center gap-2 mb-4 text-muted" style="font-size:0.85rem;">
                    <i class="fa-regular fa-clock" aria-hidden="true"></i>
                    <span>Effective Date: October 20, 2026 &middot; Version 2.0 (DPDP Act 2023 Compliant)</span>
                </div>

                <div class="p-3 mb-4 rounded-3" style="background:#eff6ff;border-left:4px solid #2563eb;">
                    <div class="fw-700 text-primary mb-1">
                        <i class="fa-solid fa-scale-balanced me-2" aria-hidden="true"></i>Statutory Notice under the DPDP Act, 2023
                    </div>
                    <p class="mb-0 text-secondary" style="font-size:0.88rem;line-height:1.6;">
                        This Privacy Notice is issued in strict conformity with Section 5 and Section 6 of the <strong>Digital Personal Data Protection Act, 2023 (Government of India)</strong>. LifeDrop functions as a Data Fiduciary processing personal data solely for voluntary, life-saving blood donation coordination.
                    </p>
                </div>

                <h2 class="h4 fw-700 text-dark mb-3">1. Information We Collect & Data Minimization</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    Under the principle of <em>Data Minimization</em>, LifeDrop only collects information strictly necessary for blood compatibility verification, donor safety intervals, and emergency communication:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>Personal Identity:</strong> Full Name, Age (mandatory verification for 18–65 clinical eligibility), and Gender.</li>
                    <li><strong>Contact Coordinates:</strong> 10-digit Mobile Number and Email Address (used for donor communication and digital card access).</li>
                    <li><strong>Location Data:</strong> City and General Area / Street (to route local emergency blood requests without collecting precise GPS coordinates).</li>
                    <li><strong>Medical & Donation Eligibility:</strong> Blood Group (ABO/Rh taxonomy), date of last blood donation (to enforce safety intervals of 90 days for men and 120 days for women).</li>
                    <li><strong>Authentication Security:</strong> BCrypt cryptographically salted password hashes (work factor 12) for administrative accounts. Plain-text passwords are never stored or logged.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">2. Purpose of Processing & Legal Basis</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    In compliance with Section 6 of the DPDP Act, your data is processed exclusively on the basis of your <strong>free, specific, informed, and unconditional consent</strong> for the following purposes:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>Enabling patients, doctors, and hospitals to locate matched, available blood donors in time-critical emergencies.</li>
                    <li>Issuing personalized Digital Donor Identification Cards and Certificates of Appreciation.</li>
                    <li>Enforcing health guidelines preventing premature repeat donations.</li>
                    <li>Preventing database corruption, spam registrations, and cyberattacks.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">3. Protection of Minors (Section 9 DPDP Act)</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    LifeDrop does not collect or process personal data of children under the age of 18. In accordance with National Blood Transfusion Council regulations and Section 9 of the DPDP Act, blood donor eligibility is strictly restricted to individuals aged 18 to 65.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">4. Non-Commercial Commitment & Zero Selling</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    <strong>We do NOT sell, rent, monetize, or trade personal data to third parties, pharmaceutical marketers, insurance brokers, or advertisers.</strong> Commercial sale of human blood is illegal in India under the Drugs and Cosmetics Act, 1940. LifeDrop exists solely for humanitarian, voluntary coordination.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">5. Data Principal Rights under DPDP Act</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    As a Data Principal, you possess statutory rights guaranteed by Sections 11, 12, and 13 of the DPDP Act, 2023:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>Right to Access Information (Sec 11):</strong> Request a summary of your personal data processed and identities of Data Fiduciaries with whom it was shared.</li>
                    <li><strong>Right to Correction & Erasure (Sec 12):</strong> Rectify inaccurate contact details or request permanent erasure of your donor profile from our database.</li>
                    <li><strong>Right to Withdraw Consent (Sec 6(4)):</strong> You may withdraw your consent at any time as easily as it was given. Upon withdrawal, your contact information will be deactivated from emergency search directories.</li>
                    <li><strong>Right of Grievance Redressal (Sec 13):</strong> Redressal of any grievance through our designated Grievance Officer within statutory timelines.</li>
                    <li><strong>Right to Nominate (Sec 14):</strong> Nominate an individual to exercise your rights in the event of death or incapacity.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">6. Technical & Organizational Security Measures</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    We maintain reasonable security safeguards to prevent personal data breaches (Section 8(5) DPDP Act): 256-bit TLS encryption in transit, BCrypt password hashing, rate limiting (10 req/IP/min) to prevent bulk scraping, SQL parameterized statements against injection, and strict role-based access control.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">7. Grievance Officer & Contact Details</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    To exercise your data principal rights, withdraw consent, or file a privacy inquiry, please contact our designated Grievance Officer:
                </p>
                <div class="p-4" style="background:#f8fafc;border-radius:14px;border:1px solid #e2e8f0;">
                    <div class="fw-700 text-dark mb-2">
                        <i class="fa-solid fa-user-shield text-danger me-2" aria-hidden="true"></i>Data Protection & Grievance Redressal Officer
                    </div>
                    <ul class="list-unstyled text-secondary mb-0" style="font-size:0.9rem;line-height:1.75;">
                        <li><strong>Officer:</strong> Nikhil Jain</li>
                        <li><strong>Organization:</strong> LifeDrop Humanitarian Blood Donor Management System</li>
                        <li><strong>Jurisdiction:</strong> Mumbai, Maharashtra, India</li>
                        <li><strong>Grievance Email:</strong> <a href="mailto:privacy@lifedrop.org" class="text-danger fw-600">privacy@lifedrop.org</a></li>
                        <li><strong>Support Email:</strong> <a href="mailto:help@lifedrop.org" class="text-danger fw-600">help@lifedrop.org</a></li>
                        <li><strong>Statutory Timeline:</strong> All privacy grievances are formally acknowledged within 24 hours and addressed within 15 working days.</li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
