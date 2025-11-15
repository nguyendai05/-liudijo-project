<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Giỏ hàng - liudijo</title>
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

<h1>Giỏ hàng</h1>
<table class="table">
  <thead><tr><th>Sản phẩm</th><th>SL</th><th>Giá</th><th>Tổng</th><th></th></tr></thead>
  <tbody>
  <%
    java.util.Map<Long, com.liudijo.model.CartItem> cart =
      (java.util.Map<Long, com.liudijo.model.CartItem>) session.getAttribute("CART");
    java.math.BigDecimal total = java.math.BigDecimal.ZERO;
    if (cart != null) for (com.liudijo.model.CartItem ci : cart.values()) {
      total = total.add(ci.getSubtotal());
  %>
    <tr>
      <td><%= ci.getName() %></td>
      <td>
        <form method="post" action="<%=ctx%>/cart">
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="productId" value="<%= ci.getProductId() %>">
          <input type="number" name="qty" min="1" value="<%= ci.getQuantity() %>">
          <button>Cập nhật</button>
        </form>
      </td>
      <td><%= ci.getPrice() %></td>
      <td><%= ci.getSubtotal() %></td>
      <td>
        <form method="post" action="<%=ctx%>/cart">
          <input type="hidden" name="action" value="remove">
          <input type="hidden" name="productId" value="<%= ci.getProductId() %>">
          <button>Xoá</button>
        </form>
      </td>
    </tr>
  <% } %>
  </tbody>
</table>
<p><strong>Tổng cộng:</strong> <%= total %> ₫</p>
<p><a class="btn" href="<%=ctx%>/checkout">Thanh toán</a></p>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>