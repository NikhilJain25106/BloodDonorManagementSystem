<%@ include file="includes/header.jsp" %>
<%@ page import="java.util.List, com.blooddonor.model.EmergencyRequest" %>

<!-- PAGE HERO -->
<section class="page-hero" style="background:linear-gradient(135deg,#881337 0%,#e11d48 100%);">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="page-hero-icon" style="background:rgba(255,255,255,0.2);color:#fff;">
                    <i class="fa-solid fa-tower-broadcast fa-fade"></i>
                </div>
                <div>
                    <h1 class="page-hero-title">🚨 SOS Emergency Blood Broadcast</h1>
                    <p class="page-hero-sub">Live beacon connecting ICU patients & emergency transfusions with immediate donors</p>
                </div>
            </div>
            <button class="btn btn-light fw-bold px-4 py-2 shadow" data-bs-toggle="modal" data-bs-target="#broadcastModal">
                <i class="fa-solid fa-bullhorn text-danger me-1"></i> Post Emergency Request
            </button>
        </div>
    </div>
</section>

<div class="container py-5">
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show mb-4 shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>
            <%= request.getAttribute("errorMessage") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if ("success".equals(request.getParameter("broadcast"))) { %>
        <div class="alert alert-success alert-dismissible fade show mb-4 shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>
            <strong>Emergency Broadcast Activated!</strong> Your urgent request is now broadcasting to voluntary donors across the platform.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="row g-4">
        <!-- Live Request Stream -->
        <div class="col-lg-8">
            <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                <h5 class="fw-bold mb-0 text-navy d-flex align-items-center gap-2">
                    <span class="live-dot"></span> Active Emergency Beacons
                </h5>
                <small class="text-muted">Updated in real-time</small>
            </div>

            <%
                List<EmergencyRequest> list = (List<EmergencyRequest>) request.getAttribute("activeRequests");
                if (list != null && !list.isEmpty()) {
                    for (EmergencyRequest reqItem : list) {
                String contactPhone = reqItem.getContactPhone() != null ? reqItem.getContactPhone() : "";
                String cleanPhone = contactPhone.replaceAll("[^0-9]", "");
                String contactPerson = reqItem.getContactPerson() != null ? reqItem.getContactPerson() : "Contact";
                String bloodGroup = reqItem.getBloodGroup() != null ? reqItem.getBloodGroup() : "";
            %>
            <div class="card app-card p-4 mb-3 border-start border-4 border-danger shadow-sm">
                <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
                    <div class="d-flex align-items-center gap-3">
                        <span class="blood-badge" style="font-size:1.3rem;width:55px;height:55px;">
                            <%= bloodGroup %>
                        </span>
                        <div>
                            <h5 class="fw-bold mb-0 text-navy"><%= reqItem.getPatientName() != null ? reqItem.getPatientName() : "Emergency Patient" %></h5>
                            <small class="text-muted"><i class="fa-solid fa-hospital me-1 text-danger"></i><%= reqItem.getHospitalName() %>, <strong><%= reqItem.getCity() %></strong></small>
                        </div>
                    </div>
                    <span class="badge bg-danger text-uppercase px-3 py-2" style="letter-spacing:0.5px;">
                        <%= reqItem.getUrgency() %> &bull; <%= reqItem.getUnitsNeeded() %> Unit(s)
                    </span>
                </div>

                <div class="bg-light p-3 rounded-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <div style="font-size:0.88rem;">
                        <span class="text-muted">Contact:</span> <strong><%= contactPerson %></strong>
                        (<a href="tel:<%= contactPhone %>" class="text-decoration-none fw-bold"><%= contactPhone %></a>)
                    </div>
                    <div class="d-flex gap-2">
                        <a href="tel:<%= contactPhone %>" class="btn btn-sm btn-outline-danger px-3">
                            <i class="fa-solid fa-phone me-1"></i> Call Hospital
                        </a>
                        <a href="https://wa.me/91<%= cleanPhone %>?text=Hello%20<%= java.net.URLEncoder.encode(contactPerson, "UTF-8") %>,%20I%20saw%20your%20emergency%20request%20for%20<%= java.net.URLEncoder.encode(bloodGroup, "UTF-8") %>%20on%20LifeDrop%20and%20I%20am%20ready%20to%20help."
                           target="_blank" rel="noopener noreferrer"
                           class="btn btn-sm btn-success px-3" style="background:#25D366;border-color:#25D366;">
                            <i class="fa-brands fa-whatsapp me-1"></i> WhatsApp
                        </a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="text-center py-5 bg-white rounded-3 border">
                <i class="fa-solid fa-heart-circle-check fa-3x text-success mb-3"></i>
                <h5 class="fw-bold text-navy">No Critical Emergencies Open</h5>
                <p class="text-muted small">All active hospital broadcasts have been addressed. Thank you to our donors!</p>
            </div>
            <% } %>
        </div>

        <!-- Guidelines / Fast Broadcast info -->
        <div class="col-lg-4">
            <div class="card app-card p-4 mb-4">
                <h6 class="fw-bold mb-3 text-navy"><i class="fa-solid fa-triangle-exclamation text-warning me-2"></i>Emergency Protocols</h6>
                <p class="text-muted small mb-3">Emergency requests are prioritized and broadcasted directly to verified voluntary donors within the same municipality.</p>
                <button class="btn btn-brand w-100 py-2" data-bs-toggle="modal" data-bs-target="#broadcastModal">
                    <i class="fa-solid fa-plus me-1"></i> Broadcast Request
                </button>
            </div>

            <div class="card app-card p-4 text-center bg-light">
                <i class="fa-solid fa-map-location-dot fa-2x text-primary mb-2"></i>
                <h6 class="fw-bold text-navy">Interactive Donor Map</h6>
                <p class="text-muted small mb-3">Locate verified blood banks and donor clusters near your hospital.</p>
                <a href="<%= request.getContextPath() %>/map.jsp" class="btn btn-outline-primary btn-sm w-100">
                    <i class="fa-solid fa-earth-asia me-1"></i> Open Proximity Map
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Post Emergency Request -->
<div class="modal fade" id="broadcastModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-bullhorn me-2"></i>Post Emergency Request</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%= request.getContextPath() %>/emergency" method="post">
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-7">
                            <label class="form-label fw-bold">Patient Legal Name</label>
                            <input type="text" name="patientName" class="form-control" required placeholder="e.g. Rahul Verma">
                        </div>
                        <div class="col-md-5">
                            <label class="form-label fw-bold">Blood Group</label>
                            <select name="bloodGroup" class="form-select" required>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Units Needed</label>
                            <input type="number" name="unitsNeeded" class="form-control" min="1" max="10" value="1" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Urgency</label>
                            <select name="urgency" class="form-select">
                                <option value="Critical (Within 2 hrs)">Critical (Within 2 hrs)</option>
                                <option value="High (Within 6 hrs)">High (Within 6 hrs)</option>
                                <option value="Moderate (Today)">Moderate (Today)</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Hospital Name & Branch</label>
                            <input type="text" name="hospitalName" class="form-control" required placeholder="e.g. Lilavati Hospital, Bandra">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">City</label>
                            <input type="text" name="city" class="form-control" required placeholder="e.g. Mumbai">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Contact Person</label>
                            <input type="text" name="contactPerson" class="form-control" required placeholder="e.g. Dr. Sharma / Kin">
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">10-Digit Emergency Phone</label>
                            <input type="tel" name="contactPhone" class="form-control" required pattern="[6-9][0-9]{9}" placeholder="e.g. 9876543210">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger px-4 fw-bold">
                        <i class="fa-solid fa-paper-plane me-1"></i> Broadcast Live Now
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>

