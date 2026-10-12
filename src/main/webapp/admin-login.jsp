<%@ include file="includes/header.jsp" %>

<style>
/* Override app-main height so the split fills the screen */
.app-main { min-height: 0; }
</style>

<div class="login-page-wrap">

    <!-- LEFT BRAND PANEL -->
    <div class="login-brand-panel" style="position:relative;z-index:1;">
        <div style="position:relative;z-index:2;text-align:center;max-width:360px;">
            <!-- Logo -->
            <div style="width:72px;height:72px;background:rgba(255,255,255,0.15);border:2px solid rgba(255,255,255,0.3);border-radius:20px;display:flex;align-items:center;justify-content:center;margin:0 auto 1.5rem;">
                <i class="fa-solid fa-droplet fa-2x text-white"></i>
            </div>
            <h2 style="font-weight:800;font-size:2rem;letter-spacing:-0.5px;margin-bottom:0.3rem;">Life<span style="color:#fca5a5;">Drop</span></h2>
            <p style="color:rgba(255,255,255,0.7);font-size:0.9rem;margin-bottom:2.5rem;">Blood Donor Management System</p>

            <!-- Features list -->
            <div class="d-flex flex-column gap-3 text-start">
                <div class="d-flex align-items-center gap-3">
                    <div style="width:36px;height:36px;background:rgba(255,255,255,0.12);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="fa-solid fa-users" style="color:#86efac;font-size:0.85rem;"></i>
                    </div>
                    <span style="font-size:0.88rem;color:rgba(255,255,255,0.85);">View & manage all registered donors</span>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <div style="width:36px;height:36px;background:rgba(255,255,255,0.12);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="fa-solid fa-pen-to-square" style="color:#93c5fd;font-size:0.85rem;"></i>
                    </div>
                    <span style="font-size:0.88rem;color:rgba(255,255,255,0.85);">Edit or remove donor records instantly</span>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <div style="width:36px;height:36px;background:rgba(255,255,255,0.12);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="fa-solid fa-shield-halved" style="color:#fcd34d;font-size:0.85rem;"></i>
                    </div>
                    <span style="font-size:0.88rem;color:rgba(255,255,255,0.85);">BCrypt-secured admin access only</span>
                </div>
            </div>

            <div style="margin-top:3rem;padding:1rem 1.25rem;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);border-radius:12px;">
                <p style="font-size:0.78rem;color:rgba(255,255,255,0.55);margin:0;">Restricted area &mdash; authorised personnel only. All login attempts are monitored.</p>
            </div>
        </div>
    </div>

    <!-- RIGHT FORM PANEL -->
    <div class="login-form-panel">
        <div style="width:100%;max-width:400px;">

            <!-- Mobile logo (hidden on desktop) -->
            <div class="d-lg-none text-center mb-4">
                <div style="width:52px;height:52px;background:linear-gradient(135deg,#dc2626,#b91c1c);border-radius:14px;display:flex;align-items:center;justify-content:center;margin:0 auto 0.75rem;">
                    <i class="fa-solid fa-droplet text-white fa-lg"></i>
                </div>
                <h4 style="font-weight:800;color:var(--navy);">Life<span style="color:var(--red);">Drop</span></h4>
            </div>

            <h3 class="fw-800 mb-1" style="color:var(--navy);">Admin Login</h3>
            <p class="text-muted mb-4" style="font-size:0.88rem;">Enter your credentials to access the dashboard</p>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger mb-4">
                    <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/adminLogin" method="post">

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                        <input type="text" name="username" class="form-control"
                            placeholder="Enter your username" required autofocus>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <div class="password-wrapper" style="flex:1;position:relative;">
                            <input type="password" name="password" id="adminPassword"
                                class="form-control" style="border-radius:0 10px 10px 0;"
                                placeholder="Enter your password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword()">
                                <i class="fa-solid fa-eye" id="pwdIcon"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-brand w-100 btn-lg" style="justify-content:center;">
                    <i class="fa-solid fa-right-to-bracket"></i> Sign In
                </button>

            </form>

            <div class="text-center mt-4">
                <a href="<%= request.getContextPath() %>/index.jsp" class="text-muted" style="font-size:0.85rem;text-decoration:none;">
                    <i class="fa-solid fa-arrow-left me-1"></i>Back to Home
                </a>
            </div>

        </div>
    </div>

</div>

<script>
function togglePassword() {
    const pwd = document.getElementById('adminPassword');
    const icon = document.getElementById('pwdIcon');
    if (pwd.type === 'password') {
        pwd.type = 'text';
        icon.className = 'fa-solid fa-eye-slash';
    } else {
        pwd.type = 'password';
        icon.className = 'fa-solid fa-eye';
    }
}
</script>

<%@ include file="includes/footer.jsp" %>
