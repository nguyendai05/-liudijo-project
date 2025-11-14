package com.liudijo.controller.admin;

import com.liudijo.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("products", productService.getAllProducts());
        request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String rank = request.getParameter("rank");
        String server = request.getParameter("server");
        Integer championCount = Integer.parseInt(request.getParameter("championCount"));
        Integer skinCount = Integer.parseInt(request.getParameter("skinCount"));
        String imageUrl = request.getParameter("imageUrl");

        productService.createProduct(name, description, category, price, rank, server,
                championCount, skinCount, imageUrl);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) {
        Long productId = Long.parseLong(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String rank = request.getParameter("rank");
        String server = request.getParameter("server");
        Integer championCount = Integer.parseInt(request.getParameter("championCount"));
        Integer skinCount = Integer.parseInt(request.getParameter("skinCount"));
        String imageUrl = request.getParameter("imageUrl");
        String status = request.getParameter("status");

        productService.updateProduct(productId, name, description, category, price, rank, server,
                championCount, skinCount, imageUrl, status);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) {
        Long productId = Long.parseLong(request.getParameter("productId"));
        productService.deleteProduct(productId);
    }
}
