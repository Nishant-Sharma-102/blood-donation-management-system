package com.bloodline.dao;

import com.bloodline.entities.BloodBank;
import com.bloodline.helper.ConnectionProvider;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BloodBankDao {

    public List<BloodBank> findAll() throws SQLException {
        String sql = "SELECT bank_id, name, city, address, phone, email, license_no, established_date, is_active " +
                     "FROM blood_bank ORDER BY name";
        List<BloodBank> list = new ArrayList<>();
        try (Connection con = ConnectionProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BloodBank b = new BloodBank();
                b.setBankId(rs.getInt("bank_id"));
                b.setName(rs.getString("name"));
                b.setCity(rs.getString("city"));
                b.setAddress(rs.getString("address"));
                b.setPhone(rs.getString("phone"));
                b.setEmail(rs.getString("email"));
                b.setLicenseNo(rs.getString("license_no"));
                b.setEstablishedDate(rs.getDate("established_date"));
                b.setActive(rs.getBoolean("is_active"));
                list.add(b);
            }
        }
        return list;
    }

    public int create(BloodBank bank) throws SQLException {
        String sql = "INSERT INTO blood_bank (name, city, address, phone, email, license_no, established_date, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, bank.getName());
            ps.setString(2, bank.getCity());
            ps.setString(3, bank.getAddress());
            ps.setString(4, bank.getPhone());
            ps.setString(5, bank.getEmail());
            ps.setString(6, bank.getLicenseNo());
            ps.setDate(7, bank.getEstablishedDate());
            ps.setBoolean(8, bank.isActive());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return 0;
    }
}
