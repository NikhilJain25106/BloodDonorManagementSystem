<%@ include file="includes/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card app-card p-4">
                <div class="text-center mb-4">
                    <i class="fa-solid fa-user-shield fa-3x text-danger mb-3"></i>
                    <h3 class="fw-bold">Admin Login</h3>
                    <p class="text-muted">Restricted area. Authorised personnel only.</p>
                </div>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">
                        <i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/adminLogin" method="post">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" name="username" class="form-control" placeholder="Enter username" required autofocus>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-brand w-100 btn-lg">
                        <i class="fa-solid fa-right-to-bracket me-2"></i>Login
                    </button>
                </form>

                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="text-muted small">
                        <i class="fa-solid fa-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
