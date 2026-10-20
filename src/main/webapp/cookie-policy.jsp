<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon" aria-hidden="true">
                <i class="fa-solid fa-cookie-bite"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Cookie Policy</h1>
                <p class="page-hero-sub">Transparent disclosure of cookie usage and privacy controls on LifeDrop</p>
            </div>
        </div>
        <nav class="breadcrumb-custom" aria-label="Breadcrumb navigation">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1" aria-hidden="true"></i>Home</a>
            <span aria-hidden="true"><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current" aria-current="page">Cookie Policy</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card p-4 p-md-5 border-0 shadow-sm" style="border-radius:20px;">
                <div class="d-flex align-items-center gap-2 mb-4 text-muted" style="font-size:0.85rem;">
                    <i class="fa-regular fa-clock" aria-hidden="true"></i>
                    <span>Effective Date: October 20, 2026 &middot; Version 1.1</span>
                </div>

                <div class="p-3 mb-4 rounded-3" style="background:#f0fdf4;border-left:4px solid #16a34a;">
                    <div class="fw-700 text-success mb-1">
                        <i class="fa-solid fa-shield-check me-2" aria-hidden="true"></i>Zero Third-Party Tracking Pledge
                    </div>
                    <p class="mb-0 text-secondary" style="font-size:0.88rem;line-height:1.6;">
                        LifeDrop is a humanitarian platform. <strong>We do not use advertising, marketing, or behavioral tracking cookies.</strong> We only employ strictly necessary session cookies required for portal authentication and platform security.
                    </p>
                </div>

                <h2 class="h4 fw-700 text-dark mb-3">1. What Are Cookies?</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    Cookies are small text files stored on your browser or device by websites you visit. They allow websites to remember user sessions, enhance navigation, and maintain secure authentication states between page requests.
                </p>

                <h2 class="h4 fw-700 text-dark mb-3">2. Categories of Cookies We Use</h2>
                <div class="table-responsive mb-4">
                    <table class="table table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" style="width:20%;">Cookie Name</th>
                                <th scope="col" style="width:20%;">Provider</th>
                                <th scope="col" style="width:20%;">Lifespan</th>
                                <th scope="col" style="width:40%;">Purpose & Legal Basis</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><code>JSESSIONID</code></td>
                                <td>First-Party (LifeDrop)</td>
                                <td>Session (deleted on browser close)</td>
                                <td><strong>Strictly Necessary:</strong> Maintains authenticated donor and admin session state. Essential for CSRF defense and portal navigation.</td>
                            </tr>
                            <tr>
                                <td><code>lifedrop_cookie_consent</code></td>
                                <td>First-Party (Local Storage)</td>
                                <td>365 Days</td>
                                <td><strong>Preference / Compliance:</strong> Remembers your acknowledgment of our Cookie Notice so the notification banner is not displayed repeatedly.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <h2 class="h4 fw-700 text-dark mb-3">3. Cookies We DO NOT Use</h2>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>No Advertising Cookies:</strong> We do not serve advertisements, nor do we partner with ad networks (such as Google AdSense or Meta).</li>
                    <li><strong>No Cross-Site Behavioral Tracking:</strong> We do not track your activity across other websites or services.</li>
                    <li><strong>No Third-Party Analytics Trackers:</strong> No third-party tracking scripts (such as Google Analytics, Hotjar, or Mixpanel) are embedded.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">4. How to Control and Disable Cookies</h2>
                <p class="text-secondary leading-relaxed mb-3">
                    You can configure or block cookies at any time via your browser settings. Please note that blocking the strictly necessary <code>JSESSIONID</code> cookie will prevent logging into the Donor and Admin portals:
                </p>
                <ul class="text-secondary mb-4" style="line-height:1.8;">
                    <li><strong>Google Chrome:</strong> Settings &rarr; Privacy and security &rarr; Cookies and other site data.</li>
                    <li><strong>Mozilla Firefox:</strong> Settings &rarr; Privacy & Security &rarr; Enhanced Tracking Protection &rarr; Cookies.</li>
                    <li><strong>Apple Safari:</strong> Preferences &rarr; Privacy &rarr; Manage Website Data.</li>
                    <li><strong>Microsoft Edge:</strong> Settings &rarr; Cookies and site permissions &rarr; Manage and delete cookies.</li>
                </ul>

                <h2 class="h4 fw-700 text-dark mb-3">5. Updates and Contact Information</h2>
                <p class="text-secondary leading-relaxed mb-4">
                    Any future modifications to our cookie practices will be published on this page with an updated effective date. For inquiries concerning our cookie policy or data protection, please contact our Grievance Officer:
                </p>

                <div class="p-4" style="background:#f8fafc;border-radius:14px;border:1px solid #e2e8f0;">
                    <div class="fw-700 text-dark mb-2">
                        <i class="fa-solid fa-building-user text-danger me-2" aria-hidden="true"></i>Data Protection & Grievance Office
                    </div>
                    <ul class="list-unstyled text-secondary mb-0" style="font-size:0.9rem;line-height:1.7;">
                        <li><strong>Initiative:</strong> LifeDrop Blood Donor Management System</li>
                        <li><strong>Officer:</strong> Nikhil Jain (Grievance Officer)</li>
                        <li><strong>Location:</strong> Mumbai, Maharashtra, India</li>
                        <li><strong>Email:</strong> <a href="mailto:privacy@lifedrop.org" class="text-danger fw-600">privacy@lifedrop.org</a></li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
