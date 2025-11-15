package com.liudijo.repository;

import com.liudijo.model.Product;
import com.liudijo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {
    public List<Product> listActive(int limit, int offset, String q, String type) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT ProductId, Name, Slug, Type, Price, SalePrice, IsActive FROM Products WHERE IsActive=1 ");
        if (q != null && !q.isEmpty()) sb.append(" AND Name LIKE ? ");
        if (type != null && !type.isEmpty()) sb.append(" AND Type = ? ");
        sb.append(" ORDER BY ProductId DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        List<Product> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sb.toString())) {
            int idx = 1;
            if (q != null && !q.isEmpty()) ps.setString(idx++, "%" + q + "%");
            if (type != null && !type.isEmpty()) ps.setString(idx++, type);
            ps.setInt(idx++, offset);
            ps.setInt(idx, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getLong("ProductId"));
                    p.setName(rs.getString("Name"));
                    p.setSlug(rs.getString("Slug"));
                    p.setType(rs.getString("Type"));
                    p.setPrice(rs.getBigDecimal("Price"));
                    p.setSalePrice(rs.getBigDecimal("SalePrice"));
                    p.setActive(rs.getBoolean("IsActive"));
                    list.add(p);
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return list;
    }

    public Product findBySlug(String slug) {
        String sql = "SELECT ProductId, Name, Slug, Type, Price, SalePrice, IsActive FROM Products WHERE Slug=? AND IsActive=1";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, slug);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getLong("ProductId"));
                    p.setName(rs.getString("Name"));
                    p.setSlug(rs.getString("Slug"));
                    p.setType(rs.getString("Type"));
                    p.setPrice(rs.getBigDecimal("Price"));
                    p.setSalePrice(rs.getBigDecimal("SalePrice"));
                    p.setActive(rs.getBoolean("IsActive"));
                    return p;
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public Product findById(long id) {
        String sql = "SELECT ProductId, Name, Slug, Type, Price, SalePrice, IsActive FROM Products WHERE ProductId=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getLong("ProductId"));
                    p.setName(rs.getString("Name"));
                    p.setSlug(rs.getString("Slug"));
                    p.setType(rs.getString("Type"));
                    p.setPrice(rs.getBigDecimal("Price"));
                    p.setSalePrice(rs.getBigDecimal("SalePrice"));
                    p.setActive(rs.getBoolean("IsActive"));
                    return p;
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return null;
    }

    public long create(Product p) {
        String sql = "INSERT INTO Products (CategoryId, Name, Slug, Type, Price, SalePrice, Currency, IsActive) " +
                     "VALUES (NULL,?,?,?,?,?, 'VND', 1)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getSlug());
            ps.setString(3, p.getType());
            ps.setBigDecimal(4, p.getPrice());
            ps.setBigDecimal(5, p.getSalePrice());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
    }
}
