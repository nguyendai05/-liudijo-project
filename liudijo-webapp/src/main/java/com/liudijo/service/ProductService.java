package com.liudijo.service;

import com.liudijo.model.Product;
import com.liudijo.repository.ProductRepository;

import java.util.List;

public class ProductService {
    private final ProductRepository repo = new ProductRepository();

    public List<Product> list(String q, String type, int page, int size) {
        int offset = Math.max(0, (page-1) * size);
        return repo.listActive(size, offset, q, type);
    }

    public Product getBySlug(String slug) {
        return repo.findBySlug(slug);
    }

    public long create(Product p) {
        return repo.create(p);
    }

    public Product getById(long id) { return repo.findById(id); }
}
