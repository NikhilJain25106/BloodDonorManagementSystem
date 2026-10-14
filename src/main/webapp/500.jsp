<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ include file="includes/header.jsp" %>

<!-- 500 SERVER ERROR SECTION -->
<div class="container py-5 my-md-5">
    <div class="row justify-content-center text-center">
        <div class="col-lg-7 col-md-9">
            <div class="card p-5 border-0 shadow-sm" style="border-radius:24px;background:linear-gradient(180deg,#ffffff,#f8fafc);">
                <div class="mx-auto mb-4" style="width:100px;height:100px;background:rgba(239,68,68,0.1);border-radius:50%;display:flex;align-items:center;justify-content:center;">
                    <i class="fa-solid fa-triangle-exclamation text-danger" style="font-size:3rem;"></i>
                </div>
                <div class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-700 mx-auto mb-3" style="font-size:0.85rem;letter-spacing:1px;width:fit-content;">
                    ERROR 500 &middot; SERVER ISSUE
                </div>
                <h1 class="fw-800 text-dark mb-3" style="font-size:2.4rem;letter-spacing:-0.5px;">
                    Something went wrong
                </h1>
                <p class="text-muted mb-4" style="font-size:1.05rem;line-height:1.7;">
                    Our servers ran into an unexpected hiccup while processing your request. 
                    Our medical system administrators have been notified. Please try refreshing or return to the main dashboard.
                </p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <button onclick="window.location.reload();" class="btn btn-primary px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-arrow-rotate-right me-2"></i>Try Again
                    </button>
                    <a href="<%= cp %>/index.jsp" class="btn btn-outline-secondary px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-house me-2"></i>Go to Homepage
                    </a>
                    <a href="<%= cp %>/contact.jsp" class="btn btn-outline-danger px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-life-ring me-2"></i>Emergency Support
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
