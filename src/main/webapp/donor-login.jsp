<%@ include file="includes/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">

            <!-- Card -->
            <div class="card app-card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 48px rgba(0,0,0,0.08);">
                
                <div class="text-center mb-4">
                    <div style="width:60px;height:60px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:18px;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;box-shadow:0 8px 24px rgba(225,29,72,0.3);">
                        <i class="fa-solid fa-id-card text-white fa-xl"></i>
                    </div>
                    <h3 class="fw-800 mb-1" style="color:var(--navy);letter-spacing:-0.5px;">Donor Login</h3>
                    <p class="text-muted small mb-0">Access your personalized Donor ID Card & Certificate</p>
                </div>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger mb-4" style="border-radius:12px;font-size:0.88rem;">
                        <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <form action="<%= cp %>/donorLogin" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-700" style="font-size:0.85rem;color:var(--gray-700);">Registered Mobile or Email <span style="color:var(--red);">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text" style="background:#f8fafc;border-radius:12px 0 0 12px;">
                                <i class="fa-solid fa-user-check text-muted"></i>
                            </span>
                            <input type="text" name="identifier" class="form-control"
                                placeholder="e.g. 9876543210 or name@example.com"
                                value="<%= request.getAttribute("enteredIdentifier") != null ? request.getAttribute("enteredIdentifier") : "" %>"
                                style="border-radius:0 12px 12px 0;height:48px;" required autofocus>
                        </div>
                        <div class="form-text" style="font-size:0.75rem;color:var(--gray-500);margin-top:0.4rem;">
                            <i class="fa-solid fa-shield-halved me-1 text-success"></i>Instant verification using your registered credentials
                        </div>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 btn-lg" style="height:48px;border-radius:12px;font-size:0.95rem;justify-content:center;">
                        <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Login to Donor Portal
                    </button>
                </form>

                <div class="mt-4 pt-3 text-center" style="border-top:1px solid #f1f5f9;">
                    <p class="mb-2 small text-muted">New hero in town?</p>
                    <a href="<%= cp %>/registerDonor" class="btn btn-outline-secondary w-100" style="border-radius:12px;font-weight:600;font-size:0.88rem;padding:0.6rem;">
                        <i class="fa-solid fa-user-plus me-1 text-red"></i>Register as a New Donor
                    </a>
                </div>

                <div class="text-center mt-3">
                    <a href="<%= cp %>/adminLogin" class="text-muted small text-decoration-none">
                        <i class="fa-solid fa-lock me-1"></i>Administrator Login &rarr;
                    </a>
                </div>

            </div>

        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
