<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Liudijo</title>
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
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <div class="container">
            <h2>Thanh toán</h2>

            <div class="checkout-container">
                <div class="product-summary">
                    <h3>Thông tin sản phẩm</h3>
                    <div class="product-info">
                        <img src="${product.imageUrl}" alt="${product.name}">
                        <h4>${product.name}</h4>
                        <p class="price">${product.price} VNĐ</p>
                        <p>Rank: ${product.rank}</p>
                        <p>Server: ${product.server}</p>
                    </div>
                </div>

                <div class="checkout-form">
                    <h3>Thông tin giao hàng</h3>
                    <form method="post" action="${pageContext.request.contextPath}/checkout">
                        <input type="hidden" name="productId" value="${product.id}">

                        <div class="form-group">
                            <label for="deliveryEmail">Email nhận tài khoản:</label>
                            <input type="email" id="deliveryEmail" name="deliveryEmail"
                                   value="${sessionScope.user.email}" required>
                        </div>

                        <div class="form-group">
                            <label for="deliveryPhone">Số điện thoại:</label>
                            <input type="tel" id="deliveryPhone" name="deliveryPhone"
                                   value="${sessionScope.user.phone}" required>
                        </div>

                        <div class="form-group">
                            <label for="paymentMethod">Phương thức thanh toán:</label>
                            <select id="paymentMethod" name="paymentMethod" required>
                                <c:forEach var="method" items="${paymentMethods}">
                                    <option value="${method.key}">${method.value}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="note">Ghi chú (tùy chọn):</label>
                            <textarea id="note" name="note" rows="3"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Đặt hàng</button>
                    </form>
                </div>
            </div>

            <c:if test="${param.error == 'true'}">
                <p class="error-message">Đã có lỗi xảy ra. Vui lòng thử lại.</p>
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
