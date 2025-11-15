<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.liudijo.model.Product" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <% Product p = (Product) request.getAttribute("product"); %>
    <title><%= p != null ? p.getName() : "Chi tiết sản phẩm" %> - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="products-page">
        <div class="container">
            <% if (p == null) { %>
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-exclamation-triangle"></i> Không tìm thấy sản phẩm
                </h1>
                <p class="page-subtitle">Sản phẩm bạn tìm kiếm không tồn tại</p>
            </div>
            <div class="auth-container" style="text-align: center;">
                <a href="<%=ctx%>/products" class="btn btn-view-all">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách sản phẩm
                </a>
            </div>
            <% } else {
                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                boolean hasSale = p.getSalePrice() != null && p.getSalePrice().compareTo(p.getPrice()) < 0;
            %>
            <div class="product-detail-container">
                <div class="product-detail-grid">
                    <div class="product-detail-image">
                        <div class="product-detail-icon">
                            <% if ("ACCOUNT".equals(p.getType())) { %>
                                <i class="fas fa-user-circle"></i>
                            <% } else if ("KEY".equals(p.getType())) { %>
                                <i class="fas fa-key"></i>
                            <% } else { %>
                                <i class="fas fa-cog"></i>
                            <% } %>
                        </div>
                        <% if (hasSale) { %>
                        <div class="product-detail-sale-badge">
                            <i class="fas fa-bolt"></i> SALE
                        </div>
                        <% } %>
                    </div>

                    <div class="product-detail-info">
                        <span class="product-type-badge">
                            <% if ("ACCOUNT".equals(p.getType())) { %>
                                <i class="fas fa-user"></i> Tài khoản
                            <% } else if ("KEY".equals(p.getType())) { %>
                                <i class="fas fa-key"></i> Key phần mềm
                            <% } else { %>
                                <i class="fas fa-cog"></i> Dịch vụ
                            <% } %>
                        </span>

                        <h1 class="product-detail-name"><%= p.getName() %></h1>

                        <div class="product-detail-price">
                            <% if (hasSale) { %>
                                <span class="detail-price-sale"><%= currencyFormat.format(p.getSalePrice()) %></span>
                                <span class="detail-price-original"><%= currencyFormat.format(p.getPrice()) %></span>
                            <% } else { %>
                                <span class="detail-price-current"><%= currencyFormat.format(p.getPrice()) %></span>
                            <% } %>
                        </div>

                        <div class="product-detail-features">
                            <div class="feature-item">
                                <i class="fas fa-bolt"></i>
                                <span>Giao hàng tức thì</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-shield-alt"></i>
                                <span>Bảo mật 100%</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-headset"></i>
                                <span>Hỗ trợ 24/7</span>
                            </div>
                        </div>

                        <form action="<%=ctx%>/cart" method="post" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                            <div class="quantity-selector">
                                <label>Số lượng:</label>
                                <div class="quantity-controls">
                                    <button type="button" class="qty-btn" onclick="this.parentNode.querySelector('input').stepDown()">-</button>
                                    <input type="number" name="qty" value="1" min="1" class="qty-input">
                                    <button type="button" class="qty-btn" onclick="this.parentNode.querySelector('input').stepUp()">+</button>
                                </div>
                            </div>
                            <button type="submit" class="btn-add-to-cart">
                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
