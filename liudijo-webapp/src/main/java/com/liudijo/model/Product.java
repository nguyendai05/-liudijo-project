package com.liudijo.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private Long id;
    private String name;
    private String description;
    private String category; // LMHT, LQMB, etc.
    private BigDecimal price;
    private String rank;
    private String server;
    private Integer championCount;
    private Integer skinCount;
    private String imageUrl;
    private String status; // AVAILABLE, SOLD, RESERVED
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product() {
    }

    public Product(Long id, String name, String description, String category, BigDecimal price,
                   String rank, String server, Integer championCount, Integer skinCount,
                   String imageUrl, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.category = category;
        this.price = price;
        this.rank = rank;
        this.server = server;
        this.championCount = championCount;
        this.skinCount = skinCount;
        this.imageUrl = imageUrl;
        this.status = status;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server;
    }

    public Integer getChampionCount() {
        return championCount;
    }

    public void setChampionCount(Integer championCount) {
        this.championCount = championCount;
    }

    public Integer getSkinCount() {
        return skinCount;
    }

    public void setSkinCount(Integer skinCount) {
        this.skinCount = skinCount;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public boolean isAvailable() {
        return "AVAILABLE".equals(this.status);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                ", price=" + price +
                ", rank='" + rank + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
