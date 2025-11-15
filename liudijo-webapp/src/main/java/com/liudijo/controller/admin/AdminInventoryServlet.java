package com.liudijo.controller.admin;

import com.liudijo.service.AccountStockService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="AdminInventoryServlet", urlPatterns={"/admin/inventory"})
public class AdminInventoryServlet extends HttpServlet {
    private final AccountStockService stockService = new AccountStockService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/admin/inventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long productId = Long.parseLong(req.getParameter("productId"));
        String type = req.getParameter("type");
        String secret = req.getParameter("secret");
        String meta = req.getParameter("meta");
        stockService.addStock(productId, type, secret, meta);
        resp.sendRedirect(req.getContextPath() + "/admin/inventory");
    }
}
