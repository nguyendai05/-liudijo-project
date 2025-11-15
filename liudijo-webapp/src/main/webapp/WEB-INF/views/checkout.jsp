<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <title>Thanh toán - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="checkout-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-credit-card"></i> Thanh toán
                </h1>
                <p class="page-subtitle">Hoàn tất đơn hàng của bạn</p>
            </div>

            <div class="auth-container">
                <form method="post" class="auth-form">
                    <div class="form-group">
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email nhận hàng
                        </label>
                        <input type="email" id="email" name="email"
                               value="<%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "" %>"
                               placeholder="Nhập email nhận sản phẩm" required>
                    </div>

                    <div class="form-group">
                        <label for="payment">
                            <i class="fas fa-money-bill-wave"></i> Phương thức thanh toán
                        </label>
                        <select id="payment" name="payment" class="filter-select" style="border-radius: 12px;">
                            <option value="MOCK">Mock (thành công ngay)</option>
                            <option value="BANK">Chuyển khoản ngân hàng</option>
                            <option value="MOMO">Ví MoMo</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-auth">
                        <i class="fas fa-check-circle"></i> Xác nhận đặt hàng
                    </button>
                </form>

                <div class="auth-links">
                    <p><a href="<%=ctx%>/cart"><i class="fas fa-arrow-left"></i> Quay lại giỏ hàng</a></p>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
