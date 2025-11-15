package com.liudijo.model;

import java.time.LocalDateTime;

public class StockItem {
    private long stockItemId;
    private long productId;
    private String type; // ACCOUNT or KEY
    private byte[] secretEncrypted;
    private String meta;
    private boolean sold;
    private LocalDateTime soldAt;
    private Long orderItemId;

    public long getStockItemId() { return stockItemId; }
    public void setStockItemId(long stockItemId) { this.stockItemId = stockItemId; }
    public long getProductId() { return productId; }
    public void setProductId(long productId) { this.productId = productId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public byte[] getSecretEncrypted() { return secretEncrypted; }
    public void setSecretEncrypted(byte[] secretEncrypted) { this.secretEncrypted = secretEncrypted; }
    public String getMeta() { return meta; }
    public void setMeta(String meta) { this.meta = meta; }
    public boolean isSold() { return sold; }
    public void setSold(boolean sold) { this.sold = sold; }
    public LocalDateTime getSoldAt() { return soldAt; }
    public void setSoldAt(LocalDateTime soldAt) { this.soldAt = soldAt; }
    public Long getOrderItemId() { return orderItemId; }
    public void setOrderItemId(Long orderItemId) { this.orderItemId = orderItemId; }
}
