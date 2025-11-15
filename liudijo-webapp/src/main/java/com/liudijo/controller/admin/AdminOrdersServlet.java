package com.liudijo.controller.admin;

import com.liudijo.model.Order;
import com.liudijo.repository.OrderRepository;
import com.liudijo.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name="AdminOrdersServlet", urlPatterns={"/admin/orders"})
public class AdminOrdersServlet extends HttpServlet {
    private final OrderRepository repo = new OrderRepository();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // simple: list all orders is not implemented; reuse listByUser for demo (requires user id)
        req.setAttribute("orders", java.util.Collections.emptyList());
        req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long orderId = Long.parseLong(req.getParameter("orderId"));
        orderService.markPaidAndFulfill(orderId, "ADMIN-MARK-PAID");
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }
}
