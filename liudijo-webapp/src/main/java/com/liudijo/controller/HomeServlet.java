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

@WebServlet(name="HomeServlet", urlPatterns={"/", "/home"})
public class HomeServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy 12 sản phẩm nổi bật (featured products)
        List<Product> featuredProducts = productService.list(null, null, 1, 12);
        req.setAttribute("featuredProducts", featuredProducts);

        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
