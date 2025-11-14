package com.liudijo.service;

import com.liudijo.model.Order;
import com.liudijo.model.Product;
import com.liudijo.util.DBConnection;
import com.liudijo.util.EmailUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private final ProductService productService;

    public OrderService() {
        this.productService = new ProductService();
    }

    /**
     * Create a new order
     */
    public Long createOrder(Long userId, Long productId, String paymentMethod,
                           String deliveryEmail, String deliveryPhone, String note) {
        // Check if product is available
        if (!productService.isProductAvailable(productId)) {
            return null;
        }

        Product product = productService.getProductById(productId);
        if (product == null) {
            return null;
        }

        String sql = "INSERT INTO orders (user_id, product_id, total_amount, payment_method, " +
                     "payment_status, order_status, delivery_email, delivery_phone, note, created_at) " +
                     "VALUES (?, ?, ?, ?, 'PENDING', 'PENDING', ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, userId);
            stmt.setLong(2, productId);
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, paymentMethod);
            stmt.setString(5, deliveryEmail);
            stmt.setString(6, deliveryPhone);
            stmt.setString(7, note);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    Long orderId = generatedKeys.getLong(1);

                    // Mark product as reserved
                    productService.markAsReserved(productId);

                    // Send order confirmation email
                    EmailUtil.sendOrderConfirmation(deliveryEmail, orderId.toString(), product.getName());

                    return orderId;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get order by ID
     */
    public Order getOrderById(Long orderId) {
        String sql = "SELECT o.*, u.username, p.name as product_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN products p ON o.product_id = p.id " +
                     "WHERE o.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractOrderFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get orders by user ID
     */
    public List<Order> getOrdersByUserId(Long userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username, p.name as product_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN products p ON o.product_id = p.id " +
                     "WHERE o.user_id = ? ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Get all orders (admin only)
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username, p.name as product_name " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN products p ON o.product_id = p.id " +
                     "ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Update payment status
     */
    public boolean updatePaymentStatus(Long orderId, String paymentStatus) {
        String sql = "UPDATE orders SET payment_status = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, paymentStatus);
            stmt.setLong(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update order status
     */
    public boolean updateOrderStatus(Long orderId, String orderStatus) {
        String sql = "UPDATE orders SET order_status = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, orderStatus);
            stmt.setLong(2, orderId);

            boolean updated = stmt.executeUpdate() > 0;

            // If order is completed, mark product as sold
            if (updated && "COMPLETED".equals(orderStatus)) {
                Order order = getOrderById(orderId);
                if (order != null) {
                    productService.markAsSold(order.getProductId());
                }
            }

            return updated;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cancel order
     */
    public boolean cancelOrder(Long orderId) {
        Order order = getOrderById(orderId);
        if (order == null) {
            return false;
        }

        // Update order status to CANCELLED
        boolean cancelled = updateOrderStatus(orderId, "CANCELLED");

        if (cancelled) {
            // Mark product as available again
            productService.markAsAvailable(order.getProductId());
        }

        return cancelled;
    }

    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getLong("id"));
        order.setUserId(rs.getLong("user_id"));
        order.setProductId(rs.getLong("product_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaymentStatus(rs.getString("payment_status"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setDeliveryEmail(rs.getString("delivery_email"));
        order.setDeliveryPhone(rs.getString("delivery_phone"));
        order.setNote(rs.getString("note"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        order.setUsername(rs.getString("username"));
        order.setProductName(rs.getString("product_name"));
        return order;
    }
}
