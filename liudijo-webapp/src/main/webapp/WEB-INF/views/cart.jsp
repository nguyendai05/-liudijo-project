<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Liudijo</title>
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
                    <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <div class="container">
            <h2>Giỏ hàng của bạn</h2>

            <c:if test="${not empty cartProducts}">
                <div class="cart-items">
                    <c:forEach var="product" items="${cartProducts}">
                        <div class="cart-item">
                            <img src="${product.imageUrl}" alt="${product.name}">
                            <div class="item-details">
                                <h3>${product.name}</h3>
                                <p class="price">${product.price} VNĐ</p>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/cart">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="action" value="remove">
                                <button type="submit" class="btn-remove">Xóa</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${empty cartProducts}">
                <p class="empty-cart">Giỏ hàng của bạn đang trống</p>
                <a href="${pageContext.request.contextPath}/products" class="btn">Tiếp tục mua sắm</a>
            </c:if>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Liudijo. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
</body>
</html>
