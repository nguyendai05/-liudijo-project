<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Liudijo</title>
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
                    <li><a href="${pageContext.request.contextPath}/customer/dashboard">Đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <div class="container">
            <h2>Chào mừng, ${sessionScope.user.fullName}!</h2>

            <c:if test="${param.orderSuccess == 'true'}">
                <div class="success-message">
                    Đơn hàng của bạn đã được tạo thành công! Chúng tôi sẽ liên hệ với bạn sớm nhất.
                </div>
            </c:if>

            <section class="orders-section">
                <h3>Đơn hàng của bạn</h3>

                <c:if test="${not empty orders}">
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Ngày đặt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td>${order.productName}</td>
                                    <td>${order.totalAmount} VNĐ</td>
                                    <td>
                                        <span class="status-badge status-${order.paymentStatus}">
                                            ${order.paymentStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge status-${order.orderStatus}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td>${order.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${empty orders}">
                    <p class="no-orders">Bạn chưa có đơn hàng nào.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn">Mua sắm ngay</a>
                </c:if>
            </section>
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
