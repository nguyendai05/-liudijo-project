<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sản phẩm - liudijo</title>
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

<h1>Danh sách sản phẩm</h1>
<form class="filters" method="get">
  <input type="search" name="q" placeholder="Tìm..." value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">
  <select name="type">
    <option value="">Tất cả</option>
    <option <%= "ACCOUNT".equals(request.getParameter("type"))?"selected":"" %>>ACCOUNT</option>
    <option <%= "KEY".equals(request.getParameter("type"))?"selected":"" %>>KEY</option>
    <option <%= "SERVICE".equals(request.getParameter("type"))?"selected":"" %>>SERVICE</option>
  </select>
  <button type="submit">Lọc</button>
</form>
<div class="grid">
  <% java.util.List<com.liudijo.model.Product> ps = (java.util.List<com.liudijo.model.Product>) request.getAttribute("products");
     if (ps != null) for (com.liudijo.model.Product p : ps) { %>
    <article class="card">
      <h3><a href="<%=ctx%>/product/<%=p.getSlug()%>"><%= p.getName() %></a></h3>
      <div class="price"><%= p.getSalePrice()!=null?p.getSalePrice():p.getPrice() %> ₫</div>
      <form method="post" action="<%=ctx%>/cart">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
        <input type="hidden" name="qty" value="1">
        <button class="btn">Thêm vào giỏ</button>
      </form>
    </article>
  <% } %>
</div>

</main>
<script src="<%=ctx%>/assets/js/main.js"></script>
</body></html>