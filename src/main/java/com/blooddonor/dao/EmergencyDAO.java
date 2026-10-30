package com.blooddonor.dao;

import com.blooddonor.model.EmergencyRequest;
import com.blooddonor.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmergencyDAO {

    public void insertRequest(EmergencyRequest req) throws SQLException {
        String sql = "INSERT INTO emergency_requests (patient_name, blood_group, units_needed, hospital_name, city, contact_person, contact_phone, urgency, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'OPEN')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, req.getPatientName());
            stmt.setString(2, req.getBloodGroup());
            stmt.setInt(3, req.getUnitsNeeded());
            stmt.setString(4, req.getHospitalName());
            stmt.setString(5, req.getCity());
            stmt.setString(6, req.getContactPerson());
            stmt.setString(7, req.getContactPhone());
            stmt.setString(8, req.getUrgency());
            stmt.executeUpdate();
        }
    }

    public List<EmergencyRequest> getActiveRequests() throws SQLException {
        String sql = "SELECT * FROM emergency_requests WHERE status = 'OPEN' ORDER BY created_at DESC LIMIT 10";
        List<EmergencyRequest> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public void fulfillRequest(int requestId) throws SQLException {
        String sql = "UPDATE emergency_requests SET status = 'FULFILLED' WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            stmt.executeUpdate();
        }
    }

    private EmergencyRequest mapRow(ResultSet rs) throws SQLException {
        EmergencyRequest r = new EmergencyRequest();
        r.setRequestId(rs.getInt("request_id"));
        r.setPatientName(rs.getString("patient_name"));
        r.setBloodGroup(rs.getString("blood_group"));
        r.setUnitsNeeded(rs.getInt("units_needed"));
        r.setHospitalName(rs.getString("hospital_name"));
        r.setCity(rs.getString("city"));
        r.setContactPerson(rs.getString("contact_person"));
        r.setContactPhone(rs.getString("contact_phone"));
        r.setUrgency(rs.getString("urgency"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}

