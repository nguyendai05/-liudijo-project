package com.liudijo.controller.customer;

import com.liudijo.model.Order;
import com.liudijo.repository.OrderRepository;
import com.liudijo.service.AccountStockService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name="OrderDetailServlet", urlPatterns={"/account/orders/*"})
public class OrderDetailServlet extends HttpServlet {
    private final OrderRepository orderRepo = new OrderRepository();
    private final AccountStockService stockService = new AccountStockService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        long userId = (Long) session.getAttribute("userId");
        String path = req.getPathInfo();
        long orderId = Long.parseLong(path.substring(1));
        Order o = orderRepo.findForUser(orderId, userId);
        if (o == null) {
            resp.sendError(404);
            return;
        }
        req.setAttribute("order", o);
        if ("PAID".equals(o.getPaymentStatus()) || "PAID".equals(o.getStatus())) {
            List<String> secrets = stockService.getDecryptedSecretsByOrder(orderId);
            req.setAttribute("secrets", secrets);
        }
        req.getRequestDispatcher("/WEB-INF/views/customer/order-detail.jsp").forward(req, resp);
    }
}
