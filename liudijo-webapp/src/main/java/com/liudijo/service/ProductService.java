package com.liudijo.service;

import com.liudijo.model.Product;
import com.liudijo.repository.ProductRepository;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {
    private final ProductRepository productRepository;

    public ProductService() {
        this.productRepository = new ProductRepository();
    }

    /**
     * Get all products
     */
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    /**
     * Get available products only
     */
    public List<Product> getAvailableProducts() {
        return productRepository.findByStatus("AVAILABLE");
    }

    /**
     * Get product by ID
     */
    public Product getProductById(Long id) {
        return productRepository.findById(id);
    }

    /**
     * Get products by category
     */
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    /**
     * Search products
     */
    public List<Product> searchProducts(String keyword) {
        return productRepository.searchProducts(keyword);
    }

    /**
     * Create new product (admin only)
     */
    public boolean createProduct(String name, String description, String category,
                                 BigDecimal price, String rank, String server,
                                 Integer championCount, Integer skinCount, String imageUrl) {
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setCategory(category);
        product.setPrice(price);
        product.setRank(rank);
        product.setServer(server);
        product.setChampionCount(championCount);
        product.setSkinCount(skinCount);
        product.setImageUrl(imageUrl);
        product.setStatus("AVAILABLE");

        return productRepository.save(product);
    }

    /**
     * Update product (admin only)
     */
    public boolean updateProduct(Long productId, String name, String description, String category,
                                 BigDecimal price, String rank, String server,
                                 Integer championCount, Integer skinCount, String imageUrl, String status) {
        Product product = productRepository.findById(productId);
        if (product == null) {
            return false;
        }

        product.setName(name);
        product.setDescription(description);
        product.setCategory(category);
        product.setPrice(price);
        product.setRank(rank);
        product.setServer(server);
        product.setChampionCount(championCount);
        product.setSkinCount(skinCount);
        product.setImageUrl(imageUrl);
        product.setStatus(status);

        return productRepository.update(product);
    }

    /**
     * Mark product as sold
     */
    public boolean markAsSold(Long productId) {
        return productRepository.updateStatus(productId, "SOLD");
    }

    /**
     * Mark product as reserved
     */
    public boolean markAsReserved(Long productId) {
        return productRepository.updateStatus(productId, "RESERVED");
    }

    /**
     * Mark product as available
     */
    public boolean markAsAvailable(Long productId) {
        return productRepository.updateStatus(productId, "AVAILABLE");
    }

    /**
     * Delete product (admin only)
     */
    public boolean deleteProduct(Long productId) {
        return productRepository.delete(productId);
    }

    /**
     * Check if product is available for purchase
     */
    public boolean isProductAvailable(Long productId) {
        Product product = productRepository.findById(productId);
        return product != null && product.isAvailable();
    }
}
