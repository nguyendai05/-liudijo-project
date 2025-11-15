<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <title>Đăng nhập - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="auth-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                </h1>
                <p class="page-subtitle">Chào mừng bạn quay trở lại</p>
            </div>

            <div class="auth-container">
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                <form method="post" action="<%=ctx%>/auth/login" class="auth-form">
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
                        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
                    </div>

                    <button type="submit" class="btn btn-auth">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </button>
                </form>

                <div class="auth-links">
                    <p>Chưa có tài khoản? <a href="<%=ctx%>/auth/register">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
