<%@ include file="includes/header.jsp" %>

<!-- HERO -->
<section style="background:linear-gradient(135deg,#1e3a5f 0%,#dc2626 100%);min-height:88vh;display:flex;align-items:center;padding:4rem 0;position:relative;overflow:hidden;">
    <div style="position:absolute;top:-120px;right:-120px;width:500px;height:500px;background:rgba(255,255,255,0.04);border-radius:50%;pointer-events:none;"></div>
    <div style="position:absolute;bottom:-150px;left:-100px;width:600px;height:600px;background:rgba(255,255,255,0.03);border-radius:50%;pointer-events:none;"></div>
    <div class="container" style="position:relative;z-index:1;">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <div style="display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,0.15);border:1px solid rgba(255,255,255,0.25);color:#fff;padding:0.45rem 1.1rem;border-radius:50px;font-size:0.82rem;font-weight:500;margin-bottom:1.5rem;">
                    <i class="fa-solid fa-heart-pulse"></i> India Needs 5 Crore Units Annually &mdash; Be a Hero
                </div>
                <h1 style="font-size:clamp(2.3rem,5vw,3.8rem);font-weight:800;color:#fff;line-height:1.12;letter-spacing:-1px;margin-bottom:1.25rem;">
                    Donate Blood,<br>
                    <span style="background:linear-gradient(90deg,#fbbf24,#f59e0b);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Save Lives</span><br>
                    Be a Hero
                </h1>
                <p style="font-size:1.05rem;color:rgba(255,255,255,0.85);line-height:1.75;margin-bottom:2.25rem;max-width:500px;">
                    LifeDrop connects blood donors with people who need them. Register in minutes, search by blood group and city, and help save a life today.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="<%= cp %>/registerDonor" class="btn-hero-primary">
                        <i class="fa-solid fa-hand-holding-heart"></i> Become a Donor
                    </a>
                    <a href="<%= cp %>/searchDonors" class="btn-hero-secondary">
                        <i class="fa-solid fa-magnifying-glass"></i> Find a Donor
                    </a>
                </div>
                <div class="d-flex gap-4 mt-4">
                    <span style="color:rgba(255,255,255,0.75);font-size:0.83rem;"><i class="fa-solid fa-shield-check me-1" style="color:#4ade80;"></i>Free to Register</span>
                    <span style="color:rgba(255,255,255,0.75);font-size:0.83rem;"><i class="fa-solid fa-lock me-1" style="color:#4ade80;"></i>Data Secure</span>
                    <span style="color:rgba(255,255,255,0.75);font-size:0.83rem;"><i class="fa-solid fa-clock me-1" style="color:#4ade80;"></i>24/7 Access</span>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-users"></i>
                            <h3>500+</h3>
                            <small>Registered Donors</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-droplet"></i>
                            <h3>8</h3>
                            <small>Blood Types Covered</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-heart"></i>
                            <h3>1000+</h3>
                            <small>Lives Saved</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-hospital"></i>
                            <h3>50+</h3>
                            <small>Partner Hospitals</small>
                        </div>
                    </div>
                </div>
                <div style="background:#fff;border-radius:16px;padding:1.25rem 1.5rem;margin-top:1rem;box-shadow:0 20px 60px rgba(0,0,0,0.2);display:flex;align-items:center;gap:1rem;">
                    <div style="background:#fef2f2;border-radius:12px;padding:0.85rem;flex-shrink:0;">
                        <i class="fa-solid fa-droplet fa-2x" style="color:#dc2626;"></i>
                    </div>
                    <div style="flex:1;">
                        <div style="font-weight:700;font-size:0.92rem;color:#1f2937;">Emergency Blood Request</div>
                        <div style="color:#6b7280;font-size:0.8rem;margin-top:2px;">Find donors in your city instantly</div>
                    </div>
                    <a href="<%= cp %>/searchDonors" class="btn-red" style="flex-shrink:0;font-size:0.82rem;padding:0.5rem 1rem;">
                        Search <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- QUICK SEARCH -->
