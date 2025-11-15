<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Thanh toán - liudijo</title>
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

<h1>Thanh toán</h1>
<form method="post">
  <label>Email <input name="email" type="email" value="<%= session.getAttribute("userEmail") %>" required></label>
  <label>Phương thức
    <select name="payment">
      <option value="MOCK">Mock (thành công ngay)</option>
      <option value="BANK">Chuyển khoản</option>
    </select>
  </label>
  <button class="btn">Đặt hàng</button>
</form>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>