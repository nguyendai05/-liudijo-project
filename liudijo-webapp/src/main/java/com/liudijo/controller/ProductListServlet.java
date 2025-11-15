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
    private static final int PAGE_SIZE = 24;

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
            // Get all filter parameters
            String q = req.getParameter("q");
            String type = req.getParameter("type");
            String sort = req.getParameter("sort");
            String price = req.getParameter("price");
            String pageParam = req.getParameter("page");

            // Parse page number
            int page = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Get products with all filters
            List<Product> products = productService.list(q, type, sort, price, page, PAGE_SIZE);

            // Get total count for pagination
            int totalProducts = productService.count(q, type, price);
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

            // Set attributes for JSP
            req.setAttribute("products", products);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentPage", page);
            req.setAttribute("pageSize", PAGE_SIZE);

            req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
        }
    }
}
