<%@ include file="includes/header.jsp" %>

<!-- HERO -->
<section style="background:linear-gradient(135deg,#1e3a5f 0%,#dc2626 100%);min-height:88vh;display:flex;align-items:center;padding:4rem 0;position:relative;overflow:hidden;">
    <div style="position:absolute;top:-100px;right:-100px;width:500px;height:500px;background:rgba(255,255,255,0.03);border-radius:50%;"></div>
    <div style="position:absolute;bottom:-150px;left:-100px;width:600px;height:600px;background:rgba(255,255,255,0.03);border-radius:50%;"></div>
    <div class="container" style="position:relative;z-index:1;">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <div style="display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,0.12);border:1px solid rgba(255,255,255,0.2);color:#fff;padding:0.4rem 1rem;border-radius:50px;font-size:0.82rem;font-weight:500;margin-bottom:1.5rem;">
                    <i class="fa-solid fa-heart-pulse"></i> India Needs 5 Crore Units Annually — Be a Hero
                </div>
                <h1 style="font-size:clamp(2.2rem,5vw,3.6rem);font-weight:800;color:#fff;line-height:1.15;letter-spacing:-1px;margin-bottom:1.2rem;">
                    Donate Blood,<br>
                    <span style="background:linear-gradient(90deg,#fbbf24,#f59e0b);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Save Lives</span><br>
                    Be a Hero
                </h1>
                <p style="font-size:1.05rem;color:rgba(255,255,255,0.8);line-height:1.75;margin-bottom:2rem;max-width:500px;">
                    LifeDrop connects blood donors with people who need them. Register in minutes, search by blood group and city, and help save a life today.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="<%= cp %>/registerDonor" class="btn-primary-custom">
                        <i class="fa-solid fa-hand-holding-heart"></i> Become a Donor
                    </a>
                    <a href="<%= cp %>/searchDonors" class="btn-secondary-custom">
                        <i class="fa-solid fa-magnifying-glass"></i> Find a Donor
                    </a>
                </div>
                <div class="d-flex gap-4 mt-4">
                    <div style="color:rgba(255,255,255,0.7);font-size:0.85rem;"><i class="fa-solid fa-shield-check me-1" style="color:#4ade80;"></i>Free to Register</div>
                    <div style="color:rgba(255,255,255,0.7);font-size:0.85rem;"><i class="fa-solid fa-lock me-1" style="color:#4ade80;"></i>Data Secure</div>
                    <div style="color:rgba(255,255,255,0.7);font-size:0.85rem;"><i class="fa-solid fa-clock me-1" style="color:#4ade80;"></i>24/7 Access</div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6"><div class="stat-mini"><i class="fa-solid fa-users fa-2x"></i><h3>500+</h3><small>Registered Donors</small></div></div>
                    <div class="col-6"><div class="stat-mini"><i class="fa-solid fa-droplet fa-2x"></i><h3>8</h3><small>Blood Types Covered</small></div></div>
                    <div class="col-6"><div class="stat-mini"><i class="fa-solid fa-heart fa-2x"></i><h3>1000+</h3><small>Lives Saved</small></div></div>
                    <div class="col-6"><div class="stat-mini"><i class="fa-solid fa-hospital fa-2x"></i><h3>50+</h3><small>Partner Hospitals</small></div></div>
                </div>
                <div style="background:#fff;border-radius:16px;padding:1.25rem;margin-top:1rem;box-shadow:0 20px 60px rgba(0,0,0,0.25);display:flex;align-items:center;gap:1rem;">
                    <div style="background:#fef2f2;border-radius:12px;padding:0.85rem;flex-shrink:0;">
                        <i class="fa-solid fa-droplet fa-2x" style="color:#dc2626;"></i>
                    </div>
                    <div style="flex:1;">
                        <div style="font-weight:700;font-size:0.9rem;color:#1f2937;">Emergency Blood Request</div>
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
<section class="container" style="margin-top:-30px;position:relative;z-index:10;">
    <div class="card-custom p-4" style="box-shadow:0 8px 40px rgba(0,0,0,0.12);">
        <div class="d-flex align-items-center gap-2 mb-3">
            <i class="fa-solid fa-bolt" style="color:#f59e0b;"></i>
            <h5 class="mb-0 fw-700">Quick Donor Search</h5>
            <span class="ms-2" style="background:#fef2f2;color:#dc2626;font-size:0.72rem;font-weight:700;padding:0.2rem 0.6rem;border-radius:20px;">LIVE</span>
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
                    <button type="submit" class="btn-red w-100" style="justify-content:center;padding:0.68rem;">
                        <i class="fa-solid fa-magnifying-glass"></i> Search Now
                    </button>
                </div>
            </div>
        </form>
    </div>
</section>

