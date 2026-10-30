package com.blooddonor.model;

import java.sql.Timestamp;

public class EmergencyRequest {
    private int requestId;
    private String patientName;
    private String bloodGroup;
    private int unitsNeeded;
    private String hospitalName;
    private String city;
    private String contactPerson;
    private String contactPhone;
    private String urgency; // Critical, High, Moderate
    private String status;  // OPEN, FULFILLED, CANCELLED
    private Timestamp createdAt;

    public EmergencyRequest() {}

    public EmergencyRequest(String patientName, String bloodGroup, int unitsNeeded,
                            String hospitalName, String city, String contactPerson,
                            String contactPhone, String urgency) {
        this.patientName = patientName;
        this.bloodGroup = bloodGroup;
        this.unitsNeeded = unitsNeeded;
        this.hospitalName = hospitalName;
        this.city = city;
        this.contactPerson = contactPerson;
        this.contactPhone = contactPhone;
        this.urgency = urgency;
        this.status = "OPEN";
    }

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }

    public int getUnitsNeeded() { return unitsNeeded; }
    public void setUnitsNeeded(int unitsNeeded) { this.unitsNeeded = unitsNeeded; }

    public String getHospitalName() { return hospitalName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getContactPerson() { return contactPerson; }
    public void setContactPerson(String contactPerson) { this.contactPerson = contactPerson; }

    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }

    public String getUrgency() { return urgency; }
    public void setUrgency(String urgency) { this.urgency = urgency; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

