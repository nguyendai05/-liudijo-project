<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liudijo.model.Product" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <% String ctx = request.getContextPath(); %>
    <%@ include file="includes/head.jsp" %>
    <title>Sản phẩm - Liudijo</title>
</head>
<body>
    <%@ include file="includes/header.jsp" %>

    <main class="products-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-bag"></i> Danh sách sản phẩm
                </h1>
                <p class="page-subtitle">Khám phá các sản phẩm số chất lượng cao</p>
            </div>

            <div class="filters-section">
                <form class="filters-form" method="get">
                    <div class="filter-group">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="search" name="q" placeholder="Tìm kiếm sản phẩm..."
                                   value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>"
                                   class="filter-input">
                        </div>
                    </div>
                    <div class="filter-group">
                        <select name="type" class="filter-select">
                            <option value="">Tất cả loại</option>
                            <option value="ACCOUNT" <%= "ACCOUNT".equals(request.getParameter("type"))?"selected":"" %>>
                                Tài khoản
                            </option>
                            <option value="KEY" <%= "KEY".equals(request.getParameter("type"))?"selected":"" %>>
                                Key phần mềm
                            </option>
                            <option value="SERVICE" <%= "SERVICE".equals(request.getParameter("type"))?"selected":"" %>>
                                Dịch vụ
                            </option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-filter">
                        <i class="fas fa-filter"></i> Lọc
                    </button>
                </form>
            </div>

            <div class="products-grid">
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                            String productUrl = ctx + "/product-detail?slug=" + product.getSlug();
                            boolean hasSale = product.getSalePrice() != null &&
                                            product.getSalePrice().compareTo(product.getPrice()) < 0;
                %>
                <div class="product-card premium">
                    <% if (hasSale) { %>
                    <div class="product-badge sale">
                        <i class="fas fa-bolt"></i> SALE
                    </div>
                    <% } %>

                    <div class="product-image">
                        <div class="product-icon-wrapper">
                            <% if ("ACCOUNT".equals(product.getType())) { %>
                                <i class="fas fa-user-circle"></i>
                            <% } else if ("KEY".equals(product.getType())) { %>
                                <i class="fas fa-key"></i>
                            <% } else { %>
                                <i class="fas fa-cog"></i>
                            <% } %>
                        </div>
                        <div class="product-image-overlay"></div>
                    </div>

                    <div class="product-info">
                        <span class="product-type-badge">
                            <% if ("ACCOUNT".equals(product.getType())) { %>
                                <i class="fas fa-user"></i> Tài khoản
                            <% } else if ("KEY".equals(product.getType())) { %>
                                <i class="fas fa-key"></i> Key phần mềm
                            <% } else { %>
                                <i class="fas fa-cog"></i> Dịch vụ
                            <% } %>
                        </span>
                        <h3 class="product-name">
                            <a href="<%=productUrl%>"><%=product.getName()%></a>
                        </h3>

                        <div class="product-price">
                            <% if (hasSale) { %>
                                <span class="price-sale"><%=currencyFormat.format(product.getSalePrice())%></span>
                                <span class="price-original"><%=currencyFormat.format(product.getPrice())%></span>
                            <% } else { %>
                                <span class="price-current"><%=currencyFormat.format(product.getPrice())%></span>
                            <% } %>
                        </div>

                        <div class="product-actions">
                            <a href="<%=productUrl%>" class="btn btn-view-detail">
                                <i class="fas fa-eye"></i> Chi tiết
                            </a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="no-products">
                    <i class="fas fa-box-open"></i>
                    <p>Chưa có sản phẩm nào</p>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script src="<%=ctx%>/assets/js/main.js"></script>
</body>
</html>
