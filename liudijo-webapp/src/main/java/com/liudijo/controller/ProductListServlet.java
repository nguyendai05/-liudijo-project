package com.liudijo.controller;

import com.liudijo.model.Product;
import com.liudijo.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String search = request.getParameter("search");

        List<Product> products;

        if (search != null && !search.trim().isEmpty()) {
            // Search products
            products = productService.searchProducts(search);
        } else if (category != null && !category.trim().isEmpty()) {
            // Filter by category
            products = productService.getProductsByCategory(category);
        } else {
            // Get all available products
            products = productService.getAvailableProducts();
        }

        request.setAttribute("products", products);
        request.setAttribute("category", category);
        request.setAttribute("search", search);
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
    }
}
