package com.liudijo.service;

import com.liudijo.model.*;
import com.liudijo.repository.OrderRepository;
import com.liudijo.repository.ProductRepository;
import com.liudijo.repository.StockRepository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class OrderService {
    private final OrderRepository orderRepo = new OrderRepository();
    private final StockRepository stockRepo = new StockRepository();
    private final ProductRepository productRepo = new ProductRepository();

    public long createFromCart(long userId, Map<Long, CartItem> cart, String paymentMethod) {
        if (cart == null || cart.isEmpty()) throw new IllegalStateException("Cart is empty");
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem ci : cart.values()) total = total.add(ci.getSubtotal());

        Order o = new Order();
        o.setUserId(userId);
        o.setPaymentMethod(paymentMethod);
        o.setTotal(total);
        long orderId = orderRepo.createOrder(o);

        for (CartItem ci : cart.values()) {
            OrderItem it = new OrderItem();
            it.setOrderId(orderId);
            it.setProductId(ci.getProductId());
            it.setUnitPrice(ci.getPrice());
            it.setQuantity(ci.getQuantity());
            long orderItemId = orderRepo.addItem(it);

            // For SERVICE, no stock assignment at this stage (only after paid)
            // For ACCOUNT/KEY: assignment after markPaid
        }
        return orderId;
    }

    public void markPaidAndFulfill(long orderId, String paymentRef) {
        orderRepo.markPaid(orderId, paymentRef);
        // Read items and assign stock for ACCOUNT/KEY
        List<OrderItem> items = orderRepo.itemsOf(orderId);
        for (OrderItem it : items) {
            Product p = productRepo.findById(it.getProductId());
            if (p != null && ( "ACCOUNT".equals(p.getType()) || "KEY".equals(p.getType()) )) {
                for (int i = 0; i < it.getQuantity(); i++) {
                    stockRepo.assignOne(it.getProductId(), it.getOrderItemId()); // one per quantity
                }
            }
        }
    }
}
