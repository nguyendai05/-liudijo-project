package com.liudijo.controller;

import com.liudijo.model.Product;
import com.liudijo.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name="ProductListServlet", urlPatterns={"/products","/product/*"})
public class ProductListServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/product".equals(path)) {
            String slug = req.getPathInfo();
            if (slug != null && slug.startsWith("/")) slug = slug.substring(1);
            Product p = productService.getBySlug(slug);
            req.setAttribute("product", p);
            req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
        } else {
            String q = req.getParameter("q");
            String type = req.getParameter("type");
            List<Product> products = productService.list(q, type, 1, 24);
            req.setAttribute("products", products);
            req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
        }
    }
}
