package com.liudijo.controller.admin;

import com.liudijo.service.AccountStockService;
import com.liudijo.service.OrderService;
import com.liudijo.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private ProductService productService;
    private OrderService orderService;
    private AccountStockService accountStockService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        orderService = new OrderService();
        accountStockService = new AccountStockService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get statistics
        Map<String, Object> stockStats = accountStockService.getStockStatistics();
        request.setAttribute("stockStats", stockStats);

        // Get recent orders
        request.setAttribute("recentOrders", orderService.getAllOrders());

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
