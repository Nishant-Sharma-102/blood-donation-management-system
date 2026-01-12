package com.bloodline.dao;

import com.bloodline.entities.BankStockView;
import com.bloodline.helper.ConnectionProvider;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BankStockDao {

    public List<BankStockView> findByBank(int bankId) throws SQLException {
        String sql = "SELECT bank_id, bank_name, blood_group, units_available, last_updated, status " +
                     "FROM v_bank_stock WHERE bank_id = ? ORDER BY blood_group";
        List<BankStockView> list = new ArrayList<>();
        try (Connection con = ConnectionProvider.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bankId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BankStockView v = new BankStockView();
                    v.setBankId(rs.getInt("bank_id"));
                    v.setBankName(rs.getString("bank_name"));
                    v.setBloodGroup(rs.getString("blood_group"));
                    v.setUnitsAvailable(rs.getInt("units_available"));
                    v.setLastUpdated(rs.getTimestamp("last_updated"));
                    v.setStatus(rs.getString("status"));
                    list.add(v);
                }
            }
        }
        return list;
    }

    public void addUnits(int bankId, String group, int units) throws SQLException {
        if (units <= 0) return;
        try (Connection con = ConnectionProvider.getConnection();
             CallableStatement cs = con.prepareCall("{CALL add_bank_stock(?, ?, ?)}")) {
            cs.setInt(1, bankId);
            cs.setString(2, group);
            cs.setInt(3, units);
            cs.execute();
        }
    }

    public void useUnits(int bankId, String group, int units) throws SQLException {
        if (units <= 0) return;
        try (Connection con = ConnectionProvider.getConnection();
             CallableStatement cs = con.prepareCall("{CALL use_bank_stock(?, ?, ?)}")) {
            cs.setInt(1, bankId);
            cs.setString(2, group);
            cs.setInt(3, units);
            cs.execute();
        } catch (SQLException e) {
            if ("45000".equals(e.getSQLState()))
                throw new SQLException("Insufficient stock for " + group, e);
            throw e;
        }
    }
}
