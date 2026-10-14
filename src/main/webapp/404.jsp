<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ include file="includes/header.jsp" %>

<!-- 404 ERROR SECTION -->
<div class="container py-5 my-md-5">
    <div class="row justify-content-center text-center">
        <div class="col-lg-7 col-md-9">
            <div class="card p-5 border-0 shadow-sm" style="border-radius:24px;background:linear-gradient(180deg,#ffffff,#f8fafc);">
                <div class="mx-auto mb-4" style="width:100px;height:100px;background:rgba(225,29,72,0.08);border-radius:50%;display:flex;align-items:center;justify-content:center;">
                    <i class="fa-solid fa-droplet-slash text-red" style="font-size:3rem;"></i>
                </div>
                <div class="badge bg-danger-subtle text-danger px-3 py-2 rounded-pill fw-700 mx-auto mb-3" style="font-size:0.85rem;letter-spacing:1px;width:fit-content;">
                    ERROR 404 &middot; PAGE NOT FOUND
                </div>
                <h1 class="fw-800 text-dark mb-3" style="font-size:2.4rem;letter-spacing:-0.5px;">
                    We couldn't find that page
                </h1>
                <p class="text-muted mb-4" style="font-size:1.05rem;line-height:1.7;">
                    The link you followed may be broken, expired, or the page may have been moved. 
                    Don't worry, every drop of blood counts and our search tools are ready to help.
                </p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="<%= cp %>/index.jsp" class="btn btn-primary px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-house me-2"></i>Return Home
                    </a>
                    <a href="<%= cp %>/searchDonors" class="btn btn-outline-danger px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-magnifying-glass me-2"></i>Find Blood Donors
                    </a>
                    <a href="<%= cp %>/contact.jsp" class="btn btn-outline-secondary px-4 py-2" style="border-radius:12px;font-weight:600;">
                        <i class="fa-solid fa-headset me-2"></i>Need Help?
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
