<%@ include file="includes/header.jsp" %>

<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <h1 class="display-5 mb-3">Every Drop Counts. Be Someone's Lifeline.</h1>
                <p class="lead mb-4">LifeDrop connects blood donors with people who need them, quickly and reliably. Register as a donor in minutes, or search our donor network when every second matters.</p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="${pageContext.request.contextPath}/registerDonor" class="btn btn-light btn-lg fw-semibold">
                        <i class="fa-solid fa-hand-holding-heart me-2"></i>Become a Donor
                    </a>
                    <a href="${pageContext.request.contextPath}/searchDonors" class="btn btn-outline-light btn-lg fw-semibold">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>Find a Donor
                    </a>
                </div>
            </div>
            <div class="col-lg-5 mt-4 mt-lg-0">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="hero-stat-card text-center">
                            <i class="fa-solid fa-droplet fa-2x mb-2"></i>
                            <h3 class="mb-0">8</h3>
                            <small>Blood Groups Tracked</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="hero-stat-card text-center">
                            <i class="fa-solid fa-users fa-2x mb-2"></i>
                            <h3 class="mb-0">Open</h3>
                            <small>Donor Network</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="hero-stat-card text-center">
                            <i class="fa-solid fa-shield-heart fa-2x mb-2"></i>
                            <h3 class="mb-0">Secure</h3>
                            <small>Data Handling</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="hero-stat-card text-center">
                            <i class="fa-solid fa-clock fa-2x mb-2"></i>
                            <h3 class="mb-0">24/7</h3>
                            <small>Access</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="container py-5">
    <h2 class="text-center mb-5 fw-bold">How It Works</h2>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card app-card h-100 p-4 text-center">
                <div class="mb-3"><i class="fa-solid fa-user-plus fa-3x" style="color: var(--brand-red);"></i></div>
                <h5>1. Register</h5>
                <p class="text-muted">Fill out a short form with your details and blood group. Takes less than two minutes.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card app-card h-100 p-4 text-center">
                <div class="mb-3"><i class="fa-solid fa-magnifying-glass fa-3x" style="color: var(--brand-red);"></i></div>
                <h5>2. Search</h5>
                <p class="text-muted">Anyone in need can search by blood group and city to find nearby registered donors.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card app-card h-100 p-4 text-center">
                <div class="mb-3"><i class="fa-solid fa-hand-holding-heart fa-3x" style="color: var(--brand-red);"></i></div>
                <h5>3. Connect</h5>
                <p class="text-muted">Reach out through the details provided and help save a life.</p>
            </div>
        </div>
    </div>
</section>

<section class="container-fluid py-5" style="background-color: var(--brand-red-light);">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h2 class="fw-bold mb-3">Why Your Donation Matters</h2>
                <ul class="list-unstyled fs-5">
                    <li class="mb-2"><i class="fa-solid fa-check text-danger me-2"></i>One donation can save up to three lives.</li>
                    <li class="mb-2"><i class="fa-solid fa-check text-danger me-2"></i>Blood cannot be manufactured - it only comes from donors.</li>
                    <li class="mb-2"><i class="fa-solid fa-check text-danger me-2"></i>Someone needs blood every two seconds.</li>
                </ul>
            </div>
            <div class="col-lg-6 text-center mt-4 mt-lg-0">
                <i class="fa-solid fa-heart-pulse" style="font-size: 10rem; color: var(--brand-red);"></i>
            </div>
        </div>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>
