package com.liudijo.model;

import java.math.BigDecimal;

public class Product {
    private long productId;
    private String name;
    private String slug;
    private String type; // ACCOUNT | KEY | SERVICE
    private BigDecimal price;
    private BigDecimal salePrice;
    private boolean active;

    public long getProductId() { return productId; }
    public void setProductId(long productId) { this.productId = productId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public BigDecimal getSalePrice() { return salePrice; }
    public void setSalePrice(BigDecimal salePrice) { this.salePrice = salePrice; }
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
