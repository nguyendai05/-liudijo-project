package com.liudijo.controller;

import com.liudijo.model.CartItem;
import com.liudijo.service.OrderService;
import com.liudijo.service.PaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name="CheckoutServlet", urlPatterns={"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final PaymentService paymentService = new PaymentService();

    @SuppressWarnings("unchecked")
    private Map<Long, CartItem> getCart(HttpSession session) {
        return (Map<Long, CartItem>) session.getAttribute("CART");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        long userId = (Long) session.getAttribute("userId");
        String paymentMethod = req.getParameter("payment");
        Map<Long, CartItem> cart = getCart(session);
        long orderId = orderService.createFromCart(userId, cart, paymentMethod);

        // Mock payment success
        String tx = paymentService.createMockPayment(orderId);
        orderService.markPaidAndFulfill(orderId, tx);

        // clear cart
        if (cart != null) cart.clear();
        resp.sendRedirect(req.getContextPath() + "/account/orders/" + orderId);
    }
}
