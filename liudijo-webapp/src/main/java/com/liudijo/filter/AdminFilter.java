package com.liudijo.filter;

import com.liudijo.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isAdmin = false;

        if (isLoggedIn) {
            User user = (User) session.getAttribute("user");
            isAdmin = user.isAdmin();
        }

        if (isAdmin) {
            // User is admin, continue with the request
            chain.doFilter(request, response);
        } else {
            // User is not admin, redirect to home or login
            if (isLoggedIn) {
                // Logged in but not admin - show access denied
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            } else {
                // Not logged in - redirect to login
                String loginPage = httpRequest.getContextPath() + "/login";
                httpResponse.sendRedirect(loginPage);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
