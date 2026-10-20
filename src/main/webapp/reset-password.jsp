<%@ include file="includes/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">

            <div class="card app-card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 48px rgba(0,0,0,0.08);">

                <div class="text-center mb-4">
                    <div style="width:60px;height:60px;background:linear-gradient(135deg,#e11d48,#be123c);border-radius:18px;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;box-shadow:0 8px 24px rgba(225,29,72,0.3);">
                        <i class="fa-solid fa-key text-white fa-xl"></i>
                    </div>
                    <h3 class="fw-800 mb-1" style="color:var(--navy);letter-spacing:-0.5px;">Reset Password</h3>
                    <p class="text-muted small mb-0">Enter your registered email address to receive recovery instructions</p>
                </div>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger mb-4" style="border-radius:12px;font-size:0.88rem;">
                        <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("infoMessage") != null) { %>
                    <div class="alert alert-success mb-4" style="border-radius:12px;font-size:0.88rem;">
                        <i class="fa-solid fa-circle-check me-2"></i><%= request.getAttribute("infoMessage") %>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/resetPassword" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-700" style="font-size:0.85rem;color:var(--gray-700);">Email Address <span style="color:var(--red);">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text" style="background:#f8fafc;border-radius:12px 0 0 12px;">
                                <i class="fa-solid fa-envelope text-muted"></i>
                            </span>
                            <input type="email" name="email" class="form-control"
                                placeholder="name@example.com"
                                style="border-radius:0 12px 12px 0;height:48px;" required autofocus>
                        </div>
                        <div class="form-text" style="font-size:0.75rem;color:var(--gray-500);margin-top:0.4rem;">
                            <i class="fa-solid fa-shield-halved me-1 text-success"></i>Generic confirmation prevents email discovery attacks
                        </div>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 btn-lg" style="height:48px;border-radius:12px;font-size:0.95rem;justify-content:center;">
                        <i class="fa-solid fa-paper-plane me-2"></i>Send Reset Link
                    </button>
                </form>

                <div class="mt-4 pt-3 text-center" style="border-top:1px solid #f1f5f9;">
                    <a href="<%= request.getContextPath() %>/adminLogin" class="text-muted small text-decoration-none me-3">
                        <i class="fa-solid fa-arrow-left me-1"></i>Back to Admin Login
                    </a>
                    <a href="<%= request.getContextPath() %>/donorLogin" class="text-muted small text-decoration-none">
                        Donor Login &rarr;
                    </a>
                </div>

            </div>

        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
