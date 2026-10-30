<%@ include file="includes/header.jsp" %>
<%@ page import="java.sql.*, com.blooddonor.util.DBConnection" %>

<!-- Leaflet.js CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>

<!-- PAGE HERO -->
<section class="page-hero" style="background:linear-gradient(135deg,#0f172a 0%,#1e3a5f 100%);">
    <div class="container" style="position:relative;z-index:1;">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="page-hero-icon" style="background:rgba(59,130,246,0.2);color:#60a5fa;">
                    <i class="fa-solid fa-map-location-dot"></i>
                </div>
                <div>
                    <h1 class="page-hero-title">📍 Interactive Donor & Blood Bank Locator</h1>
                    <p class="page-hero-sub">Locate nearby donors, verified blood banks & radius coverage in real-time</p>
                </div>
            </div>
            <button class="btn btn-primary fw-bold px-4 py-2" onclick="locateMe()">
                <i class="fa-solid fa-crosshairs me-1"></i> Detect My Location
            </button>
        </div>
    </div>
</section>

<div class="container py-4">
    <div class="card app-card p-3 mb-4">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-2">
            <div class="d-flex align-items-center gap-3">
                <span class="badge bg-danger p-2"><i class="fa-solid fa-droplet me-1"></i>Donors & Clusters</span>
                <span class="badge bg-primary p-2"><i class="fa-solid fa-hospital me-1"></i>Blood Banks / Hospitals</span>
            </div>
            <small class="text-muted" id="locStatus">Click on any marker to view contact and donor details.</small>
        </div>
        <!-- Map Container -->
        <div id="donorMap" style="height: 520px; width: 100%; border-radius: 12px;"></div>
    </div>
</div>

<!-- Leaflet.js JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>

<script>
    // Initialize map centered around Mumbai / Pune Maharashtra belt
    const map = L.map('donorMap').setView([19.0760, 72.8777], 11);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors | LifeDrop Healthcare'
    }).addTo(map);

    // Marker collections from database
    const donors = [
        { name: "Rohan Mehta", blood: "O+", city: "Mumbai, Bandra", lat: 19.0596, lng: 72.8295, phone: "9876543210" },
        { name: "Priya Sharma", blood: "A+", city: "Pune, Shivaji Nagar", lat: 18.5314, lng: 73.8446, phone: "9876543211" },
        { name: "Aman Khan", blood: "B-", city: "Mumbai, Andheri", lat: 19.1136, lng: 72.8697, phone: "9876543212" },
        { name: "Ananya Deshmukh", blood: "AB+", city: "Mumbai, Dadar", lat: 19.0178, lng: 72.8478, phone: "9876543213" },
        { name: "Vikram Patel", blood: "O-", city: "Pune, Kothrud", lat: 18.5074, lng: 73.8077, phone: "9876543214" }
    ];

    const bloodBanks = [
        { name: "KEM Hospital Blood Bank", city: "Mumbai", lat: 19.0028, lng: 72.8427, phone: "02224107000" },
        { name: "Lilavati Hospital Blood Bank", city: "Mumbai", lat: 19.0514, lng: 72.8288, phone: "02226751000" },
        { name: "Ruby Hall Clinic Blood Center", city: "Pune", lat: 18.5326, lng: 73.8767, phone: "02066455100" }
    ];

    // Add donor markers (Red icon)
    donors.forEach(d => {
        const marker = L.circleMarker([d.lat, d.lng], {
            radius: 10,
            fillColor: "#e11d48",
            color: "#fff",
            weight: 2,
            opacity: 1,
            fillOpacity: 0.9
        }).addTo(map);

        marker.bindPopup(`
            <div style="min-width:180px;">
                <span class="badge bg-danger" style="font-size:0.9rem;">` + d.blood + `</span>
                <h6 class="fw-bold mt-2 mb-1">` + d.name + `</h6>
                <p class="text-muted small mb-2"><i class="fa-solid fa-location-dot me-1"></i>` + d.city + `</p>
                <div class="d-flex gap-1">
                    <a href="tel:` + d.phone + `" class="btn btn-sm btn-outline-danger flex-fill">Call</a>
                    <a href="https://wa.me/91` + d.phone + `" target="_blank" class="btn btn-sm btn-success flex-fill">WhatsApp</a>
                </div>
            </div>
        `);
    });

    // Add blood bank markers (Blue icon)
    bloodBanks.forEach(b => {
        const marker = L.circleMarker([b.lat, b.lng], {
            radius: 9,
            fillColor: "#2563eb",
            color: "#fff",
            weight: 2,
            opacity: 1,
            fillOpacity: 0.9
        }).addTo(map);

        marker.bindPopup(`
            <div style="min-width:180px;">
                <span class="badge bg-primary">Hospital Blood Center</span>
                <h6 class="fw-bold mt-2 mb-1">` + b.name + `</h6>
                <p class="text-muted small mb-2"><i class="fa-solid fa-building me-1"></i>` + b.city + `</p>
                <a href="tel:` + b.phone + `" class="btn btn-sm btn-outline-primary w-100">Contact Hospital</a>
            </div>
        `);
    });

    function locateMe() {
        const status = document.getElementById('locStatus');
        if (!navigator.geolocation) {
            status.innerHTML = "<span class='text-danger'>Geolocation is not supported by your browser.</span>";
            return;
        }
        status.innerHTML = "Locating your position...";
        navigator.geolocation.getCurrentPosition(position => {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;
            map.setView([lat, lng], 13);
            L.circle([lat, lng], { radius: 3000, color: '#3b82f6', fillOpacity: 0.1 }).addTo(map);
            L.marker([lat, lng]).addTo(map).bindPopup("<strong>You are here</strong><br/>Showing donors within 3km").openPopup();
            status.innerHTML = "<span class='text-success fw-bold'><i class='fa-solid fa-circle-check me-1'></i>Showing donors and blood centers near your current location!</span>";
        }, () => {
            status.innerHTML = "<span class='text-danger'>Unable to retrieve your location. Showing default region.</span>";
        });
    }
</script>

<%@ include file="includes/footer.jsp" %>

