<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - Liudijo</title>
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
                    <c:if test="${not empty sessionScope.user}">
                        <li><a href="${pageContext.request.contextPath}/customer/dashboard">Đơn hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                    </c:if>
                </ul>
            </div>
        </nav>
    </header>

    <main>
        <div class="container">
            <h2>Danh sách sản phẩm</h2>

            <div class="filters">
                <form method="get" action="${pageContext.request.contextPath}/products">
                    <input type="text" name="search" placeholder="Tìm kiếm..." value="${search}">
                    <select name="category">
                        <option value="">Tất cả danh mục</option>
                        <option value="LMHT" ${category == 'LMHT' ? 'selected' : ''}>Liên Minh Huyền Thoại</option>
                        <option value="LQMB" ${category == 'LQMB' ? 'selected' : ''}>Liên Quân Mobile</option>
                        <option value="FREEFIRE" ${category == 'FREEFIRE' ? 'selected' : ''}>Free Fire</option>
                    </select>
                    <button type="submit">Lọc</button>
                </form>
            </div>

            <div class="product-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <img src="${product.imageUrl}" alt="${product.name}">
                        <h3>${product.name}</h3>
                        <p class="price">${product.price} VNĐ</p>
                        <p class="rank">Rank: ${product.rank}</p>
                        <p class="server">Server: ${product.server}</p>
                        <p class="champions">Tướng: ${product.championCount}</p>
                        <p class="skins">Skin: ${product.skinCount}</p>
                        <c:choose>
                            <c:when test="${product.available}">
                                <a href="${pageContext.request.contextPath}/checkout?productId=${product.id}" class="btn">Mua ngay</a>
                            </c:when>
                            <c:otherwise>
                                <span class="sold-badge">Đã bán</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty products}">
                <p class="no-products">Không tìm thấy sản phẩm nào</p>
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
