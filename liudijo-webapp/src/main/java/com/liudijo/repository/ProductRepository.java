package com.liudijo.repository;

import com.liudijo.model.Product;
import com.liudijo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {
    public List<Product> listActive(int limit, int offset, String q, String type) {
        return listActive(limit, offset, q, type, null, null);
    }

    public List<Product> listActive(int limit, int offset, String q, String type, String sort, String priceRange) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT ProductId, Name, Slug, Type, Price, SalePrice, IsActive FROM Products WHERE IsActive=1 ");
        if (q != null && !q.isEmpty()) sb.append(" AND Name LIKE ? ");
        if (type != null && !type.isEmpty()) sb.append(" AND Type = ? ");

        // Price range filter
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "0-50000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 0 AND COALESCE(SalePrice, Price) < 50000 ");
                    break;
                case "50000-100000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 50000 AND COALESCE(SalePrice, Price) < 100000 ");
                    break;
                case "100000-200000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 100000 AND COALESCE(SalePrice, Price) < 200000 ");
                    break;
                case "200000-":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 200000 ");
                    break;
            }
        }

        // Sorting
        String orderBy = "ProductId DESC"; // Default: newest
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "price_asc":
                    orderBy = "COALESCE(SalePrice, Price) ASC";
                    break;
                case "price_desc":
                    orderBy = "COALESCE(SalePrice, Price) DESC";
                    break;
                case "name_asc":
                    orderBy = "Name ASC";
                    break;
                case "bestseller":
                    orderBy = "ProductId ASC"; // Placeholder for actual bestseller logic
                    break;
                case "newest":
                default:
                    orderBy = "ProductId DESC";
                    break;
            }
        }

        sb.append(" ORDER BY ").append(orderBy).append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
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

    public int countActive(String q, String type, String priceRange) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT COUNT(*) FROM Products WHERE IsActive=1 ");
        if (q != null && !q.isEmpty()) sb.append(" AND Name LIKE ? ");
        if (type != null && !type.isEmpty()) sb.append(" AND Type = ? ");

        // Price range filter
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "0-50000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 0 AND COALESCE(SalePrice, Price) < 50000 ");
                    break;
                case "50000-100000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 50000 AND COALESCE(SalePrice, Price) < 100000 ");
                    break;
                case "100000-200000":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 100000 AND COALESCE(SalePrice, Price) < 200000 ");
                    break;
                case "200000-":
                    sb.append(" AND COALESCE(SalePrice, Price) >= 200000 ");
                    break;
            }
        }

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sb.toString())) {
            int idx = 1;
            if (q != null && !q.isEmpty()) ps.setString(idx++, "%" + q + "%");
            if (type != null && !type.isEmpty()) ps.setString(idx++, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
        return 0;
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
