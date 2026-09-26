</main>

<footer class="app-footer">
    <div class="container">
        <div class="row g-4 pb-4" style="border-bottom:1px solid rgba(255,255,255,0.1);">
            <div class="col-lg-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div style="width:36px;height:36px;background:linear-gradient(135deg,#dc2626,#b91c1c);border-radius:10px;display:flex;align-items:center;justify-content:center;">
                        <i class="fa-solid fa-droplet text-white" style="font-size:0.9rem;"></i>
                    </div>
                    <span class="text-white fw-800" style="font-size:1.1rem;">Life<span style="color:#fca5a5;">Drop</span></span>
                </div>
                <p style="font-size:0.85rem;line-height:1.7;max-width:280px;">A Blood Donor Management System connecting donors with those in need. Built as a college mini-project.</p>
                <div class="d-flex gap-3 mt-3">
                    <i class="fa-brands fa-github footer-link fa-lg" style="cursor:pointer;"></i>
                    <i class="fa-solid fa-envelope footer-link fa-lg" style="cursor:pointer;"></i>
                </div>
            </div>
            <div class="col-lg-2 col-6">
                <h6 class="text-white fw-700 mb-3">Navigation</h6>
                <div class="d-flex flex-column gap-2">
                    <a href="index.jsp" class="footer-link">Home</a>
                    <a href="registerDonor" class="footer-link">Register</a>
                    <a href="searchDonors" class="footer-link">Search</a>
                    <a href="contact.jsp" class="footer-link">Contact</a>
                </div>
            </div>
            <div class="col-lg-3 col-6">
                <h6 class="text-white fw-700 mb-3">Blood Groups</h6>
                <div class="d-flex flex-wrap gap-2">
                    <% String[] bgs = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
                       for (String bg : bgs) { %>
                        <a href="searchDonors?bloodGroup=<%= bg %>" class="blood-badge" style="font-size:0.75rem;height:28px;min-width:40px;text-decoration:none;"><%= bg %></a>
                    <% } %>
                </div>
            </div>
            <div class="col-lg-3">
                <h6 class="text-white fw-700 mb-3">Emergency Contact</h6>
                <div class="d-flex flex-column gap-2">
                    <div class="d-flex align-items-center gap-2">
                        <i class="fa-solid fa-phone text-red"></i>
                        <span style="font-size:0.85rem;">+91 98765 43210</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="fa-solid fa-envelope text-red"></i>
                        <span style="font-size:0.85rem;">help@lifedrop.org</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="fa-solid fa-location-dot text-red"></i>
                        <span style="font-size:0.85rem;">Mumbai, Maharashtra</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-flex flex-wrap justify-content-between align-items-center pt-3 gap-2">
            <p class="mb-0" style="font-size:0.8rem;">&copy; 2026 LifeDrop. Developed by <span class="text-white fw-600">Nikhil Jain</span> | Java Servlets &middot; JSP &middot; JDBC &middot; MySQL</p>
            <p class="mb-0" style="font-size:0.8rem;">Made with <i class="fa-solid fa-heart text-red"></i> for saving lives</p>
        </div>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/validation.js"></script>
</body>
</html>
