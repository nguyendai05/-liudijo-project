package com.liudijo.model;

import java.math.BigDecimal;

public class CartItem {
    private long productId;
    private String name;
    private BigDecimal price;
    private int quantity;

    public CartItem(long productId, String name, BigDecimal price, int quantity) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }
    public long getProductId() { return productId; }
    public String getName() { return name; }
    public BigDecimal getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public BigDecimal getSubtotal() { return price.multiply(new BigDecimal(quantity)); }
}
