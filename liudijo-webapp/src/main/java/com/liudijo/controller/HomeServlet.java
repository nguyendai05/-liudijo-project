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

@WebServlet(urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get featured products (latest available products)
        List<Product> featuredProducts = productService.getAvailableProducts();

        // Limit to 8 products for homepage
        if (featuredProducts.size() > 8) {
            featuredProducts = featuredProducts.subList(0, 8);
        }

        request.setAttribute("featuredProducts", featuredProducts);
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
