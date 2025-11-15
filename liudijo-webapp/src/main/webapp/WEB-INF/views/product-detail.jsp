<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chi tiết sản phẩm - liudijo</title>
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

<% com.liudijo.model.Product p = (com.liudijo.model.Product) request.getAttribute("product"); %>
<% if (p == null) { %>
  <h1>Không tìm thấy sản phẩm</h1>
<% } else { %>
<article class="product-detail">
  <h1><%= p.getName() %></h1>
  <p>Loại: <%= p.getType() %></p>
  <p>Giá: <strong><%= p.getSalePrice()!=null?p.getSalePrice():p.getPrice() %> ₫</strong></p>
  <form action="<%=ctx%>/cart" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
    <label>Số lượng <input type="number" name="qty" value="1" min="1"></label>
    <button class="btn">Thêm vào giỏ</button>
  </form>
</article>
<% } %>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>