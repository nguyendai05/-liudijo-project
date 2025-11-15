<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Trang chủ - liudijo</title>
<% String ctx = request.getContextPath(); %>
<link rel="stylesheet" href="<%=ctx%>/assets/css/style.css">
</head><body>
<header class="site-header">
  <a class="logo" href="<%=ctx%>/"><img src="<%=ctx%>/assets/images/logo.png" alt="liudijo" height="28"></a>
  <nav class="nav">
    <a href="<%=ctx%>/products">Sản phẩm</a>
    <a href="<%=ctx%>/cart">Giỏ hàng</a>
    <a href="<%=ctx%>/auth/login">Đăng nhập</a>
  </nav>
</header>
<main class="container">

<section class="hero">
  <h1>liudijo – Digital goods in minutes</h1>
  <p>Mua tài khoản, key phần mềm, dịch vụ online – giao ngay.</p>
  <p><a class="btn" href="<%=ctx%>/products">Xem sản phẩm</a></p>
</section>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>