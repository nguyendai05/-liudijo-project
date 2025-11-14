<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Liudijo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header>
        <nav>
            <div class="container">
                <h1>Liudijo</h1>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <div class="container">
            <h2>Đơn hàng của tôi</h2>

            <c:if test="${not empty orders}">
                <div class="orders-list">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <h3>Đơn hàng #${order.id}</h3>
                                <span class="order-date">${order.createdAt}</span>
                            </div>
                            <div class="order-body">
                                <p><strong>Sản phẩm:</strong> ${order.productName}</p>
                                <p><strong>Tổng tiền:</strong> ${order.totalAmount} VNĐ</p>
                                <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                <p><strong>Trạng thái thanh toán:</strong>
                                    <span class="status-badge status-${order.paymentStatus}">
                                        ${order.paymentStatus}
                                    </span>
                                </p>
                                <p><strong>Trạng thái đơn hàng:</strong>
                                    <span class="status-badge status-${order.orderStatus}">
                                        ${order.orderStatus}
                                    </span>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${empty orders}">
                <p class="no-orders">Bạn chưa có đơn hàng nào.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn">Mua sắm ngay</a>
            </c:if>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Liudijo. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
