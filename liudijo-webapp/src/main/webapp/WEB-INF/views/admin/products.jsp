<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin - Sản phẩm - liudijo</title>
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

<h1>Quản lý sản phẩm</h1>
<form method="post">
  <label>Tên <input name="name" required></label>
  <label>Slug <input name="slug" required></label>
  <label>Loại
    <select name="type">
      <option>ACCOUNT</option><option>KEY</option><option>SERVICE</option>
    </select>
  </label>
  <label>Giá <input name="price" type="number" step="1000" required></label>
  <button class="btn">+ Thêm</button>
</form>
<hr>
<table class="table">
  <thead><tr><th>ID</th><th>Tên</th><th>Slug</th><th>Loại</th><th>Giá</th></tr></thead>
  <tbody>
  <% java.util.List<com.liudijo.model.Product> ps = (java.util.List<com.liudijo.model.Product>) request.getAttribute("products");
     if (ps != null) for (com.liudijo.model.Product p : ps) { %>
    <tr>
      <td><%= p.getProductId() %></td>
      <td><%= p.getName() %></td>
      <td><%= p.getSlug() %></td>
      <td><%= p.getType() %></td>
      <td><%= p.getPrice() %> ₫</td>
    </tr>
  <% } %>
  </tbody>
</table>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>