</main>

<footer class="app-footer">
    <div class="container" style="position:relative;z-index:1;">
        <div class="row g-5 pb-4" style="border-bottom:1px solid rgba(255,255,255,0.08);">
            <div class="col-lg-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div style="width:38px;height:38px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:11px;display:flex;align-items:center;justify-content:center;">
                        <i class="fa-solid fa-droplet text-white" style="font-size:0.95rem;" aria-hidden="true"></i>
                    </div>
                    <span class="text-white fw-800" style="font-size:1.2rem;">Life<span style="color:#fda4af;">Drop</span></span>
                </div>
                <p style="font-size:0.85rem;line-height:1.75;max-width:300px;margin-bottom:1.2rem;color:rgba(255,255,255,0.75);">
                    A voluntary, non-commercial Blood Donor Management System connecting emergency recipients with voluntary blood donors across India.
                </p>
                <div class="d-flex gap-2 mb-3">
                    <a href="https://github.com/NikhilJain25106/BloodDonorManagementSystem" target="_blank" rel="noopener noreferrer" class="footer-social-btn" aria-label="LifeDrop Source Code on GitHub">
                        <i class="fa-brands fa-github" aria-hidden="true"></i>
                    </a>
                    <a href="mailto:help@lifedrop.org" class="footer-social-btn" aria-label="Email LifeDrop Support">
                        <i class="fa-solid fa-envelope" aria-hidden="true"></i>
                    </a>
                </div>
                <div class="d-inline-flex align-items-center gap-2 px-2 py-1 rounded" style="background:rgba(255,255,255,0.06);font-size:0.75rem;color:rgba(255,255,255,0.7);">
                    <i class="fa-solid fa-scale-balanced text-success" aria-hidden="true"></i>
                    <span>DPDP Act 2023 Compliant</span>
                </div>
            </div>
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Legal &amp; Policy</h6>
                <div class="d-flex flex-column">
                    <a href="<%= cp %>/privacy.jsp" class="footer-link"><i class="fa-solid fa-shield-halved" style="width:14px;" aria-hidden="true"></i>Privacy Policy</a>
                    <a href="<%= cp %>/terms.jsp" class="footer-link"><i class="fa-solid fa-file-contract" style="width:14px;" aria-hidden="true"></i>Terms of Service</a>
                    <a href="<%= cp %>/cookie-policy.jsp" class="footer-link"><i class="fa-solid fa-cookie-bite" style="width:14px;" aria-hidden="true"></i>Cookie Policy</a>
                    <a href="<%= cp %>/contact.jsp" class="footer-link"><i class="fa-solid fa-envelope" style="width:14px;" aria-hidden="true"></i>Contact &amp; Grievances</a>
                    <a href="<%= cp %>/adminLogin" class="footer-link"><i class="fa-solid fa-user-shield" style="width:14px;" aria-hidden="true"></i>Admin Portal</a>
                </div>
            </div>
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Navigation</h6>
                <div class="d-flex flex-column">
                    <a href="<%= cp %>/index.jsp" class="footer-link"><i class="fa-solid fa-house" style="width:14px;" aria-hidden="true"></i>Home</a>
                    <a href="<%= cp %>/registerDonor" class="footer-link"><i class="fa-solid fa-user-plus" style="width:14px;" aria-hidden="true"></i>Register as Donor</a>
                    <a href="<%= cp %>/searchDonors" class="footer-link"><i class="fa-solid fa-magnifying-glass" style="width:14px;" aria-hidden="true"></i>Search Donors</a>
                    <a href="<%= cp %>/donorLogin" class="footer-link"><i class="fa-solid fa-id-card" style="width:14px;" aria-hidden="true"></i>Donor Card Login</a>
                </div>
            </div>
            <div class="col-lg-4">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Business &amp; Grievance Redressal</h6>
                <div class="d-flex flex-column gap-2" style="font-size:0.85rem;color:rgba(255,255,255,0.75);">
                    <div><strong>Organization:</strong> LifeDrop Humanitarian Blood Donor Management System</div>
                    <div><strong>Operating Authority:</strong> Academic &amp; Voluntary Community Service</div>
                    <div><strong>Grievance Officer:</strong> Nikhil Jain (<a href="mailto:privacy@lifedrop.org" class="text-white text-decoration-underline">privacy@lifedrop.org</a>)</div>
                    <div><strong>Location:</strong> Mumbai, Maharashtra, India</div>
                    <div><strong>Support Email:</strong> <a href="mailto:help@lifedrop.org" class="text-white text-decoration-underline">help@lifedrop.org</a></div>
                    <div class="small text-muted mt-1" style="font-size:0.75rem;color:rgba(255,255,255,0.5) !important;">
                        *LifeDrop is an informational facilitating directory. Commercial sale of blood is strictly prohibited by law.
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex flex-wrap justify-content-between align-items-center pt-4 gap-2">
            <p class="mb-0" style="font-size:0.8rem;color:rgba(255,255,255,0.75);">&copy; 2026 LifeDrop. Developed by <span class="text-white fw-700">Nikhil Jain</span> &mdash; Voluntary Blood Donor Network</p>
            <p class="mb-0" style="font-size:0.8rem;color:rgba(255,255,255,0.75);">Made with <i class="fa-solid fa-heart text-red" aria-hidden="true"></i> for saving lives &middot; Zero Commercial Ads</p>
        </div>
    </div>
