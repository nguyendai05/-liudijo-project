package com.liudijo.controller;

import com.liudijo.model.Product;
import com.liudijo.model.User;
import com.liudijo.service.OrderService;
import com.liudijo.service.PaymentService;
import com.liudijo.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private ProductService productService;
    private OrderService orderService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        orderService = new OrderService();
        paymentService = new PaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("productId");

        if (productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        Long productId = Long.parseLong(productIdStr);
        Product product = productService.getProductById(productId);

        if (product == null || !product.isAvailable()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        request.setAttribute("product", product);
        request.setAttribute("paymentMethods", paymentService.getPaymentMethods());
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String productIdStr = request.getParameter("productId");
        String paymentMethod = request.getParameter("paymentMethod");
        String deliveryEmail = request.getParameter("deliveryEmail");
        String deliveryPhone = request.getParameter("deliveryPhone");
        String note = request.getParameter("note");

        Long productId = Long.parseLong(productIdStr);

        // Create order
        Long orderId = orderService.createOrder(
                user.getId(),
                productId,
                paymentMethod,
                deliveryEmail,
                deliveryPhone,
                note
        );

        if (orderId != null) {
            // Redirect to customer dashboard with success message
            response.sendRedirect(request.getContextPath() + "/customer/dashboard?orderSuccess=true");
        } else {
            // Redirect back to checkout with error
            response.sendRedirect(request.getContextPath() + "/checkout?productId=" + productId + "&error=true");
        }
    }
}
