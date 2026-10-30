<%@ include file="includes/header.jsp" %>

<!-- HERO -->
<section style="background:linear-gradient(145deg,#0f172a 0%,#1a3a6e 45%,#7f1d1d 100%);padding:4.5rem 0 4rem 0;position:relative;overflow:hidden;">
    <!-- Decorative blobs -->
    <div style="position:absolute;top:-180px;right:-100px;width:600px;height:600px;background:radial-gradient(circle,rgba(225,29,72,0.15) 0%,transparent 70%);border-radius:50%;pointer-events:none;"></div>
    <div style="position:absolute;bottom:-200px;left:-120px;width:650px;height:650px;background:radial-gradient(circle,rgba(59,130,246,0.08) 0%,transparent 65%);border-radius:50%;pointer-events:none;"></div>
    <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:900px;height:900px;background:radial-gradient(circle,rgba(255,255,255,0.02) 0%,transparent 60%);border-radius:50%;pointer-events:none;"></div>
    
    <div class="container" style="position:relative;z-index:1;">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <!-- Badge -->
                <div style="display:inline-flex;align-items:center;gap:10px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.18);color:rgba(255,255,255,0.9);padding:0.5rem 1.2rem;border-radius:50px;font-size:0.8rem;font-weight:700;margin-bottom:1.75rem;backdrop-filter:blur(12px);letter-spacing:0.5px;">
                    <div class="live-dot"></div>
                    <span style="text-transform:uppercase;letter-spacing:1px;">India Needs 5 Crore Units Annually</span>
                </div>
                
                <h1 style="font-size:clamp(2.4rem,5vw,3.8rem);font-weight:900;color:#fff;line-height:1.1;letter-spacing:-1.5px;margin-bottom:1.25rem;">
                    Donate Blood,<br>
                    <span style="background:linear-gradient(135deg,#fb923c,#f59e0b,#fbbf24);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Save Lives</span><br>
                    Be a Hero
                </h1>
                <p style="font-size:1.02rem;color:rgba(255,255,255,0.8);line-height:1.75;margin-bottom:2rem;max-width:480px;font-weight:400;">
                    LifeDrop connects blood donors with people who need them. Register in minutes, get your personalized Digital Donor ID Card, and download your Certificate of Appreciation.
                </p>
                <div class="d-flex flex-wrap gap-3 mb-4">
                    <a href="<%= cp %>/registerDonor" class="btn-hero-primary">
                        <i class="fa-solid fa-hand-holding-heart"></i> Become a Donor
                    </a>
                    <a href="<%= cp %>/eligibility.jsp" class="btn-hero-secondary" style="border:1.5px solid rgba(255,255,255,0.4);background:rgba(255,255,255,0.06);">
                        <i class="fa-solid fa-calculator"></i> Check Eligibility
                    </a>
                    <a href="<%= cp %>/donorLogin" class="btn-hero-secondary">
                        <i class="fa-solid fa-id-card"></i> My Donor Card
                    </a>
                </div>
                <div class="d-flex flex-wrap gap-4 pt-1">
                    <span style="color:rgba(255,255,255,0.7);font-size:0.82rem;font-weight:600;display:flex;align-items:center;gap:6px;">
                        <i class="fa-solid fa-circle-check" style="color:#22c55e;"></i>Free to Register
                    </span>
                    <span style="color:rgba(255,255,255,0.7);font-size:0.82rem;font-weight:600;display:flex;align-items:center;gap:6px;">
                        <i class="fa-solid fa-lock" style="color:#22c55e;"></i>Data Secure
                    </span>
                    <span style="color:rgba(255,255,255,0.7);font-size:0.82rem;font-weight:600;display:flex;align-items:center;gap:6px;">
                        <i class="fa-solid fa-clock" style="color:#22c55e;"></i>24/7 Access
                    </span>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-droplet" aria-hidden="true"></i>
                            <h3>8</h3>
                            <small>ABO/Rh Blood Types</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini" style="margin-top:1.25rem;">
                            <i class="fa-solid fa-clock" aria-hidden="true"></i>
                            <h3>24/7</h3>
                            <small>Emergency Directory</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini">
                            <i class="fa-solid fa-handshake-angle" aria-hidden="true"></i>
                            <h3>100%</h3>
                            <small>Free &amp; Voluntary</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-mini" style="margin-top:1.25rem;">
                            <i class="fa-solid fa-shield-halved" aria-hidden="true"></i>
                            <h3>DPDP</h3>
                            <small>Privacy Safeguards</small>
                        </div>
                    </div>
                </div>
                <!-- Emergency card -->
                <div style="background:#fff;border-radius:20px;padding:1.35rem 1.5rem;margin-top:1.5rem;box-shadow:0 24px 64px rgba(0,0,0,0.25);display:flex;align-items:center;gap:1rem;">
                    <div style="width:48px;height:48px;background:linear-gradient(135deg,#fff1f2,#ffe4e6);border-radius:14px;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:1.5px solid rgba(225,29,72,0.15);">
                        <i class="fa-solid fa-droplet fa-lg" style="color:#e11d48;" aria-hidden="true"></i>
                    </div>
                    <div style="flex:1;">
                        <div style="font-weight:800;font-size:0.92rem;color:#0f172a;letter-spacing:-0.3px;">Emergency Blood Request</div>
                        <div style="color:#475569;font-size:0.78rem;margin-top:2px;font-weight:600;">Locate voluntary donors in your city</div>
                    </div>
                    <a href="<%= cp %>/searchDonors" class="btn-red" style="flex-shrink:0;font-size:0.8rem;padding:0.5rem 1rem;white-space:nowrap;" aria-label="Search blood donors across India">
                        Search Donors <i class="fa-solid fa-arrow-right ms-1" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- QUICK SEARCH: Clean spacing without negative margin overlap -->
