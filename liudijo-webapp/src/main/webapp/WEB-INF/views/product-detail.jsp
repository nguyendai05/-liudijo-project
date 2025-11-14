<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Liudijo</title>
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
            <div class="product-detail">
                <div class="product-image">
                    <img src="${product.imageUrl}" alt="${product.name}">
                </div>

                <div class="product-info">
                    <h2>${product.name}</h2>
                    <p class="price">${product.price} VNĐ</p>

                    <div class="product-specs">
                        <p><strong>Danh mục:</strong> ${product.category}</p>
                        <p><strong>Rank:</strong> ${product.rank}</p>
                        <p><strong>Server:</strong> ${product.server}</p>
                        <p><strong>Số tướng:</strong> ${product.championCount}</p>
                        <p><strong>Số skin:</strong> ${product.skinCount}</p>
                    </div>

                    <div class="product-description">
                        <h3>Mô tả</h3>
                        <p>${product.description}</p>
                    </div>

                    <c:choose>
                        <c:when test="${product.available}">
                            <a href="${pageContext.request.contextPath}/checkout?productId=${product.id}"
                               class="btn btn-primary btn-large">Mua ngay</a>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-disabled" disabled>Đã bán</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
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
