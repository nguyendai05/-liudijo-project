package com.liudijo.service;

import com.liudijo.util.DBConnection;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class AccountStockService {

    /**
     * Get stock count by category
     */
    public Map<String, Integer> getStockByCategory() {
        Map<String, Integer> stockMap = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM products " +
                     "WHERE status = 'AVAILABLE' GROUP BY category";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                stockMap.put(rs.getString("category"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockMap;
    }

    /**
     * Get stock count by rank for a specific category
     */
    public Map<String, Integer> getStockByRank(String category) {
        Map<String, Integer> stockMap = new HashMap<>();
        String sql = "SELECT rank, COUNT(*) as count FROM products " +
                     "WHERE category = ? AND status = 'AVAILABLE' GROUP BY rank";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                stockMap.put(rs.getString("rank"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockMap;
    }

    /**
     * Get total available accounts
     */
    public int getTotalAvailableAccounts() {
        String sql = "SELECT COUNT(*) as count FROM products WHERE status = 'AVAILABLE'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Get total sold accounts
     */
    public int getTotalSoldAccounts() {
        String sql = "SELECT COUNT(*) as count FROM products WHERE status = 'SOLD'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Get stock statistics
     */
    public Map<String, Object> getStockStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("available", getTotalAvailableAccounts());
        stats.put("sold", getTotalSoldAccounts());
        stats.put("byCategory", getStockByCategory());
        return stats;
    }
}
