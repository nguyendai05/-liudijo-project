<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liudijo - Trang chủ</title>
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
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:choose>
                                <c:when test="${sessionScope.user.admin}">
                                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Admin</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="${pageContext.request.contextPath}/customer/dashboard">Đơn hàng</a></li>
                                </c:otherwise>
                            </c:choose>
                            <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="container">
                <h2>Chào mừng đến với Liudijo</h2>
                <p>Nơi mua bán tài khoản game uy tín</p>
            </div>
        </section>

        <section class="featured-products">
            <div class="container">
                <h2>Sản phẩm nổi bật</h2>
                <div class="product-grid">
                    <c:forEach var="product" items="${featuredProducts}">
                        <div class="product-card">
                            <img src="${product.imageUrl}" alt="${product.name}">
                            <h3>${product.name}</h3>
                            <p class="price">${product.price} VNĐ</p>
                            <p class="rank">Rank: ${product.rank}</p>
                            <a href="${pageContext.request.contextPath}/checkout?productId=${product.id}" class="btn">Mua ngay</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Liudijo. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
