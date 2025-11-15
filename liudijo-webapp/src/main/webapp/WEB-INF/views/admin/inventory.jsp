<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin - Kho stock - liudijo</title>
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

<h1>Kho stock</h1>
<form method="post">
  <label>Product ID <input type="number" name="productId" required></label>
  <label>Type
    <select name="type"><option>ACCOUNT</option><option>KEY</option></select>
  </label>
  <label>Secret (username:pass hoặc key) <textarea name="secret" rows="3" required></textarea></label>
  <label>Meta (JSON) <textarea name="meta" rows="3"></textarea></label>
  <button class="btn">+ Thêm</button>
</form>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>