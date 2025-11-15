<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.liudijo.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <title>Giỏ hàng - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="cart-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-cart"></i> Giỏ hàng
                </h1>
                <p class="page-subtitle">Xem lại các sản phẩm bạn đã chọn</p>
            </div>

            <div class="cart-container">
                <%
                    Map<Long, CartItem> cart = (Map<Long, CartItem>) session.getAttribute("CART");
                    BigDecimal total = BigDecimal.ZERO;
                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

                    if (cart != null && !cart.isEmpty()) {
                %>
                <div class="cart-items">
                    <% for (CartItem ci : cart.values()) {
                        total = total.add(ci.getSubtotal());
                    %>
                    <div class="cart-item">
                        <div class="cart-item-image">
                            <i class="fas fa-box"></i>
                        </div>
                        <div class="cart-item-info">
                            <h3 class="cart-item-name"><%= ci.getName() %></h3>
                            <div class="cart-item-price">
                                <%= currencyFormat.format(ci.getPrice()) %>
                            </div>
                        </div>
                        <div class="cart-item-quantity">
                            <form method="post" action="<%=ctx%>/cart" style="display: flex; align-items: center; gap: 0.5rem;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="<%= ci.getProductId() %>">
                                <button type="button" class="qty-btn" onclick="this.parentNode.querySelector('input[name=qty]').stepDown(); this.parentNode.submit();">-</button>
                                <input type="number" name="qty" min="1" value="<%= ci.getQuantity() %>" class="qty-input" onchange="this.form.submit()">
                                <button type="button" class="qty-btn" onclick="this.parentNode.querySelector('input[name=qty]').stepUp(); this.parentNode.submit();">+</button>
                            </form>
                        </div>
                        <div class="cart-item-total" style="font-weight: 700; color: var(--primary); min-width: 120px; text-align: right;">
                            <%= currencyFormat.format(ci.getSubtotal()) %>
                        </div>
                        <form method="post" action="<%=ctx%>/cart" style="display: inline;">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%= ci.getProductId() %>">
                            <button type="submit" class="cart-item-remove" title="Xóa sản phẩm">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                    </div>
                    <% } %>
                </div>

                <div class="cart-summary">
                    <div class="cart-total">
                        <span>Tổng cộng:</span>
                        <span class="cart-total-amount"><%= currencyFormat.format(total) %></span>
                    </div>
                    <a href="<%=ctx%>/checkout" class="btn-checkout">
                        <i class="fas fa-credit-card"></i> Tiến hành thanh toán
                    </a>
                </div>
                <% } else { %>
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <p>Giỏ hàng của bạn đang trống</p>
                    <a href="<%=ctx%>/products" class="btn btn-view-all">
                        <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
