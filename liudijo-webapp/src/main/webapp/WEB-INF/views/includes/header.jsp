<%@ page contentType="text/html; charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!-- Header -->
<header class="site-header">
    <div class="container">
        <div class="header-content">
            <a class="logo" href="<%=ctx%>/">
                <i class="fas fa-shopping-bag"></i>
                <span>Liudijo</span>
            </a>

            <nav class="main-nav">
                <a href="<%=ctx%>/">Trang chủ</a>
                <a href="<%=ctx%>/products">Sản phẩm</a>
                <a href="<%=ctx%>/products?type=ACCOUNT">Tài khoản</a>
                <a href="<%=ctx%>/products?type=KEY">Key phần mềm</a>
                <a href="<%=ctx%>/products?type=SERVICE">Dịch vụ</a>
            </nav>

            <div class="header-actions">
                <form action="<%=ctx%>/products" method="get" class="search-form">
                    <input type="search" name="q" placeholder="Tìm kiếm sản phẩm..." class="search-input">
                    <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                </form>

                <a href="<%=ctx%>/cart" class="cart-link">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-badge">0</span>
                </a>

                <% if (session.getAttribute("user") != null) { %>
                    <a href="<%=ctx%>/customer/dashboard" class="btn-account">
                        <i class="fas fa-user"></i> Tài khoản
                    </a>
                <% } else { %>
                    <a href="<%=ctx%>/auth/login" class="btn-login">Đăng nhập</a>
                <% } %>
            </div>
        </div>
    </div>
</header>