<section class="container py-4 my-2" style="position:relative;z-index:10;">
    <div class="card-custom p-4 p-md-5" style="box-shadow:0 16px 48px rgba(0,0,0,0.08);border-radius:24px;border:1px solid rgba(226,232,240,0.9);background:#ffffff;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-4 pb-2" style="border-bottom:1px solid #f1f5f9;">
            <div class="d-flex align-items-center gap-2">
                <div style="width:36px;height:36px;background:#fef3c7;border-radius:10px;display:flex;align-items:center;justify-content:center;color:#d97706;">
                    <i class="fa-solid fa-bolt" style="font-size:1rem;"></i>
                </div>
                <div>
                    <h5 class="mb-0 fw-800" style="letter-spacing:-0.3px;color:#0f172a;">Quick Donor Search</h5>
                    <small class="text-muted">Search directly across verified registered blood donors</small>
                </div>
            </div>
            <span style="display:inline-flex;align-items:center;gap:6px;background:#f0fdf4;color:#15803d;font-size:0.72rem;font-weight:800;padding:0.3rem 0.8rem;border-radius:20px;border:1px solid rgba(34,197,94,0.25);text-transform:uppercase;letter-spacing:0.8px;">
                <div class="live-dot" style="width:6px;height:6px;"></div>LIVE DIRECTORY
            </span>
        </div>
        <form action="<%= cp %>/searchDonors" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-700" style="font-size:0.85rem;color:#334155;">Blood Group Needed</label>
                    <select name="bloodGroup" class="form-select" style="height:48px;border-radius:12px;">
                        <option value="">Any Blood Group</option>
                        <% for (String g : new String[]{"A+","A-","B+","B-","AB+","AB-","O+","O-"}) { %>
                            <option value="<%= g %>"><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-700" style="font-size:0.85rem;color:#334155;">City / Location</label>
                    <div class="input-group">
                        <span class="input-group-text" style="height:48px;border-radius:12px 0 0 12px;background:#f8fafc;"><i class="fa-solid fa-location-dot text-danger"></i></span>
                        <input type="text" name="city" class="form-control" placeholder="e.g. Mumbai, Delhi, Pune..." style="height:48px;border-radius:0 12px 12px 0;">
                    </div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn-red w-100" style="height:48px;justify-content:center;border-radius:12px;font-size:0.92rem;" aria-label="Search available blood donors in selected city">
                        <i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i> Search Donors
                    </button>
                </div>
            </div>
        </form>
    </div>
</section>

<!-- BLOOD GROUP BROWSER: Ample top breathing space -->
<section class="container py-5 mt-3">
    <div class="text-center mb-5 fade-up">
        <span class="section-label">Browse by Blood Type</span>
        <h2 class="section-heading mt-3">Find Donors by Blood Group</h2>
        <p class="mt-2" style="color:#475569;font-size:0.92rem;font-weight:500;">Click any blood group to locate available donors in your region</p>
    </div>
    <div class="row g-3 justify-content-center">
        <% String[] bgroups = {"A+","A-","B+","B-","AB+","AB-","O+","O-"};
           for (String bg : bgroups) { %>
        <div class="col-6 col-sm-4 col-md-3 col-lg-auto fade-up">
            <a href="<%= cp %>/searchDonors?bloodGroup=<%= bg %>" class="blood-group-card" style="min-width:120px;" aria-label="Find <%= bg %> blood donors">
                <div class="blood-type"><%= bg %></div>
                <div class="find-text"><i class="fa-solid fa-magnifying-glass me-1" aria-hidden="true"></i>Find <%= bg %> Donors</div>
            </a>
        </div>
        <% } %>
    </div>
</section>

<!-- HOW IT WORKS -->
<section style="background:linear-gradient(180deg,#f8fafc,#f1f5f9);padding:6rem 0;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <span class="section-label">Simple Process</span>
            <h2 class="section-heading mt-3">How LifeDrop Works</h2>
            <p class="mt-2" style="color:#475569;font-size:0.95rem;font-weight:500;">Three transparent steps connecting voluntary donors with emergency recipients</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center">
                    <div style="position:absolute;top:1.25rem;right:1.5rem;font-size:4rem;font-weight:900;color:#f1f5f9;line-height:1;z-index:0;letter-spacing:-2px;">01</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-user-plus" aria-hidden="true"></i></div>
                        <h5 class="fw-800 mb-2" style="letter-spacing:-0.3px;">Register as Donor</h5>
                        <p style="color:#475569;margin-bottom:1.5rem;font-size:0.875rem;line-height:1.7;">Provide your clinical blood group, city, and verified contact number. Registration is free and takes under 2 minutes.</p>
                        <a href="<%= cp %>/registerDonor" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.25rem;" aria-label="Register as a voluntary blood donor">Register as Donor <i class="fa-solid fa-arrow-right ms-1" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center">
                    <div style="position:absolute;top:1.25rem;right:1.5rem;font-size:4rem;font-weight:900;color:#fff1f2;line-height:1;z-index:0;letter-spacing:-2px;">02</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-magnifying-glass" aria-hidden="true"></i></div>
                        <h5 class="fw-800 mb-2" style="letter-spacing:-0.3px;">Search Donors</h5>
                        <p style="color:#475569;margin-bottom:1.5rem;font-size:0.875rem;line-height:1.7;">Filter donors by blood group and city. Review donor eligibility status and last donation date instantly without fees.</p>
                        <a href="<%= cp %>/searchDonors" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.25rem;" aria-label="Search blood donor directory">Search Directory <i class="fa-solid fa-arrow-right ms-1" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 fade-up">
                <div class="feature-card text-center">
                    <div style="position:absolute;top:1.25rem;right:1.5rem;font-size:4rem;font-weight:900;color:#f1f5f9;line-height:1;z-index:0;letter-spacing:-2px;">03</div>
                    <div style="position:relative;z-index:1;">
                        <div class="feature-icon-box mx-auto"><i class="fa-solid fa-phone" aria-hidden="true"></i></div>
                        <h5 class="fw-800 mb-2" style="letter-spacing:-0.3px;">Connect & Donate</h5>
                        <p style="color:#475569;margin-bottom:1.5rem;font-size:0.875rem;line-height:1.7;">Coordinate hospital appointments with available donors under licensed medical supervision.</p>
                        <a href="<%= cp %>/contact.jsp" class="btn-red" style="font-size:0.82rem;padding:0.5rem 1.25rem;" aria-label="Contact LifeDrop support team">Contact Support <i class="fa-solid fa-arrow-right ms-1" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- WHY DONATE -->
<section style="padding:6rem 0;background:#fff;">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6 fade-up">
                <span class="section-label">Why Donate?</span>
                <h2 class="section-heading mt-3 mb-4">Your Blood Can Save<br>Up to <span style="color:var(--red);">3 Lives</span></h2>
                <div class="d-flex flex-column gap-3">
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fff1f2;border:1px solid rgba(225,29,72,0.1);">
                        <div style="width:40px;height:40px;background:var(--red);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(225,29,72,0.3);">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-700" style="font-size:0.92rem;color:var(--gray-800);">One donation can save up to 3 lives</div>
                            <div style="color:var(--gray-500);font-size:0.82rem;margin-top:3px;">A single donation is separated into red cells, plasma and platelets</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#f0fdf4;border:1px solid rgba(34,197,94,0.15);">
                        <div style="width:40px;height:40px;background:#22c55e;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(34,197,94,0.3);">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-700" style="font-size:0.92rem;color:var(--gray-800);">Blood cannot be manufactured</div>
                            <div style="color:var(--gray-500);font-size:0.82rem;margin-top:3px;">Only human donors can provide this life-saving resource</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#eff6ff;border:1px solid rgba(59,130,246,0.15);">
                        <div style="width:40px;height:40px;background:#3b82f6;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(59,130,246,0.3);">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-700" style="font-size:0.92rem;color:var(--gray-800);">Someone needs blood every 2 seconds</div>
                            <div style="color:var(--gray-500);font-size:0.82rem;margin-top:3px;">India collects only 2.5 crore units vs the 5 crore needed annually</div>
                        </div>
                    </div>
                    <div class="d-flex gap-3 align-items-start p-3 rounded-3" style="background:#fffbeb;border:1px solid rgba(245,158,11,0.15);">
                        <div style="width:40px;height:40px;background:#f59e0b;border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 4px 12px rgba(245,158,11,0.3);">
                            <i class="fa-solid fa-check text-white" style="font-size:0.85rem;"></i>
                        </div>
                        <div>
                            <div class="fw-700" style="font-size:0.92rem;color:var(--gray-800);">Donating blood is safe and healthy</div>
                            <div style="color:var(--gray-500);font-size:0.82rem;margin-top:3px;">Your body replenishes donated blood within 24&ndash;48 hours</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 fade-up">
                <div style="background:linear-gradient(145deg,#0f172a,#1a3a6e);border-radius:28px;padding:2.75rem;color:#fff;box-shadow:0 24px 60px rgba(15,23,42,0.35);position:relative;overflow:hidden;">
                    <div style="position:absolute;top:-80px;right:-80px;width:250px;height:250px;background:radial-gradient(circle,rgba(225,29,72,0.12) 0%,transparent 70%);border-radius:50%;"></div>
                    <h4 class="fw-800 mb-4 text-white text-center" style="letter-spacing:-0.5px;position:relative;z-index:1;">Eligibility Criteria</h4>
                    <div class="d-flex flex-column gap-3" style="position:relative;z-index:1;">
                        <% String[][] criteria = {
                            {"fa-person-circle-check","Age between <strong>18 and 65 years</strong>"},
                            {"fa-weight-scale","Weight at least <strong>50 kg</strong>"},
                            {"fa-temperature-low","Normal body temperature <strong>(&lt;37.5&deg;C)</strong>"},
                            {"fa-calendar-check","Gap of <strong>3 months</strong> between donations (men)"},
                            {"fa-calendar-check","Gap of <strong>4 months</strong> between donations (women)"},
                            {"fa-virus-slash","No major illness in the <strong>past 6 months</strong>"}
                        }; %>
                        <% for (String[] c : criteria) { %>
                        <div style="display:flex;align-items:center;gap:1rem;padding:0.75rem 1rem;background:rgba(255,255,255,0.07);border-radius:12px;border:1px solid rgba(255,255,255,0.1);">
                            <div style="width:36px;height:36px;background:rgba(34,197,94,0.15);border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                                <i class="fa-solid <%= c[0] %>" style="color:#4ade80;font-size:0.9rem;"></i>
                            </div>
                            <span style="font-size:0.875rem;"><%= c[1] %></span>
                        </div>
                        <% } %>
                    </div>
                    <a href="<%= cp %>/registerDonor" class="btn-hero-primary w-100 mt-4" style="justify-content:center;position:relative;z-index:1;">
                        <i class="fa-solid fa-heart-pulse"></i> I am Eligible &mdash; Register Now
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- COMPATIBILITY TABLE -->
<section style="background:linear-gradient(180deg,#f8fafc,#f1f5f9);padding:6rem 0;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <span class="section-label">Compatibility</span>
            <h2 class="section-heading mt-3">Blood Type Compatibility Chart</h2>
            <p class="mt-2" style="color:var(--gray-500);font-size:0.92rem;font-weight:500;">Know which blood types are compatible for donation and reception</p>
        </div>
        <div class="table-card fade-up">
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
                        <tr><td><span class="blood-badge">A+</span></td><td><small style="color:var(--gray-500);font-weight:500;">A+, AB+</small></td><td><small style="color:var(--gray-500);font-weight:500;">A+, A-, O+, O-</small></td><td><small style="font-weight:600;color:var(--gray-600);">Common type</small></td></tr>
                        <tr><td><span class="blood-badge">A-</span></td><td><small style="color:var(--gray-500);font-weight:500;">A+, A-, AB+, AB-</small></td><td><small style="color:var(--gray-500);font-weight:500;">A-, O-</small></td><td><small style="font-weight:600;color:var(--gray-600);">Universal plasma donor</small></td></tr>
                        <tr><td><span class="blood-badge">B+</span></td><td><small style="color:var(--gray-500);font-weight:500;">B+, AB+</small></td><td><small style="color:var(--gray-500);font-weight:500;">B+, B-, O+, O-</small></td><td><small style="font-weight:600;color:var(--gray-600);">Common in South Asia</small></td></tr>
                        <tr><td><span class="blood-badge">B-</span></td><td><small style="color:var(--gray-500);font-weight:500;">B+, B-, AB+, AB-</small></td><td><small style="color:var(--gray-500);font-weight:500;">B-, O-</small></td><td><small style="font-weight:600;color:var(--gray-600);">Rare &mdash; donate often</small></td></tr>
                        <tr><td><span class="blood-badge">AB+</span></td><td><small style="color:var(--gray-500);font-weight:500;">AB+ only</small></td><td><small style="color:var(--gray-500);font-weight:500;">All blood types</small></td><td><span style="background:#dcfce7;color:#15803d;padding:0.2rem 0.65rem;border-radius:6px;font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.5px;">Universal Recipient</span></td></tr>
                        <tr><td><span class="blood-badge">AB-</span></td><td><small style="color:var(--gray-500);font-weight:500;">AB+, AB-</small></td><td><small style="color:var(--gray-500);font-weight:500;">A-, B-, AB-, O-</small></td><td><small style="font-weight:600;color:var(--gray-600);">Rarest blood type</small></td></tr>
                        <tr><td><span class="blood-badge">O+</span></td><td><small style="color:var(--gray-500);font-weight:500;">A+, B+, AB+, O+</small></td><td><small style="color:var(--gray-500);font-weight:500;">O+, O-</small></td><td><span style="background:#dbeafe;color:#1d4ed8;padding:0.2rem 0.65rem;border-radius:6px;font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.5px;">Most Common</span></td></tr>
                        <tr><td><span class="blood-badge">O-</span></td><td><small style="color:var(--gray-500);font-weight:500;">All blood types</small></td><td><small style="color:var(--gray-500);font-weight:500;">O- only</small></td><td><span style="background:#fff1f2;color:#9f1239;padding:0.2rem 0.65rem;border-radius:6px;font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.5px;">Universal Donor</span></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- FAQ -->
<section style="padding:6rem 0;background:#fff;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <span class="section-label">FAQ</span>
            <h2 class="section-heading mt-3">Common Questions</h2>
            <p class="mt-2" style="color:var(--gray-500);font-size:0.92rem;font-weight:500;">Everything you need to know about blood donation</p>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-8 fade-up">
                <div class="accordion" id="faqAccordion">
                    <% String[][] faqs = {
                        {"faq1","How often can I donate blood?","Men can donate every 3 months (90 days) and women every 4 months (120 days). This gives your body enough time to replenish the donated blood."},
                        {"faq2","Is blood donation safe?","Yes, blood donation is completely safe. Sterile single-use equipment is used every time. The process takes about 8&ndash;10 minutes and your body replenishes the blood within 24&ndash;48 hours."},
                        {"faq3","What should I do before donating blood?","Drink plenty of water, eat a healthy meal, avoid alcohol for 24 hours, and get a good night&apos;s sleep. Wear comfortable clothing with sleeves that roll up easily."},
                        {"faq4","How is my data protected on LifeDrop?","Admin passwords are hashed using BCrypt encryption. Your contact details are only visible to verified admins. The public search only shows your name, blood group, city and last donation date."}
                    }; %>
                    <% for (int i = 0; i < faqs.length; i++) { %>
                    <div class="accordion-item border-0 mb-3 overflow-hidden" style="border-radius:14px;box-shadow:0 2px 12px rgba(0,0,0,0.06);border:1px solid var(--gray-200);">
                        <h2 class="accordion-header">
                            <button class="accordion-button <%= i > 0 ? "collapsed" : "" %> fw-700" type="button" data-bs-toggle="collapse" data-bs-target="#<%= faqs[i][0] %>" style="font-size:0.9rem;border-radius:14px;letter-spacing:-0.2px;color:var(--gray-800);">
                                <i class="fa-solid fa-circle-question me-2" style="color:var(--red);font-size:0.85rem;"></i>
                                <%= faqs[i][1] %>
                            </button>
                        </h2>
                        <div id="<%= faqs[i][0] %>" class="accordion-collapse collapse<%= i == 0 ? " show" : "" %>" data-bs-parent="#faqAccordion">
                            <div class="accordion-body" style="font-size:0.875rem;color:var(--gray-500);line-height:1.75;padding-top:0.5rem;"><%= faqs[i][2] %></div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA BANNER -->
<section class="container pb-5">
    <div style="background:linear-gradient(135deg,#e11d48,#be123c,#9f1239);border-radius:28px;padding:4rem 2.5rem;text-align:center;position:relative;overflow:hidden;">
        <div style="position:absolute;top:-80px;right:-80px;width:280px;height:280px;background:rgba(255,255,255,0.06);border-radius:50%;pointer-events:none;"></div>
        <div style="position:absolute;bottom:-100px;left:-80px;width:320px;height:320px;background:rgba(0,0,0,0.08);border-radius:50%;pointer-events:none;"></div>
        <div style="position:absolute;inset:0;background:radial-gradient(circle at 70% 30%,rgba(251,146,60,0.12) 0%,transparent 60%);"></div>
        <div style="position:relative;z-index:1;">
            <div style="width:72px;height:72px;background:rgba(255,255,255,0.15);border-radius:20px;display:flex;align-items:center;justify-content:center;margin:0 auto 1.5rem;border:1.5px solid rgba(255,255,255,0.25);">
                <i class="fa-solid fa-heart-circle-plus fa-2x text-white"></i>
            </div>
            <h2 class="text-white fw-900 mb-2" style="font-size:clamp(1.75rem,3.5vw,2.5rem);letter-spacing:-1px;">Ready to Save a Life Today?</h2>
            <p style="color:rgba(255,255,255,0.85);font-size:1rem;max-width:520px;margin:0.75rem auto 2.5rem;line-height:1.7;font-weight:500;">Join our growing community of blood donors and make a difference. Registration is free, quick and completely secure.</p>
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
}, { threshold: 0.08 });
document.querySelectorAll(".fade-up").forEach(el => observer.observe(el));
</script>

<%@ include file="includes/footer.jsp" %>