</footer>

<!-- ACCESSIBLE COOKIE CONSENT BANNER -->
<div id="cookieConsentBanner" role="region" aria-label="Cookie consent banner" style="display:none;position:fixed;bottom:20px;left:20px;right:20px;max-width:850px;margin:0 auto;background:#0f172a;color:#f8fafc;padding:1.25rem 1.75rem;border-radius:18px;box-shadow:0 24px 60px rgba(0,0,0,0.5);border:1px solid rgba(255,255,255,0.15);z-index:9999;backdrop-filter:blur(16px);">
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
        <div class="d-flex align-items-start gap-3">
            <div style="width:40px;height:40px;background:rgba(225,29,72,0.2);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;color:#fda4af;">
                <i class="fa-solid fa-cookie-bite fa-lg" aria-hidden="true"></i>
            </div>
            <div>
                <div class="fw-700 mb-1" style="font-size:0.95rem;color:#ffffff;">Transparent Cookie &amp; Privacy Notice</div>
                <p class="mb-0 text-secondary" style="font-size:0.84rem;color:#cbd5e1 !important;line-height:1.5;">
                    LifeDrop uses only <strong>strictly necessary session cookies</strong> for authentication and CSRF defense. We do NOT use third-party analytics, marketing, or tracking cookies. Learn more in our <a href="<%= cp %>/cookie-policy.jsp" class="text-danger fw-600 text-decoration-underline">Cookie Policy</a>.
                </p>
            </div>
        </div>
        <div class="d-flex gap-2 flex-shrink-0 align-self-end align-self-md-center">
            <button type="button" id="acceptCookieConsentBtn" class="btn btn-brand btn-sm" style="padding:0.5rem 1.25rem;font-size:0.85rem;border-radius:10px;white-space:nowrap;" aria-label="Accept strictly necessary cookies">
                <i class="fa-solid fa-check me-1" aria-hidden="true"></i> Accept Essential Cookies
            </button>
            <a href="<%= cp %>/cookie-policy.jsp" class="btn btn-outline-light btn-sm" style="padding:0.5rem 1rem;font-size:0.85rem;border-radius:10px;white-space:nowrap;" aria-label="View Cookie Policy">
                Settings
            </a>
        </div>
    </div>
</div>

<script>
// Accessible Cookie Consent Handler
(function() {
    try {
        if (!localStorage.getItem('lifedrop_cookie_consent')) {
            var banner = document.getElementById('cookieConsentBanner');
            if (banner) {
                banner.style.display = 'block';
                var acceptBtn = document.getElementById('acceptCookieConsentBtn');
                if (acceptBtn) {
                    acceptBtn.addEventListener('click', function() {
                        localStorage.setItem('lifedrop_cookie_consent', 'accepted');
                        banner.style.display = 'none';
                    });
                }
            }
        }
    } catch(e) {
        // LocalStorage unavailable, fail safely
    }
})();
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/validation.js"></script>
</body>
</html>
