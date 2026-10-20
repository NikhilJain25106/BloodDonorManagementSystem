<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon" aria-hidden="true">
                <i class="fa-solid fa-file-contract"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Terms & Conditions</h1>
                <p class="page-hero-sub">User charter, medical disclaimers, and voluntary donation guidelines</p>
            </div>
        </div>
        <nav class="breadcrumb-custom" aria-label="Breadcrumb navigation">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1" aria-hidden="true"></i>Home</a>
            <span aria-hidden="true"><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current" aria-current="page">Terms of Service</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius:20px;">
                <div class="d-flex align-items-center gap-2 mb-4 text-muted" style="font-size:0.85rem;">
                    <i class="fa-regular fa-clock" aria-hidden="true"></i>
                    <span>Effective Date: October 20, 2026 &middot; Version 2.0</span>
                </div>

                <div class="p-3 mb-4 rounded-3" style="background:#fff1f2;border-left:4px solid #e11d48;">
                    <div class="fw-700 text-danger mb-1">
                        <i class="fa-solid fa-triangle-exclamation me-2" aria-hidden="true"></i>Strict Non-Commercial & Medical Disclaimer
                    </div>
                    <p class="mb-0 text-secondary" style="font-size:0.88rem;line-height:1.6;">
                        Blood donation coordinated through LifeDrop is <strong>100% voluntary, humanitarian, and unremunerated</strong>. The buying, selling, or financial solicitation of human blood is illegal in India under the <em>Drugs and Cosmetics Act, 1940</em> and punishable by law.
                    </p>
                </div>

                <h2 class="h4 fw-700 text-dark mb-3">1. Nature of the Platform</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    LifeDrop is a digital directory connecting voluntary donors with individuals, doctors, and hospitals facing emergency blood shortages. <strong>LifeDrop is not a licensed blood bank, medical facility, diagnostic laboratory, or blood storage facility.</strong> We do not collect, process, test, store, or physically transfer blood products.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">2. Hospital & Blood Bank Medical Responsibility</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    All prospective blood donations facilitated via LifeDrop must occur exclusively at licensed blood banks, government hospitals, or accredited medical institutions. <strong>The attending healthcare institution is solely responsible for performing mandatory pre-donation health evaluations, hemoglobin tests, serological screenings (HIV-1/2, Hepatitis B, Hepatitis C, Syphilis, and Malaria), and ABO/Rh cross-matching.</strong> LifeDrop disclaims any liability arising from clinical procedures or post-transfusion reactions.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">3. Donor Eligibility & Representations</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    By registering as a donor, you explicitly represent and warrant that:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>You are between <strong>18 and 65 years</strong> of age.</li>
                    <li>You weigh at least <strong>50 kg</strong> for whole blood donation.</li>
                    <li>You have a hemoglobin count of at least <strong>12.5 g/dL</strong>.</li>
                    <li>At least <strong>90 days</strong> (for men) or <strong>120 days</strong> (for women) have elapsed since your last whole blood donation.</li>
                    <li>You are free from active viral infections, chronic heart conditions, or high-risk contraindications.</li>
                    <li>All submitted information (name, blood type, mobile number, city) is genuine and truthful.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">4. Acceptable Use & Prohibited Conduct</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    Users of the platform agree NOT to:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li>Solicit money, rewards, kickbacks, or commercial remuneration for blood donations.</li>
                    <li>Harass, spam, telemarket, or abuse registered donors whose contact details are accessed for emergency lookup.</li>
                    <li>Scrape, harvest, or bulk-extract donor phone numbers or emails for commercial marketing lists.</li>
                    <li>Attempt to breach platform rate limits, inject malicious scripts, or reverse-engineer the system.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">5. Limitation of Liability</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    To the maximum extent permitted by applicable law, LifeDrop, its developers, and contributors shall not be liable for any indirect, incidental, punitive, or consequential damages resulting from donor unresponsiveness, incorrect blood group declarations, missed medical appointments, or hospital procedures.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">6. Governing Law & Jurisdiction</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    These Terms and Conditions shall be governed by and construed in accordance with the laws of the <strong>Republic of India</strong>. Any legal dispute or proceeding arising out of or related to this platform shall be subject to the exclusive jurisdiction of the competent courts in <strong>Mumbai, Maharashtra, India</strong>.
                </p>

                <div class="p-4" style="background:#f8fafc;border-radius:14px;border:1px solid #e2e8f0;">
                    <div class="fw-700 text-dark mb-2">
                        <i class="fa-solid fa-scale-balanced text-danger me-2" aria-hidden="true"></i>Legal Contact & Administration
                    </div>
                    <p class="text-secondary mb-0" style="font-size:0.9rem;line-height:1.7;">
                        For legal notices or terms compliance questions, email <a href="mailto:privacy@lifedrop.org" class="text-danger fw-600">privacy@lifedrop.org</a> with the subject line <em>"Terms Inquiry - LifeDrop"</em>.
                    </p>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