<section class="container" style="margin-top:-32px;position:relative;z-index:10;">
    <div class="card-custom p-4" style="box-shadow:0 10px 40px rgba(0,0,0,0.13);">
        <div class="d-flex align-items-center gap-2 mb-3">
            <i class="fa-solid fa-bolt" style="color:#f59e0b;font-size:1.1rem;"></i>
            <h5 class="mb-0 fw-700">Quick Donor Search</h5>
            <span style="background:#fef2f2;color:#dc2626;font-size:0.7rem;font-weight:700;padding:0.2rem 0.6rem;border-radius:20px;border:1px solid rgba(220,38,38,0.2);">LIVE</span>
        </div>
        <form action="<%= cp %>/searchDonors" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Blood Group Needed</label>
                    <select name="bloodGroup" class="form-select">
                        <option value="">Any Blood Group</option>
                        <% for (String g : new String[]{"A+","A-","B+","B-","AB+","AB-","O+","O-"}) { %>
                            <option value="<%= g %>"><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">City</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                        <input type="text" name="city" class="form-control" style="border-radius:0 10px 10px 0;" placeholder="e.g. Mumbai, Delhi, Pune...">
                    </div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn-red w-100" style="justify-content:center;padding:0.7rem;">
                        <i class="fa-solid fa-magnifying-glass"></i> Search Now
                    </button>
                </div>
            </div>
        </form>
    </div>
</section>

<!-- BLOOD GROUP BROWSER -->
<section class="container py-5">
    <div class="text-center mb-4">
        <span class="section-label">Browse by Blood Type</span>
        <h2 class="section-heading mt-2">Find Donors by Blood Group</h2>
        <p class="text-muted mt-2" style="font-size:0.92rem;">Click any blood group to instantly find available donors</p>
    </div>
    <div class="row g-3 justify-content-center">
        <% String[] bgroups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
           for (String bg : bgroups) { %>
        <div class="col-6 col-sm-4 col-md-3 col-lg-auto">
            <a href="<%= cp %>/searchDonors?bloodGroup=<%= bg %>" class="blood-group-card">
                <div class="blood-type"><%= bg %></div>
                <div class="find-text"><i class="fa-solid fa-magnifying-glass me-1"></i>Find Donors</div>
            </a>
        </div>
        <% } %>
    </div>
</section>

<!-- HOW IT WORKS -->
<section style="background:#f3f4f6;padding:5rem 0;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <span class="section-label">Simple Process</span>
            <h2 class="section-heading mt-2">How LifeDrop Works</h2>
            <p class="text-muted mt-2">Three easy steps that can save a life</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center">
                    <div style="position:absolute;top:1.2rem;right:1.5rem;font-size:3.5rem;font-weight:900;color:#f3f4f6;line-height:1;z-index:0;">01</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-user-plus"></i></div>
                        <h5 class="fw-700 mb-2">Register as Donor</h5>
                        <p class="text-muted mb-3" style="font-size:0.88rem;line-height:1.65;">Fill in your name, blood group, phone, email, address and city. Registration takes under 2 minutes.</p>
                        <a href="<%= cp %>/registerDonor" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.1rem;">Register Now <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center" style="border-color:rgba(220,38,38,0.15);">
                    <div style="position:absolute;top:1.2rem;right:1.5rem;font-size:3.5rem;font-weight:900;color:#fef2f2;line-height:1;z-index:0;">02</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <h5 class="fw-700 mb-2">Search Donors</h5>
                        <p class="text-muted mb-3" style="font-size:0.88rem;line-height:1.65;">Filter donors by blood group and city. See name, age, gender and last donation date instantly.</p>
                        <a href="<%= cp %>/searchDonors" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.1rem;">Search Now <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center">
                    <div style="position:absolute;top:1.2rem;right:1.5rem;font-size:3.5rem;font-weight:900;color:#f3f4f6;line-height:1;z-index:0;">03</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-phone"></i></div>
                        <h5 class="fw-700 mb-2">Connect and Donate</h5>
                        <p class="text-muted mb-3" style="font-size:0.88rem;line-height:1.65;">Contact the donor or reach out through our platform. Coordinate and complete the life-saving donation.</p>
                        <a href="<%= cp %>/contact.jsp" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.1rem;">Contact Us <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- WHY DONATE -->
<section style="padding:5rem 0;background:#fff;">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6 fade-up">
                <span class="section-label">Why Donate?</span>
                <h2 class="section-heading mt-2 mb-4">Your Blood Can Save<br>Up to 3 Lives</h2>
                <div class="d-flex flex-column gap-3">
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fef2f2;">
                        <div style="width:38px;height:38px;background:var(--red);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">One donation can save up to 3 lives</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">A single donation is separated into red cells, plasma and platelets</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#f0fdf4;">
                        <div style="width:38px;height:38px;background:#16a34a;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Blood cannot be manufactured</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">Only human donors can provide this life-saving resource</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#eff6ff;">
                        <div style="width:38px;height:38px;background:#2563eb;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Someone needs blood every 2 seconds</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">India collects only 2.5 crore units vs the 5 crore needed annually</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fefce8;">
                        <div style="width:38px;height:38px;background:#d97706;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Donating blood is safe and healthy</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">Your body replenishes donated blood within 24-48 hours</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 fade-up">
                <div style="background:linear-gradient(135deg,#1e3a5f,#2d5986);border-radius:24px;padding:2.5rem;color:#fff;">
                    <h4 class="fw-700 mb-4 text-white text-center">Eligibility Criteria</h4>
                    <div class="d-flex flex-column gap-3">
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-person-circle-check fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">Age between <strong>18 and 65 years</strong></span></div>
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-weight-scale fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">Weight at least <strong>50 kg</strong></span></div>
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-temperature-low fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">Normal body temperature <strong>(&lt;37.5&deg;C)</strong></span></div>
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-calendar-check fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">Gap of <strong>3 months</strong> between donations (men)</span></div>
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-calendar-check fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">Gap of <strong>4 months</strong> between donations (women)</span></div>
                        <div class="d-flex align-items-center gap-3"><i class="fa-solid fa-virus-slash fa-lg" style="color:#4ade80;width:22px;flex-shrink:0;"></i><span style="font-size:0.9rem;">No major illness in the <strong>past 6 months</strong></span></div>
                    </div>
                    <a href="<%= cp %>/registerDonor" class="btn-hero-primary w-100 mt-4" style="justify-content:center;">
                        <i class="fa-solid fa-heart-pulse"></i> I am Eligible &mdash; Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- COMPATIBILITY TABLE -->
<section style="background:#f9fafb;padding:5rem 0;">
    <div class="container">
        <div class="text-center mb-4 fade-up">
            <span class="section-label">Compatibility</span>
            <h2 class="section-heading mt-2">Blood Type Compatibility Chart</h2>
            <p class="text-muted mt-2" style="font-size:0.92rem;">Know which blood types are compatible for donation and reception</p>
        </div>
        <div class="card-custom overflow-hidden fade-up">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Blood Type</th>
                            <th>Can Donate To</th>
                            <th>Can Receive From</th>
                            <th>Special Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td><span class="blood-badge">A+</span></td><td><small class="text-muted">A+, AB+</small></td><td><small class="text-muted">A+, A-, O+, O-</small></td><td><small>Common type</small></td></tr>
                        <tr><td><span class="blood-badge">A-</span></td><td><small class="text-muted">A+, A-, AB+, AB-</small></td><td><small class="text-muted">A-, O-</small></td><td><small>Universal plasma donor</small></td></tr>
                        <tr><td><span class="blood-badge">B+</span></td><td><small class="text-muted">B+, AB+</small></td><td><small class="text-muted">B+, B-, O+, O-</small></td><td><small>Common in South Asia</small></td></tr>
                        <tr><td><span class="blood-badge">B-</span></td><td><small class="text-muted">B+, B-, AB+, AB-</small></td><td><small class="text-muted">B-, O-</small></td><td><small>Rare &mdash; donate often</small></td></tr>
                        <tr><td><span class="blood-badge">AB+</span></td><td><small class="text-muted">AB+ only</small></td><td><small class="text-muted">All blood types</small></td><td><span style="background:#d1fae5;color:#065f46;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:700;">Universal Recipient</span></td></tr>
                        <tr><td><span class="blood-badge">AB-</span></td><td><small class="text-muted">AB+, AB-</small></td><td><small class="text-muted">A-, B-, AB-, O-</small></td><td><small>Rarest blood type</small></td></tr>
                        <tr><td><span class="blood-badge">O+</span></td><td><small class="text-muted">A+, B+, AB+, O+</small></td><td><small class="text-muted">O+, O-</small></td><td><span style="background:#dbeafe;color:#1e40af;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:700;">Most Common</span></td></tr>
                        <tr><td><span class="blood-badge">O-</span></td><td><small class="text-muted">All blood types</small></td><td><small class="text-muted">O- only</small></td><td><span style="background:#fef2f2;color:#991b1b;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:700;">Universal Donor</span></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- FAQ -->
<section style="padding:5rem 0;background:#fff;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <span class="section-label">FAQ</span>
            <h2 class="section-heading mt-2">Common Questions</h2>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-8 fade-up">
                <div class="accordion" id="faqAccordion">
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 12px rgba(0,0,0,0.07);">
                        <h2 class="accordion-header">
                            <button class="accordion-button fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq1" style="font-size:0.92rem;">How often can I donate blood?</button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Men can donate every 3 months (90 days) and women every 4 months (120 days). This gives your body enough time to replenish the donated blood.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 12px rgba(0,0,0,0.07);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq2" style="font-size:0.92rem;">Is blood donation safe?</button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Yes, blood donation is completely safe. Sterile single-use equipment is used every time. The process takes about 8-10 minutes and your body replenishes the blood within 24-48 hours.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 12px rgba(0,0,0,0.07);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq3" style="font-size:0.92rem;">What should I do before donating blood?</button>
                        </h2>
                        <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Drink plenty of water, eat a healthy meal, avoid alcohol for 24 hours, and get a good night sleep. Wear comfortable clothing with sleeves that roll up easily.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 rounded-3 overflow-hidden" style="box-shadow:0 2px 12px rgba(0,0,0,0.07);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq4" style="font-size:0.92rem;">How is my data protected on LifeDrop?</button>
                        </h2>
                        <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Admin passwords are hashed using BCrypt encryption. Your contact details are only visible to verified admins. The public search only shows your name, blood group, city and last donation date.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA BANNER -->
<section class="container pb-5">
    <div style="background:linear-gradient(135deg,#dc2626,#b91c1c);border-radius:24px;padding:3.5rem 2rem;text-align:center;position:relative;overflow:hidden;">
        <div style="position:absolute;top:-60px;right:-60px;width:220px;height:220px;background:rgba(255,255,255,0.06);border-radius:50%;pointer-events:none;"></div>
        <div style="position:absolute;bottom:-80px;left:-60px;width:280px;height:280px;background:rgba(255,255,255,0.05);border-radius:50%;pointer-events:none;"></div>
        <div style="position:relative;z-index:1;">
            <i class="fa-solid fa-heart-circle-plus fa-3x text-white mb-3" style="opacity:0.92;"></i>
            <h2 class="text-white fw-800 mb-2" style="font-size:clamp(1.6rem,3vw,2.3rem);">Ready to Save a Life Today?</h2>
            <p style="color:rgba(255,255,255,0.88);font-size:1rem;max-width:500px;margin:0.5rem auto 2rem;">Join our growing community of blood donors and make a difference. Registration is free, quick and secure.</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="<%= cp %>/registerDonor" class="btn-hero-primary">
                    <i class="fa-solid fa-user-plus"></i> Register as Donor
                </a>
                <a href="<%= cp %>/searchDonors" class="btn-hero-secondary">
                    <i class="fa-solid fa-search"></i> Find Donors Now
                </a>
            </div>
        </div>
    </div>
</section>

<script>
const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) e.target.classList.add("visible"); });
}, { threshold: 0.1 });
document.querySelectorAll(".fade-up").forEach(el => observer.observe(el));
</script>

<%@ include file="includes/footer.jsp" %>