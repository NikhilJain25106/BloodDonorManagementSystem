package com.blooddonor.dao;

import com.blooddonor.model.Donor;
import com.blooddonor.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the "donors" table.
 * Every method here opens its own connection using try-with-resources,
 * so connections are always closed automatically, even if an exception
 * is thrown midway through a query.
 *
 * IMPORTANT: every query uses PreparedStatement with "?" placeholders,
 * never string concatenation. This is what prevents SQL injection -
 * user input is always sent as data, never as part of the SQL text.
 */
public class DonorDAO {

    /**
     * Checks whether a donor with this phone OR email already exists.
     * Called before insertDonor() so the servlet can show a friendly
     * "already registered" message instead of letting the database
     * throw a raw duplicate-key exception.
     */
    public boolean isDuplicateDonor(String phone, String email) throws SQLException {
        String sql = "SELECT donor_id FROM donors WHERE phone = ? OR email = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, phone);
            stmt.setString(2, email);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // true if at least one matching row found
            }
        }
    }

    /**
     * Inserts a new donor record. Assumes isDuplicateDonor() was already
     * checked by the caller - this method does not check again, to avoid
     * doing the same query twice.
     */
    public void insertDonor(Donor donor) throws SQLException {
        String sql = "INSERT INTO donors " +
                "(full_name, age, gender, blood_group, phone, email, address, city, last_donation_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, donor.getFullName());
            stmt.setInt(2, donor.getAge());
            stmt.setString(3, donor.getGender());
            stmt.setString(4, donor.getBloodGroup());
            stmt.setString(5, donor.getPhone());
            stmt.setString(6, donor.getEmail());
            stmt.setString(7, donor.getAddress());
            stmt.setString(8, donor.getCity());
            stmt.setDate(9, donor.getLastDonationDate()); // may be null - fine for a nullable DATE column

            stmt.executeUpdate();
        }
    }

    /**
     * Returns every donor, most recently registered first.
     * Used by the Admin Dashboard.
     */
    public List<Donor> getAllDonors() throws SQLException {
        String sql = "SELECT * FROM donors ORDER BY created_at DESC";
        List<Donor> donors = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                donors.add(mapRowToDonor(rs));
            }
        }
        return donors;
    }

    /**
     * Searches donors by blood group and/or city. Either parameter can
     * be null or empty, meaning "don't filter by this field". Built with
     * a dynamic WHERE clause, but still fully parameterized - no raw
     * user input is ever concatenated into the SQL string itself.
     */
    public List<Donor> searchDonors(String bloodGroup, String city) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT * FROM donors WHERE 1=1");

        boolean hasBloodGroup = bloodGroup != null && !bloodGroup.trim().isEmpty();
        boolean hasCity = city != null && !city.trim().isEmpty();

        if (hasBloodGroup) {
            sql.append(" AND blood_group = ?");
        }
        if (hasCity) {
            sql.append(" AND city LIKE ?");
        }
        sql.append(" ORDER BY full_name ASC");

        List<Donor> donors = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (hasBloodGroup) {
                stmt.setString(paramIndex++, bloodGroup);
            }
            if (hasCity) {
                // "%city%" allows partial matches, e.g. searching "mum" finds "Mumbai"
                stmt.setString(paramIndex++, "%" + city.trim() + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    donors.add(mapRowToDonor(rs));
                }
            }
        }
        return donors;
    }

    /**
     * Fetches a single donor by ID. Used by the Edit page to pre-fill
     * the form, and internally before performing an update.
     */
    public Donor getDonorById(int donorId) throws SQLException {
        String sql = "SELECT * FROM donors WHERE donor_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donorId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToDonor(rs);
                }
                return null; // no donor with that ID
            }
        }
    }

    /**
     * Updates an existing donor's editable fields. donorId itself is
     * never changed - it's only used to locate the row via WHERE.
     */
    public void updateDonor(Donor donor) throws SQLException {
        String sql = "UPDATE donors SET full_name = ?, age = ?, gender = ?, blood_group = ?, " +
                "phone = ?, email = ?, address = ?, city = ?, last_donation_date = ? " +
                "WHERE donor_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, donor.getFullName());
            stmt.setInt(2, donor.getAge());
            stmt.setString(3, donor.getGender());
            stmt.setString(4, donor.getBloodGroup());
            stmt.setString(5, donor.getPhone());
            stmt.setString(6, donor.getEmail());
            stmt.setString(7, donor.getAddress());
            stmt.setString(8, donor.getCity());
            stmt.setDate(9, donor.getLastDonationDate());
            stmt.setInt(10, donor.getDonorId());

            stmt.executeUpdate();
        }
    }

    /**
     * Deletes a donor by ID. Called only from the Admin Dashboard,
     * which is itself protected by AdminAuthFilter (Step 8) - so an
     * unauthenticated visitor can never reach this method through the web.
     */
    public void deleteDonor(int donorId) throws SQLException {
        String sql = "DELETE FROM donors WHERE donor_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donorId);
            stmt.executeUpdate();
        }
    }

    /**
     * Converts one row of a ResultSet into a Donor object.
     * Kept as a single private helper so all five query methods above
     * build Donor objects identically - one place to fix if a column
     * is ever added or renamed.
     */
    private Donor mapRowToDonor(ResultSet rs) throws SQLException {
        Donor donor = new Donor();
        donor.setDonorId(rs.getInt("donor_id"));
        donor.setFullName(rs.getString("full_name"));
        donor.setAge(rs.getInt("age"));
        donor.setGender(rs.getString("gender"));
        donor.setBloodGroup(rs.getString("blood_group"));
        donor.setPhone(rs.getString("phone"));
        donor.setEmail(rs.getString("email"));
        donor.setAddress(rs.getString("address"));
        donor.setCity(rs.getString("city"));
        donor.setLastDonationDate(rs.getDate("last_donation_date"));
        donor.setCreatedAt(rs.getDate("created_at"));
        return donor;
    }
}