package com.liudijo.controller;

import com.liudijo.model.Product;
import com.liudijo.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Long> cartItems = (List<Long>) session.getAttribute("cart");

        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        List<Product> products = new ArrayList<>();
        for (Long productId : cartItems) {
            Product product = productService.getProductById(productId);
            if (product != null) {
                products.add(product);
            }
        }

        request.setAttribute("cartProducts", products);
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");

        if (productIdStr != null) {
            Long productId = Long.parseLong(productIdStr);
            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            List<Long> cart = (List<Long>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            if ("add".equals(action)) {
                if (!cart.contains(productId)) {
                    cart.add(productId);
                }
            } else if ("remove".equals(action)) {
                cart.remove(productId);
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
