package com.liudijo.controller.admin;

import com.liudijo.model.Product;
import com.liudijo.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name="AdminProductServlet", urlPatterns={"/admin/products"})
public class AdminProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productService.list(null, null, 1, 100);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String slug = req.getParameter("slug");
        String type = req.getParameter("type");
        BigDecimal price = new BigDecimal(req.getParameter("price"));
        Product p = new Product();
        p.setName(name); p.setSlug(slug); p.setType(type); p.setPrice(price);
        p.setSalePrice(null);
        productService.create(p);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
