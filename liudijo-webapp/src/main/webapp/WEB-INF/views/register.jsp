<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <title>Đăng ký - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="auth-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-user-plus"></i> Đăng ký
                </h1>
                <p class="page-subtitle">Tạo tài khoản mới để bắt đầu mua sắm</p>
            </div>

            <div class="auth-container">
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form method="post" action="<%=ctx%>/auth/register" class="auth-form">
                    <div class="form-group">
                        <label for="name">
                            <i class="fas fa-user"></i> Họ tên
                        </label>
                        <input type="text" id="name" name="name" placeholder="Nhập họ tên của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" id="email" name="email" placeholder="Nhập email của bạn" required>
                    </div>

                    <div class="form-group">
                        <label for="password">
                            <i class="fas fa-lock"></i> Mật khẩu
                        </label>
                        <input type="password" id="password" name="password" placeholder="Tạo mật khẩu mạnh" required>
                    </div>

                    <button type="submit" class="btn btn-auth">
                        <i class="fas fa-user-plus"></i> Tạo tài khoản
                    </button>
                </form>

                <div class="auth-links">
                    <p>Đã có tài khoản? <a href="<%=ctx%>/auth/login">Đăng nhập ngay</a></p>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
