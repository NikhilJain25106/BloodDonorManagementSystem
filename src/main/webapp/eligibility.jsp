<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero" style="background:linear-gradient(135deg,#0f172a 0%,#7f1d1d 100%);">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon" style="background:rgba(225,29,72,0.2);color:#fb7185;">
                <i class="fa-solid fa-calculator"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Donor Eligibility & Next Date Calculator</h1>
                <p class="page-hero-sub">Clinical interval guidelines, body weight check & real-time readiness</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Eligibility Calculator</span>
        </nav>
    </div>
</section>

<div class="container py-5">
    <div class="row g-4 justify-content-center">
        <!-- Calculator Form Column -->
        <div class="col-lg-7">
            <div class="card app-card p-4 p-md-5">
                <div class="d-flex align-items-center gap-2 mb-4 pb-2" style="border-bottom:1px solid #f1f5f9;">
                    <i class="fa-solid fa-heart-pulse text-danger fs-5"></i>
                    <h5 class="fw-bold mb-0 text-navy">Check Your Donation Readiness</h5>
                </div>

                <form id="calcForm" onsubmit="event.preventDefault(); calculateEligibility();">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Your Age (Years)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="number" id="calcAge" class="form-control" min="10" max="100" placeholder="e.g. 24" required>
                            </div>
                            <small class="text-muted">Must be between 18 and 65 years</small>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Body Weight (kg)</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-weight-scale"></i></span>
                                <input type="number" id="calcWeight" class="form-control" min="30" max="200" placeholder="e.g. 62" required>
                            </div>
                            <small class="text-muted">Minimum 50 kg for whole blood</small>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Gender</label>
                            <select id="calcGender" class="form-select" required>
                                <option value="Male">Male (90 days interval)</option>
                                <option value="Female">Female (120 days interval)</option>
                                <option value="Other">Other (90 days interval)</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Blood Group</label>
                            <select id="calcBlood" class="form-select">
                                <option value="O+">O+</option>
                                <option value="O-">O- (Universal Donor)</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+ (Universal Recipient)</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold">Last Donation Date <span class="text-muted fw-normal">(Leave blank if first-time donor)</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-calendar-days"></i></span>
                                <input type="date" id="calcDate" class="form-control">
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-brand w-100 py-2 fs-6">
                                <i class="fa-solid fa-calculator me-1"></i> Check Eligibility Now
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Calculation Result Banner (Dynamic) -->
                <div id="calcResult" class="mt-4 p-4 rounded-3 d-none"></div>
            </div>
        </div>

        <!-- Clinical Guidelines & Rules Sidebar -->
        <div class="col-lg-5">
            <div class="card app-card p-4 mb-4">
                <h6 class="fw-bold mb-3 d-flex align-items-center gap-2 text-navy">
                    <i class="fa-solid fa-circle-info text-primary"></i> Clinical Eligibility Criteria
                </h6>
                <ul class="list-unstyled d-flex flex-column gap-3 mb-0" style="font-size:0.88rem;">
                    <li class="d-flex gap-2">
                        <i class="fa-solid fa-check text-success mt-1"></i>
                        <span><strong>Age:</strong> Between 18 to 65 years.</span>
                    </li>
                    <li class="d-flex gap-2">
                        <i class="fa-solid fa-check text-success mt-1"></i>
                        <span><strong>Weight:</strong> Minimum 50 kg (110 lbs).</span>
                    </li>
                    <li class="d-flex gap-2">
                        <i class="fa-solid fa-check text-success mt-1"></i>
                        <span><strong>Hemoglobin:</strong> &ge; 12.5 g/dL.</span>
                    </li>
                    <li class="d-flex gap-2">
                        <i class="fa-solid fa-check text-success mt-1"></i>
                        <span><strong>Male Interval:</strong> At least 90 days (3 months) since last whole blood donation.</span>
                    </li>
                    <li class="d-flex gap-2">
                        <i class="fa-solid fa-check text-success mt-1"></i>
                        <span><strong>Female Interval:</strong> At least 120 days (4 months) since last whole blood donation.</span>
                    </li>
                </ul>
            </div>

            <div class="card app-card p-4 text-center bg-light">
                <i class="fa-solid fa-id-card fa-2x text-brand mb-2"></i>
                <h6 class="fw-bold text-navy">Ready to Save Lives?</h6>
                <p class="text-muted small mb-3">Register your profile to get a personalized Digital Donor ID Card instantly.</p>
                <a href="<%= cp %>/registerDonor" class="btn btn-outline-danger btn-sm w-100">
                    <i class="fa-solid fa-user-plus me-1"></i> Register as Donor
                </a>
            </div>
        </div>
    </div>
</div>

<script>
function calculateEligibility() {
    const age = parseInt(document.getElementById('calcAge').value);
    const weight = parseFloat(document.getElementById('calcWeight').value);
    const gender = document.getElementById('calcGender').value;
    const blood = document.getElementById('calcBlood').value;
    const lastDateVal = document.getElementById('calcDate').value;
    const resultBox = document.getElementById('calcResult');

    resultBox.classList.remove('d-none', 'alert-success', 'alert-danger', 'alert-warning');

    let errors = [];
    if (isNaN(age) || age < 18) {
        errors.push("Age is below 18 years (minimum clinical age).");
    } else if (age > 65) {
        errors.push("Age exceeds 65 years (maximum statutory donor threshold).");
    }

    if (isNaN(weight) || weight < 50) {
        errors.push("Body weight is below 50 kg (clinical whole blood volume threshold).");
    }

    const intervalDays = (gender === "Female") ? 120 : 90;
    let daysRemaining = 0;
    let eligibleDateStr = "";

    if (lastDateVal) {
        const lastDate = new Date(lastDateVal);
        const nextEligible = new Date(lastDate);
        nextEligible.setDate(nextEligible.getDate() + intervalDays);

        const today = new Date();
        const diffTime = nextEligible - today;
        daysRemaining = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        eligibleDateStr = nextEligible.toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });

        if (daysRemaining > 0) {
            errors.push("Minimum interval period not reached. You will be eligible on <strong>" + eligibleDateStr + "</strong> (" + daysRemaining + " days remaining).");
        }
    }

    if (errors.length === 0) {
        resultBox.className = "mt-4 p-4 rounded-3 alert alert-success border border-success";
        resultBox.innerHTML = `
            <div class="d-flex align-items-center gap-3 mb-2">
                <i class="fa-solid fa-circle-check fa-2x text-success"></i>
                <div>
                    <h5 class="fw-bold mb-0 text-success">You Are Fully Eligible to Donate Blood!</h5>
                    <small class="text-muted">Blood Group: <strong>` + blood + `</strong> &bull; Gender: ` + gender + `</small>
                </div>
            </div>
            <p class="mb-3 small text-dark">You satisfy all statutory clinical standards (Age &ge; 18, Weight &ge; 50kg, and mandatory interval spacing).</p>
            <a href="<%= cp %>/registerDonor?bloodGroup=` + encodeURIComponent(blood) + `" class="btn btn-success btn-sm">
                <i class="fa-solid fa-hand-holding-heart me-1"></i> Register as Active Donor
            </a>
        `;
    } else {
        resultBox.className = "mt-4 p-4 rounded-3 alert alert-danger border border-danger";
        let listHtml = errors.map(err => `<li>` + err + `</li>`).join("");
        resultBox.innerHTML = `
            <div class="d-flex align-items-center gap-3 mb-2">
                <i class="fa-solid fa-triangle-exclamation fa-2x text-danger"></i>
                <div>
                    <h5 class="fw-bold mb-0 text-danger">Currently Ineligible to Donate</h5>
                    <small class="text-muted">Please review the clinical requirements below</small>
                </div>
            </div>
            <ul class="mb-2 ps-3 small text-dark">` + listHtml + `</ul>
            <small class="text-muted">Wait for the prescribed recovery interval before registering for whole blood donation.</small>
        `;
    }
}
</script>

<%@ include file="includes/footer.jsp" %>

