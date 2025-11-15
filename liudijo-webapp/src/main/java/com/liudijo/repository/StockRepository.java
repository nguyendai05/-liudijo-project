package com.liudijo.repository;

import com.liudijo.model.StockItem;
import com.liudijo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StockRepository {

    public void assignOne(long productId, long orderItemId) {
        try (Connection c = DBConnection.getConnection();
             CallableStatement cs = c.prepareCall("{call sp_AssignStockItem(?,?)}")) {
            cs.setLong(1, productId);
            cs.setLong(2, orderItemId);
            cs.execute();
        } catch (SQLException e) {
            throw new RuntimeException("Assign stock failed: " + e.getMessage(), e);
        }
    }

    public List<StockItem> getAssignedByOrder(long orderId) {
        String sql = "SELECT s.StockItemId, s.ProductId, s.Type, s.SecretEncrypted, s.Meta, s.IsSold, s.SoldAt, s.OrderItemId " +
                     "FROM StockItems s JOIN OrderItems oi ON s.OrderItemId = oi.OrderItemId " +
                     "WHERE oi.OrderId=? ORDER BY s.StockItemId";
        List<StockItem> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockItem si = new StockItem();
                    si.setStockItemId(rs.getLong("StockItemId"));
                    si.setProductId(rs.getLong("ProductId"));
                    si.setType(rs.getString("Type"));
                    si.setSecretEncrypted(rs.getBytes("SecretEncrypted"));
                    si.setMeta(rs.getString("Meta"));
                    si.setSold(rs.getBoolean("IsSold"));
                    si.setOrderItemId(rs.getLong("OrderItemId"));
                    list.add(si);
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return list;
    }

    public long insertOne(long productId, String type, byte[] secretEncrypted, String meta) {
        String sql = "INSERT INTO StockItems (ProductId, Type, SecretEncrypted, Meta, IsSold) VALUES (?,?,?,?,0)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, productId);
            ps.setString(2, type);
            ps.setBytes(3, secretEncrypted);
            ps.setString(4, meta);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
    }
}
