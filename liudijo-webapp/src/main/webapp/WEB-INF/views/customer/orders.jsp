<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Đơn hàng - liudijo</title>
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

<h1>Đơn hàng của bạn</h1>
<table class="table">
  <thead><tr><th>ID</th><th>Trạng thái</th><th>Thanh toán</th><th>Tổng</th><th></th></tr></thead>
  <tbody>
  <% java.util.List<com.liudijo.model.Order> list = (java.util.List<com.liudijo.model.Order>) request.getAttribute("orders");
     if (list != null) for (com.liudijo.model.Order o : list) { %>
    <tr>
      <td>#<%= o.getOrderId() %></td>
      <td><%= o.getStatus() %></td>
      <td><%= o.getPaymentStatus() %></td>
      <td><%= o.getTotal() %> ₫</td>
      <td><a href="<%=ctx%>/account/orders/<%=o.getOrderId()%>">Chi tiết</a></td>
    </tr>
  <% } %>
  </tbody>
</table>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>