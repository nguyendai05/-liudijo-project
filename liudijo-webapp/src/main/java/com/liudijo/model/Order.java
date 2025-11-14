package com.liudijo.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private Long id;
    private Long userId;
    private Long productId;
    private BigDecimal totalAmount;
    private String paymentMethod; // BANK_TRANSFER, MOMO, VNPAY
    private String paymentStatus; // PENDING, PAID, FAILED
    private String orderStatus; // PENDING, PROCESSING, COMPLETED, CANCELLED
    private String deliveryEmail;
    private String deliveryPhone;
    private String note;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Additional fields for joined data
    private String username;
    private String productName;

    public Order() {
    }

    public Order(Long id, Long userId, Long productId, BigDecimal totalAmount,
                 String paymentMethod, String paymentStatus, String orderStatus,
                 String deliveryEmail, String deliveryPhone, String note,
                 Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.orderStatus = orderStatus;
        this.deliveryEmail = deliveryEmail;
        this.deliveryPhone = deliveryPhone;
        this.note = note;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getDeliveryEmail() {
        return deliveryEmail;
    }

    public void setDeliveryEmail(String deliveryEmail) {
        this.deliveryEmail = deliveryEmail;
    }

    public String getDeliveryPhone() {
        return deliveryPhone;
    }

    public void setDeliveryPhone(String deliveryPhone) {
        this.deliveryPhone = deliveryPhone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public boolean isPaid() {
        return "PAID".equals(this.paymentStatus);
    }

    public boolean isCompleted() {
        return "COMPLETED".equals(this.orderStatus);
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", totalAmount=" + totalAmount +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                '}';
    }
}
