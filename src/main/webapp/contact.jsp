<%@ include file="includes/header.jsp" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-envelope text-danger me-2"></i>Contact Us</h2>
            <p class="text-muted mb-4">Have a question or need help? Reach out to us below.</p>

            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="card app-card p-4 text-center h-100">
                        <i class="fa-solid fa-phone fa-2x text-danger mb-3"></i>
                        <h6 class="fw-bold">Phone</h6>
                        <p class="text-muted mb-0">+91 98765 43210</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card app-card p-4 text-center h-100">
                        <i class="fa-solid fa-envelope fa-2x text-danger mb-3"></i>
                        <h6 class="fw-bold">Email</h6>
                        <p class="text-muted mb-0">help@lifedrop.org</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card app-card p-4 text-center h-100">
                        <i class="fa-solid fa-location-dot fa-2x text-danger mb-3"></i>
                        <h6 class="fw-bold">Location</h6>
                        <p class="text-muted mb-0">Mumbai, Maharashtra</p>
                    </div>
                </div>
            </div>

            <div class="card app-card p-4">
                <h5 class="fw-bold mb-4">Send us a Message</h5>
                <div id="contactSuccess" class="alert alert-success d-none">
                    <i class="fa-solid fa-circle-check me-2"></i>Thank you! Your message has been received.
                </div>
                <form id="contactForm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="contactName" placeholder="Nikhil Jain" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="contactEmail" placeholder="you@example.com" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Subject</label>
                            <input type="text" class="form-control" id="contactSubject" placeholder="How can we help?">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Message</label>
                            <textarea class="form-control" id="contactMessage" rows="5" placeholder="Write your message here..." required></textarea>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-brand btn-lg px-5">
                                <i class="fa-solid fa-paper-plane me-2"></i>Send Message
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
    document.getElementById("contactSuccess").classList.remove("d-none");
    this.reset();
    window.scrollTo(0, 0);
});
</script>

<%@ include file="includes/footer.jsp" %>
