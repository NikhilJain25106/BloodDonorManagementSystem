<%@ include file="includes/header.jsp" %>

<!-- PAGE HERO -->
<section class="page-hero">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center gap-3 mb-2">
            <div class="page-hero-icon">
                <i class="fa-solid fa-envelope"></i>
            </div>
            <div>
                <h1 class="page-hero-title">Contact Us</h1>
                <p class="page-hero-sub">Have a question or need help? We'd love to hear from you</p>
            </div>
        </div>
        <nav class="breadcrumb-custom">
            <a href="<%= cp %>/index.jsp"><i class="fa-solid fa-house me-1"></i>Home</a>
            <span><i class="fa-solid fa-chevron-right" style="font-size:0.65rem;"></i></span>
            <span class="current">Contact</span>
        </nav>
    </div>
</section>

<div class="container py-5">

    <!-- Contact Info Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card app-card p-4 text-center h-100">
                <div style="width:52px;height:52px;background:#fef2f2;border-radius:14px;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;">
                    <i class="fa-solid fa-phone fa-lg" style="color:var(--red);"></i>
                </div>
                <h6 class="fw-700 mb-1" style="color:var(--navy);">Phone</h6>
                <p class="text-muted mb-2" style="font-size:0.85rem;">Available Mon–Sat, 9am–6pm</p>
                <a href="tel:+919876543210" style="font-weight:700;color:var(--red);text-decoration:none;">+91 98765 43210</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card app-card p-4 text-center h-100">
                <div style="width:52px;height:52px;background:#eff6ff;border-radius:14px;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;">
                    <i class="fa-solid fa-envelope fa-lg" style="color:#2563eb;"></i>
                </div>
                <h6 class="fw-700 mb-1" style="color:var(--navy);">Email</h6>
                <p class="text-muted mb-2" style="font-size:0.85rem;">We reply within 24 hours</p>
                <a href="mailto:help@lifedrop.org" style="font-weight:700;color:#2563eb;text-decoration:none;">help@lifedrop.org</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card app-card p-4 text-center h-100">
                <div style="width:52px;height:52px;background:#ecfdf5;border-radius:14px;display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;">
                    <i class="fa-solid fa-location-dot fa-lg" style="color:#059669;"></i>
                </div>
                <h6 class="fw-700 mb-1" style="color:var(--navy);">Location</h6>
                <p class="text-muted mb-2" style="font-size:0.85rem;">Our base of operations</p>
                <span style="font-weight:700;color:#059669;">Mumbai, Maharashtra</span>
            </div>
        </div>
    </div>

    <!-- Contact Form -->
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card app-card p-4 p-md-5">

                <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom:1px solid #f3f4f6;">
                    <div style="width:44px;height:44px;background:var(--red-light);border-radius:12px;display:flex;align-items:center;justify-content:center;color:var(--red);font-size:1.2rem;flex-shrink:0;">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <div>
                        <h5 class="fw-700 mb-0" style="color:var(--navy);">Send Us a Message</h5>
                        <p class="text-muted mb-0" style="font-size:0.82rem;">Fill in the form and we'll get back to you shortly</p>
                    </div>
                </div>

                <div id="contactSuccess" class="alert alert-success d-none">
                    <i class="fa-solid fa-circle-check me-2"></i>Thank you! Your message has been received. We'll reply within 24 hours.
                </div>

                <form id="contactForm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Your Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" id="contactName"
                                    placeholder="e.g. Nikhil Jain" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="email" class="form-control" id="contactEmail"
                                    placeholder="you@example.com" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Subject</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-tag"></i></span>
                                <input type="text" class="form-control" id="contactSubject"
                                    placeholder="How can we help?">
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Message</label>
                            <textarea class="form-control" id="contactMessage" rows="5"
                                placeholder="Write your message here..." required></textarea>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-brand btn-lg px-5" style="font-size:0.95rem;">
                                <i class="fa-solid fa-paper-plane"></i> Send Message
                            </button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>

</div>

<script>
document.getElementById("contactForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const successEl = document.getElementById("contactSuccess");
    successEl.classList.remove("d-none");
    this.reset();
    successEl.scrollIntoView({ behavior: "smooth", block: "center" });
});
</script>

<%@ include file="includes/footer.jsp" %>
