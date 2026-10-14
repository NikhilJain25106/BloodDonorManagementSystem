<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Privacy Policy</h1>
                <p class="page-hero-sub">How LifeDrop protects and handles your donor and recipient data</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Privacy Policy</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius:20px;">
                <div class="d-flex align-items-center gap-2 mb-4 text-muted" style="font-size:0.85rem;">
                    <i class="fa-regular fa-clock"></i>
                    <span>Last updated: October 15, 2026 &middot; Version 1.0</span>
                </div>

                <h3 class="fw-700 text-dark mb-3">1. Information We Collect</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    When you voluntarily register as a donor or request blood units on LifeDrop, we collect information necessary to facilitate life-saving connections. This includes:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>Personal Identification:</strong> Full name, age, gender, and profile details.</li>
                    <li><strong>Contact Details:</strong> Verified phone number, email address, city, and state.</li>
                    <li><strong>Medical & Donation Details:</strong> Blood group (A+, A-, B+, B-, AB+, AB-, O+, O-), donation availability status, last donation date, and health readiness indicators.</li>
                    <li><strong>Account Credentials:</strong> Securely salted and hashed passwords (using BCrypt encryption). We never store plaintext passwords.</li>
                </ul>

                <h3 class="fw-700 text-dark mb-3">2. How We Use Your Information</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    LifeDrop operates strictly for emergency medical aid and voluntary blood donation coordination:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>Enabling patients, doctors, and hospitals to find matching, available blood donors nearby in emergencies.</li>
                    <li>Generating verified Donor Digital ID Cards and Donation Certificates recognizing donor contributions.</li>
                    <li>Sending critical reminders regarding donation eligibility intervals (standard 90-day rest periods).</li>
                    <li>Preventing fraud, duplicate registrations, and unauthorized database access.</li>
                </ul>

                <h3 class="fw-700 text-dark mb-3">3. Data Sharing & Visibility</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    <strong>We do not sell, rent, or trade your personal information to third-party advertisers or commercial entities.</strong>
                    Your contact information (name, city, blood group, phone number) is displayed in search results exclusively to facilitate urgent blood coordination when your status is marked as <em>"Available"</em>. You retain full control to toggle your availability or update your profile at any time.
                </p>

                <h3 class="fw-700 text-dark mb-3">4. Security Measures</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    We employ industry-standard encryption protocols (HTTPS/TLS in transit), BCrypt cryptographic hashing for passwords, parameterized database queries to thwart SQL injection, and role-based administrative controls to safeguard all stored records.
                </p>

                <h3 class="fw-700 text-dark mb-3">5. Your Rights & Data Deletion</h3>
                <p class="text-secondary leading-relaxed mb-4">
                    You have full right to access, rectify, or request the complete deletion of your donor profile and contact history. You can update your information from your donor dashboard or email us directly at <a href="mailto:help@lifedrop.org" class="text-danger fw-600">help@lifedrop.org</a>.
                </p>

                <div class="p-4 mt-3" style="background:#fef2f2;border-radius:14px;border-left:4px solid #e11d48;">
                    <div class="d-flex align-items-center gap-2 mb-1 text-danger fw-700">
                        <i class="fa-solid fa-circle-question"></i> Questions or Concerns?
                    </div>
                    <p class="mb-0 text-secondary" style="font-size:0.9rem;">
                        If you have any questions regarding this privacy policy or our data safety practices, please contact our Data Protection Officer at <a href="mailto:privacy@lifedrop.org" class="text-danger fw-600">privacy@lifedrop.org</a> or visit our <a href="<%= cp %>/contact.jsp" class="text-danger fw-600">Contact page</a>.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
