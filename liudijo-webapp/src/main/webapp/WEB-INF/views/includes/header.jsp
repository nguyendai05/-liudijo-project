<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="header">
    <nav class="navbar">
        <div class="logo">
            <!--
              SỬA LỖI: Đã xóa ${pageContext.request.contextPath}
              Thẻ <base> trong head.jsp sẽ tự động xử lý.
              href="/" sẽ trỏ về trang chủ của webapp.
            -->
            <a href="/">
                <img src="assets/images/logo.png" alt="LiuDijo Logo">
            </a>
        </div>

        <ul class="nav-links">
            <!-- SỬA LỖI: Đã dọn dẹp tất cả các link -->
            <li><a href="/">Trang chủ</a></li>
            <li><a href="products">Sản phẩm</a></li>
            <!-- Thêm các link khác nếu có -->
        </ul>

        <div class="nav-icons">
            <a href="cart" class="nav-icon">
                <!-- Icon giỏ hàng (ví dụ: Font Awesome) -->
                <span>Giỏ hàng</span>
            </a>

            <!-- Kiểm tra xem người dùng đã đăng nhập chưa -->
            <c:if test="${empty sessionScope.user}">
                <a href="login" class="nav-icon">Đăng nhập</a>
                <a href="register" class="nav-icon">Đăng ký</a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <!-- Hiển thị tên người dùng hoặc link dashboard -->
                <a href="customer/dashboard" class="nav-icon">
                    Chào, ${sessionScope.user.firstName}
                </a>
                <!-- Link Đăng xuất -->
                <a href="logout" class="nav-icon">Đăng xuất</a>

                <!-- Hiển thị link Admin nếu là admin -->
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="admin/dashboard" class="nav-icon">Admin</a>
                </c:if>
            </c:if>
        </div>
    </nav>
</header>