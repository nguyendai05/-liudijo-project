package com.liudijo.controller.auth;

import com.liudijo.model.User;
import com.liudijo.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name="RegisterServlet", urlPatterns={"/auth/register"})
public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        User u = userService.register(email, name, password);
        HttpSession session = req.getSession(true);
        session.setAttribute("userId", u.getUserId());
        session.setAttribute("userEmail", u.getEmail());
        session.setAttribute("userRole", u.getRole());
        resp.sendRedirect(req.getContextPath() + "/");
    }
}