<!-- BLOOD GROUP QUICK LINKS -->
<section class="container py-5">
    <div class="text-center mb-4">
        <span class="section-label">Browse by Blood Type</span>
        <h2 class="section-heading mt-2">Find Donors by Blood Group</h2>
    </div>
    <div class="row g-3 justify-content-center">
        <% String[] bgroups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
           String[] colors = {"#dc2626","#b91c1c","#dc2626","#b91c1c","#dc2626","#b91c1c","#dc2626","#b91c1c"};
           for (int i=0; i<bgroups.length; i++) { %>
        <div class="col-6 col-sm-3 col-md-3 col-lg-auto">
            <a href="<%= cp %>/searchDonors?bloodGroup=<%= bgroups[i] %>" class="card-custom d-block text-center p-3 text-decoration-none" style="min-width:110px;">
                <div style="font-size:2rem;font-weight:800;color:<%= colors[i] %>;line-height:1.2;"><%= bgroups[i] %></div>
                <div style="font-size:0.75rem;color:#6b7280;margin-top:4px;">Find Donors</div>
            </a>
        </div>
        <% } %>
    </div>
</section>

<!-- HOW IT WORKS -->
<section style="background:#f3f4f6;padding:5rem 0;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label">Simple Process</span>
            <h2 class="section-heading mt-2">How LifeDrop Works</h2>
            <p class="text-muted mt-2">Three easy steps that can save a life</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card-custom p-4 h-100 position-relative" style="overflow:hidden;">
                    <div style="position:absolute;top:1rem;right:1.5rem;font-size:3rem;font-weight:800;color:#f3f4f6;line-height:1;z-index:0;">01</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mb-3"><i class="fa-solid fa-user-plus"></i></div>
                        <h5 class="fw-700 mb-2">Register as Donor</h5>
                        <p class="text-muted mb-3" style="font-size:0.88rem;line-height:1.65;">Fill in your name, blood group, phone, email, address and city. Registration takes under 2 minutes.</p>
                        <a href="<%= cp %>/registerDonor" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.1rem;">Register Now <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-custom p-4 h-100 position-relative" style="overflow:hidden;border-color:rgba(220,38,38,0.2);">
                    <div style="position:absolute;top:1rem;right:1.5rem;font-size:3rem;font-weight:800;color:#fef2f2;line-height:1;z-index:0;">02</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mb-3"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <h5 class="fw-700 mb-2">Search Donors</h5>
                        <p class="text-muted mb-3" style="font-size:0.88rem;line-height:1.65;">Filter donors by blood group and city. See name, age, gender, city and last donation date instantly.</p>
                        <a href="<%= cp %>/searchDonors" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.1rem;">Search Now <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-custom p-4 h-100 position-relative" style="overflow:hidden;">
                    <div style="position:absolute;top:1rem;right:1.5rem;font-size:3rem;font-weight:800;color:#f3f4f6;line-height:1;z-index:0;">03</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mb-3"><i class="fa-solid fa-phone"></i></div>
                        <h5 class="fw-700 mb-2">Connect & Donate</h5>
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
            <div class="col-lg-6">
                <span class="section-label">Why Donate?</span>
                <h2 class="section-heading mt-2 mb-4">Your Blood Can Save<br>Up to 3 Lives</h2>
                <div class="d-flex flex-column gap-3">
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fef2f2;">
                        <div style="width:36px;height:36px;background:#dc2626;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">One donation can save up to 3 lives</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">A single donation is separated into red cells, plasma and platelets</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#f0fdf4;">
                        <div style="width:36px;height:36px;background:#16a34a;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Blood cannot be manufactured</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">Only human donors can provide this life-saving resource</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#eff6ff;">
                        <div style="width:36px;height:36px;background:#2563eb;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Someone needs blood every 2 seconds</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">India collects only 2.5 crore units vs the 5 crore needed annually</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fefce8;">
                        <div style="width:36px;height:36px;background:#d97706;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="fa-solid fa-check text-white" style="font-size:0.8rem;"></i>
                        </div>
                        <div>
                            <div class="fw-600" style="font-size:0.92rem;">Donating blood is safe and healthy</div>
                            <div class="text-muted" style="font-size:0.82rem;margin-top:2px;">Your body replenishes donated blood within 24-48 hours</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div style="background:linear-gradient(135deg,#1e3a5f,#2d5986);border-radius:24px;padding:2.5rem;color:#fff;">
                    <h4 class="fw-700 mb-4 text-white text-center">Eligibility Criteria</h4>
                    <div class="d-flex flex-column gap-3">
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-person-circle-check fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">Age between <strong>18 and 65 years</strong></span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-weight-scale fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">Weight at least <strong>50 kg</strong></span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-temperature-low fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">Normal body temperature <strong>(&lt;37.5°C)</strong></span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-calendar-check fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">Gap of <strong>3 months</strong> between donations (men)</span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-calendar-check fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">Gap of <strong>4 months</strong> between donations (women)</span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fa-solid fa-virus-slash fa-lg" style="color:#4ade80;width:24px;"></i>
                            <span style="font-size:0.9rem;">No major illness in the <strong>past 6 months</strong></span>
                        </div>
                    </div>
                    <a href="<%= cp %>/registerDonor" class="btn-primary-custom w-100 mt-4" style="justify-content:center;">
                        <i class="fa-solid fa-heart-pulse"></i> I'm Eligible — Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- BLOOD COMPATIBILITY TABLE -->
