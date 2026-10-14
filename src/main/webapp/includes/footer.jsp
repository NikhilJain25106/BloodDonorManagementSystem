</main>

<footer class="app-footer">
    <div class="container" style="position:relative;z-index:1;">
        <div class="row g-5 pb-4" style="border-bottom:1px solid rgba(255,255,255,0.08);">
            <div class="col-lg-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div style="width:38px;height:38px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:11px;display:flex;align-items:center;justify-content:center;">
                        <i class="fa-solid fa-droplet text-white" style="font-size:0.95rem;"></i>
                    </div>
                    <span class="text-white fw-800" style="font-size:1.2rem;">Life<span style="color:#fda4af;">Drop</span></span>
                </div>
                <p style="font-size:0.85rem;line-height:1.75;max-width:280px;margin-bottom:1.5rem;">
                    A Blood Donor Management System connecting heroes with those in need. Register, search, and save lives every day.
                </p>
                <div class="d-flex gap-2">
                    <a href="https://github.com/NikhilJain25106/BloodDonorManagementSystem" target="_blank" class="footer-social-btn">
                        <i class="fa-brands fa-github"></i>
                    </a>
                    <a href="#" class="footer-social-btn">
                        <i class="fa-brands fa-linkedin-in"></i>
                    </a>
                    <a href="mailto:help@lifedrop.org" class="footer-social-btn">
                        <i class="fa-solid fa-envelope"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Navigation</h6>
                <div class="d-flex flex-column">
                    <a href="index.jsp" class="footer-link"><i class="fa-solid fa-house" style="width:14px;"></i>Home</a>
                    <a href="registerDonor" class="footer-link"><i class="fa-solid fa-user-plus" style="width:14px;"></i>Register</a>
                    <a href="searchDonors" class="footer-link"><i class="fa-solid fa-magnifying-glass" style="width:14px;"></i>Search</a>
                    <a href="contact.jsp" class="footer-link"><i class="fa-solid fa-envelope" style="width:14px;"></i>Contact</a>
                    <a href="privacy.jsp" class="footer-link"><i class="fa-solid fa-shield-halved" style="width:14px;"></i>Privacy</a>
                    <a href="terms.jsp" class="footer-link"><i class="fa-solid fa-file-contract" style="width:14px;"></i>Terms</a>
                    <a href="adminLogin" class="footer-link"><i class="fa-solid fa-user-shield" style="width:14px;"></i>Admin</a>
                </div>
            </div>
            <div class="col-lg-3 col-6">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Blood Groups</h6>
                <div class="d-flex flex-wrap gap-2">
                    <% String[] bgs = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                       for (String bg : bgs) { %>
                        <a href="searchDonors?bloodGroup=<%= bg %>" class="blood-badge" style="font-size:0.72rem;height:28px;min-width:38px;text-decoration:none;""><%= bg %></a>
                    <% } %>
                </div>
            </div>
            <div class="col-lg-3">
                <h6 class="text-white fw-700 mb-3" style="font-size:0.8rem;text-transform:uppercase;letter-spacing:1px;">Emergency Contact</h6>
                <div class="d-flex flex-column gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:34px;height:34px;background:rgba(225,29,72,0.15);border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-phone text-red" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div style="font-size:0.7rem;color:rgba(255,255,255,0.45);font-weight:600;text-transform:uppercase;letter-spacing:0.5px;">Phone</div>
                            <span style="font-size:0.85rem;color:rgba(255,255,255,0.85);font-weight:600;">+91 98765 43210</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:34px;height:34px;background:rgba(225,29,72,0.15);border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-envelope text-red" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div style="font-size:0.7rem;color:rgba(255,255,255,0.45);font-weight:600;text-transform:uppercase;letter-spacing:0.5px;">Email</div>
                            <span style="font-size:0.85rem;color:rgba(255,255,255,0.85);font-weight:600;">help@lifedrop.org</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:34px;height:34px;background:rgba(225,29,72,0.15);border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-location-dot text-red" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div style="font-size:0.7rem;color:rgba(255,255,255,0.45);font-weight:600;text-transform:uppercase;letter-spacing:0.5px;">Location</div>
                            <span style="font-size:0.85rem;color:rgba(255,255,255,0.85);font-weight:600;">Mumbai, Maharashtra</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex flex-wrap justify-content-between align-items-center pt-4 gap-2">
            <p class="mb-0" style="font-size:0.8rem;">&copy; 2026 LifeDrop. Developed by <span class="text-white fw-700">Nikhil Jain</span> &mdash; Java Servlets &middot; JSP &middot; JDBC &middot; MySQL</p>
            <p class="mb-0" style="font-size:0.8rem;">Made with <i class="fa-solid fa-heart text-red"></i> for saving lives</p>
        </div>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/validation.js"></script>
</body>
</html>
