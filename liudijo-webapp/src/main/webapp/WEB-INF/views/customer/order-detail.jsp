<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Chi tiết đơn hàng - liudijo</title>
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

<% com.liudijo.model.Order o = (com.liudijo.model.Order) request.getAttribute("order"); %>
<h1>Đơn hàng #<%= o.getOrderId() %></h1>
<p>Trạng thái: <%= o.getStatus() %> / Thanh toán: <%= o.getPaymentStatus() %> / Tổng: <%= o.getTotal() %> ₫</p>
<% if ("PAID".equals(o.getPaymentStatus()) || "PAID".equals(o.getStatus())) { %>
<h2>Thông tin bàn giao</h2>
<ul>
<% java.util.List<String> secrets = (java.util.List<String>) request.getAttribute("secrets");
   if (secrets != null) for (String s : secrets) { %>
  <li><code><%= s %></code></li>
<% } %>
</ul>
<% } else { %>
<p>Đơn chưa thanh toán, chưa thể hiển thị thông tin.</p>
<% } %>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>