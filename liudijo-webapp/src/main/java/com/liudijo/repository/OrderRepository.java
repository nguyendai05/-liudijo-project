package com.liudijo.repository;

import com.liudijo.model.Order;
import com.liudijo.model.OrderItem;
import com.liudijo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository {

    public long createOrder(Order o) {
        String sql = "INSERT INTO Orders (UserId, Status, Total, Currency, PaymentMethod, PaymentStatus, PaymentRef) " +
                "VALUES (?, 'PENDING', ?, 'VND', ?, 'INIT', NULL)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, o.getUserId());
            ps.setBigDecimal(2, o.getTotal());
            ps.setString(3, o.getPaymentMethod());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
    }

    public long addItem(OrderItem it) {
        String sql = "INSERT INTO OrderItems (OrderId, ProductId, UnitPrice, Quantity) VALUES (?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, it.getOrderId());
            ps.setLong(2, it.getProductId());
            ps.setBigDecimal(3, it.getUnitPrice());
            ps.setInt(4, it.getQuantity());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
    }

    public void markPaid(long orderId, String paymentRef) {
        String sql = "UPDATE Orders SET Status='PAID', PaymentStatus='PAID', PaymentRef=? WHERE OrderId=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, paymentRef);
            ps.setLong(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    public List<Order> listByUser(long userId) {
        String sql = "SELECT OrderId, UserId, Status, PaymentStatus, PaymentMethod, Total, CreatedAt " +
                     "FROM Orders WHERE UserId=? ORDER BY OrderId DESC";
        List<Order> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getLong("OrderId"));
                    o.setUserId(rs.getLong("UserId"));
                    o.setStatus(rs.getString("Status"));
                    o.setPaymentStatus(rs.getString("PaymentStatus"));
                    o.setPaymentMethod(rs.getString("PaymentMethod"));
                    o.setTotal(rs.getBigDecimal("Total"));
                    list.add(o);
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return list;
    }

    public Order findForUser(long orderId, long userId) {
        String sql = "SELECT OrderId, UserId, Status, PaymentStatus, PaymentMethod, Total, CreatedAt, PaymentRef " +
                     "FROM Orders WHERE OrderId=? AND UserId=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            ps.setLong(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getLong("OrderId"));
                    o.setUserId(rs.getLong("UserId"));
                    o.setStatus(rs.getString("Status"));
                    o.setPaymentStatus(rs.getString("PaymentStatus"));
                    o.setPaymentMethod(rs.getString("PaymentMethod"));
                    o.setTotal(rs.getBigDecimal("Total"));
                    o.setPaymentRef(rs.getString("PaymentRef"));
                    return o;
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public List<OrderItem> itemsOf(long orderId) {
        String sql = "SELECT OrderItemId, OrderId, ProductId, UnitPrice, Quantity FROM OrderItems WHERE OrderId=?";
        List<OrderItem> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem it = new OrderItem();
                    it.setOrderItemId(rs.getLong("OrderItemId"));
                    it.setOrderId(rs.getLong("OrderId"));
                    it.setProductId(rs.getLong("ProductId"));
                    it.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                    it.setQuantity(rs.getInt("Quantity"));
                    list.add(it);
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return list;
    }
}
