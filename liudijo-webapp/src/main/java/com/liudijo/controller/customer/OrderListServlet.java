package com.liudijo.controller.customer;

import com.liudijo.model.Order;
import com.liudijo.repository.OrderRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name="OrderListServlet", urlPatterns={"/account/orders"})
public class OrderListServlet extends HttpServlet {
    private final OrderRepository repo = new OrderRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        long userId = (Long) session.getAttribute("userId");
        List<Order> orders = repo.listByUser(userId);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/views/customer/orders.jsp").forward(req, resp);
    }
}