<section style="background:#f9fafb;padding:5rem 0;">
    <div class="container">
        <div class="text-center mb-4">
            <span class="section-label">Compatibility</span>
            <h2 class="section-heading mt-2">Blood Type Compatibility Chart</h2>
            <p class="text-muted mt-2">Know which blood types are compatible for donation and reception</p>
        </div>
        <div class="card-custom overflow-hidden">
            <div class="table-responsive">
                <table class="table mb-0 table-custom">
                    <thead>
                        <tr>
                            <th>Blood Type</th>
                            <th>Can Donate To</th>
                            <th>Can Receive From</th>
                            <th>Special Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="blood-badge">A+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A+, AB+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A+, A-, O+, O-</span></td>
                            <td><span style="font-size:0.8rem;">Common type</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">A-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A+, A-, AB+, AB-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A-, O-</span></td>
                            <td><span style="font-size:0.8rem;">Universal plasma donor</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">B+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">B+, AB+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">B+, B-, O+, O-</span></td>
                            <td><span style="font-size:0.8rem;">Common in South Asia</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">B-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">B+, B-, AB+, AB-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">B-, O-</span></td>
                            <td><span style="font-size:0.8rem;">Rare — donate often</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">AB+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">AB+ only</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">All blood types</span></td>
                            <td><span style="background:#d1fae5;color:#065f46;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:600;">Universal Recipient</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">AB-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">AB+, AB-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A-, B-, AB-, O-</span></td>
                            <td><span style="font-size:0.8rem;">Rarest blood type</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">O+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">A+, B+, AB+, O+</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">O+, O-</span></td>
                            <td><span style="background:#dbeafe;color:#1e40af;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:600;">Most Common</span></td>
                        </tr>
                        <tr>
                            <td><span class="blood-badge">O-</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">All blood types</span></td>
                            <td><span class="text-muted" style="font-size:0.85rem;">O- only</span></td>
                            <td><span style="background:#fef2f2;color:#991b1b;padding:0.2rem 0.5rem;border-radius:6px;font-size:0.75rem;font-weight:600;">Universal Donor</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- FAQ -->
<section style="padding:5rem 0;background:#fff;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label">FAQ</span>
            <h2 class="section-heading mt-2">Common Questions</h2>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="accordion" id="faqAccordion">
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 10px rgba(0,0,0,0.06);">
                        <h2 class="accordion-header">
                            <button class="accordion-button fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq1" style="font-size:0.92rem;">
                                How often can I donate blood?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Men can donate every 3 months (90 days) and women every 4 months (120 days). This gives your body enough time to replenish the donated blood.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 10px rgba(0,0,0,0.06);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq2" style="font-size:0.92rem;">
                                Is blood donation safe?
                            </button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Yes, blood donation is completely safe. Sterile, single-use equipment is used for every donation. The process takes about 8-10 minutes and your body replenishes the donated blood within 24-48 hours.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 rounded-3 overflow-hidden" style="box-shadow:0 2px 10px rgba(0,0,0,0.06);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq3" style="font-size:0.92rem;">
                                What should I do before donating blood?
                            </button>
                        </h2>
                        <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">Drink plenty of water, eat a healthy meal, avoid alcohol for 24 hours, and get a good night's sleep. Wear comfortable clothing with sleeves that can be rolled up easily.</div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 rounded-3 overflow-hidden" style="box-shadow:0 2px 10px rgba(0,0,0,0.06);">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-600" type="button" data-bs-toggle="collapse" data-bs-target="#faq4" style="font-size:0.92rem;">
                                How is my data protected on LifeDrop?
                            </button>
                        </h2>
                        <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted" style="font-size:0.88rem;">All admin passwords are hashed using BCrypt encryption. Your contact details are only visible to verified admins — the public search only shows your name, blood group, city and last donation date, never your phone or email directly.</div>
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
        <div style="position:absolute;top:-60px;right:-60px;width:220px;height:220px;background:rgba(255,255,255,0.05);border-radius:50%;"></div>
        <div style="position:absolute;bottom:-80px;left:-60px;width:280px;height:280px;background:rgba(255,255,255,0.05);border-radius:50%;"></div>
        <div style="position:relative;z-index:1;">
            <i class="fa-solid fa-heart-circle-plus fa-3x text-white mb-3" style="opacity:0.9;"></i>
            <h2 class="text-white fw-800 mb-2" style="font-size:clamp(1.5rem,3vw,2.2rem);">Ready to Save a Life Today?</h2>
            <p style="color:rgba(255,255,255,0.85);font-size:1rem;max-width:500px;margin:0.5rem auto 2rem;">Join our growing community of blood donors and make a difference. Registration is free, quick and secure.</p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="<%= cp %>/registerDonor" class="btn-primary-custom">
                    <i class="fa-solid fa-user-plus"></i> Register as Donor
                </a>
                <a href="<%= cp %>/searchDonors" class="btn-secondary-custom">
                    <i class="fa-solid fa-search"></i> Find Donors Now
                </a>
            </div>
        </div>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>
