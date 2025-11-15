package com.liudijo.controller;

import com.liudijo.model.CartItem;
import com.liudijo.model.Product;
import com.liudijo.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(name="CartServlet", urlPatterns={"/cart"})
public class CartServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @SuppressWarnings("unchecked")
    private Map<Long, CartItem> getCart(HttpSession session) {
        Map<Long, CartItem> cart = (Map<Long, CartItem>) session.getAttribute("CART");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("CART", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        Map<Long, CartItem> cart = getCart(session);
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            long productId = Long.parseLong(req.getParameter("productId"));
            int qty = Integer.parseInt(req.getParameter("qty"));
            Product p = productService.getById(productId);
            if (p != null) {
                CartItem ci = cart.get(productId);
                if (ci == null) {
                    ci = new CartItem(productId, p.getName(), p.getSalePrice()!=null?p.getSalePrice():p.getPrice(), qty);
                } else {
                    ci.setQuantity(ci.getQuantity() + qty);
                }
                cart.put(productId, ci);
            }
        } else if ("remove".equals(action)) {
            long productId = Long.parseLong(req.getParameter("productId"));
            cart.remove(productId);
        } else if ("update".equals(action)) {
            long productId = Long.parseLong(req.getParameter("productId"));
            int qty = Integer.parseInt(req.getParameter("qty"));
            CartItem ci = cart.get(productId);
            if (ci != null) ci.setQuantity(qty);
        } else if ("clear".equals(action)) {
            cart.clear();
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
