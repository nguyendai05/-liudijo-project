<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liudijo.model.Product" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - Liudijo</title>
    <% String ctx = request.getContextPath(); %>
    <%
        String currentType = request.getParameter("type") != null ? request.getParameter("type") : "";
        String currentQuery = request.getParameter("q") != null ? request.getParameter("q") : "";
        String currentSort = request.getParameter("sort") != null ? request.getParameter("sort") : "newest";
        String currentPage = request.getParameter("page") != null ? request.getParameter("page") : "1";
        String currentPrice = request.getParameter("price") != null ? request.getParameter("price") : "";

        List<Product> products = (List<Product>) request.getAttribute("products");
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        Integer totalProducts = (Integer) request.getAttribute("totalProducts");
        if (totalProducts == null) totalProducts = products != null ? products.size() : 0;

        int pageNum = 1;
        try { pageNum = Integer.parseInt(currentPage); } catch(Exception e) {}
        int totalPages = (int) Math.ceil(totalProducts / 24.0);
        if (totalPages < 1) totalPages = 1;
    %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/css/style.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/css/products.css">
</head>
<body class="products-page">
    <!-- Header -->
    <header class="site-header">
        <div class="container">
            <div class="header-content">
                <a class="logo" href="<%=ctx%>/">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Liudijo</span>
                </a>

                <nav class="main-nav">
                    <a href="<%=ctx%>/">Trang chủ</a>
                    <a href="<%=ctx%>/products" class="active">Sản phẩm</a>
                    <a href="<%=ctx%>/products?type=ACCOUNT">Tài khoản</a>
                    <a href="<%=ctx%>/products?type=KEY">Key phần mềm</a>
                    <a href="<%=ctx%>/products?type=SERVICE">Dịch vụ</a>
                </nav>

                <div class="header-actions">
                    <a href="<%=ctx%>/cart" class="cart-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="cart-badge">0</span>
                    </a>

                    <% if (session.getAttribute("user") != null) { %>
                        <a href="<%=ctx%>/customer/dashboard" class="btn-account">
                            <i class="fas fa-user"></i> Tài khoản
                        </a>
                    <% } else { %>
                        <a href="<%=ctx%>/auth/login" class="btn-login">Đăng nhập</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Breadcrumb -->
    <section class="breadcrumb-section">
        <div class="container">
            <nav class="breadcrumb">
                <a href="<%=ctx%>/"><i class="fas fa-home"></i> Trang chủ</a>
                <i class="fas fa-chevron-right"></i>
                <span class="current">Sản phẩm</span>
                <% if (!currentType.isEmpty()) { %>
                    <i class="fas fa-chevron-right"></i>
                    <span class="current">
                        <% if ("ACCOUNT".equals(currentType)) { %>Tài khoản<% }
                           else if ("KEY".equals(currentType)) { %>Key phần mềm<% }
                           else if ("SERVICE".equals(currentType)) { %>Dịch vụ<% } %>
                    </span>
                <% } %>
            </nav>
        </div>
    </section>

    <!-- Page Header -->
    <section class="page-header-section">
        <div class="container">
            <div class="page-header-content">
                <div class="page-title-wrapper">
                    <h1 class="page-title">
                        <i class="fas fa-th-large"></i>
                        <% if ("ACCOUNT".equals(currentType)) { %>
                            Tài khoản
                        <% } else if ("KEY".equals(currentType)) { %>
                            Key phần mềm
                        <% } else if ("SERVICE".equals(currentType)) { %>
                            Dịch vụ
                        <% } else { %>
                            Tất cả sản phẩm
                        <% } %>
                    </h1>
                    <p class="page-subtitle">
                        Hiển thị <strong><%= totalProducts %></strong> sản phẩm
                        <% if (!currentQuery.isEmpty()) { %>
                            cho "<strong><%= currentQuery %></strong>"
                        <% } %>
                    </p>
                </div>
                <div class="view-options">
                    <button class="view-btn active" data-view="grid" title="Dạng lưới">
                        <i class="fas fa-th-large"></i>
                    </button>
                    <button class="view-btn" data-view="list" title="Dạng danh sách">
                        <i class="fas fa-list"></i>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Filters & Search Bar -->
    <section class="filters-section">
        <div class="container">
            <div class="filters-bar">
                <!-- Search -->
                <div class="search-wrapper">
                    <form action="<%=ctx%>/products" method="get" class="search-form-products" id="searchForm">
                        <input type="hidden" name="type" value="<%= currentType %>">
                        <input type="hidden" name="sort" value="<%= currentSort %>">
                        <input type="hidden" name="price" value="<%= currentPrice %>">
                        <div class="search-input-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="search" name="q" placeholder="Tìm kiếm sản phẩm..."
                                   value="<%= currentQuery %>" class="search-input">
                            <% if (!currentQuery.isEmpty()) { %>
                                <button type="button" class="clear-search" onclick="clearSearch()">
                                    <i class="fas fa-times"></i>
                                </button>
                            <% } %>
                        </div>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </form>
                </div>

                <!-- Filter Options -->
                <div class="filter-options">
                    <!-- Type Filter -->
                    <div class="filter-group">
                        <label class="filter-label">Loại sản phẩm</label>
                        <div class="filter-buttons">
                            <a href="<%=ctx%>/products?q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>"
                               class="filter-btn <%= currentType.isEmpty() ? "active" : "" %>">
                                <i class="fas fa-th-large"></i> Tất cả
                            </a>
                            <a href="<%=ctx%>/products?type=ACCOUNT&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>"
                               class="filter-btn <%= "ACCOUNT".equals(currentType) ? "active" : "" %>">
                                <i class="fas fa-user-circle"></i> Tài khoản
                            </a>
                            <a href="<%=ctx%>/products?type=KEY&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>"
                               class="filter-btn <%= "KEY".equals(currentType) ? "active" : "" %>">
                                <i class="fas fa-key"></i> Key phần mềm
                            </a>
                            <a href="<%=ctx%>/products?type=SERVICE&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>"
                               class="filter-btn <%= "SERVICE".equals(currentType) ? "active" : "" %>">
                                <i class="fas fa-cog"></i> Dịch vụ
                            </a>
                        </div>
                    </div>

                    <!-- Price Filter -->
                    <div class="filter-group">
                        <label class="filter-label">Khoảng giá</label>
                        <div class="filter-buttons">
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>"
                               class="filter-btn <%= currentPrice.isEmpty() ? "active" : "" %>">
                                Tất cả
                            </a>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=0-50000"
                               class="filter-btn <%= "0-50000".equals(currentPrice) ? "active" : "" %>">
                                &lt; 50K
                            </a>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=50000-100000"
                               class="filter-btn <%= "50000-100000".equals(currentPrice) ? "active" : "" %>">
                                50K - 100K
                            </a>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=100000-200000"
                               class="filter-btn <%= "100000-200000".equals(currentPrice) ? "active" : "" %>">
                                100K - 200K
                            </a>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=200000-"
                               class="filter-btn <%= "200000-".equals(currentPrice) ? "active" : "" %>">
                                &gt; 200K
                            </a>
                        </div>
                    </div>

                    <!-- Sort Options -->
                    <div class="filter-group">
                        <label class="filter-label">Sắp xếp theo</label>
                        <div class="sort-dropdown">
                            <select id="sortSelect" class="sort-select" onchange="changeSort(this.value)">
                                <option value="newest" <%= "newest".equals(currentSort) ? "selected" : "" %>>Mới nhất</option>
                                <option value="price_asc" <%= "price_asc".equals(currentSort) ? "selected" : "" %>>Giá tăng dần</option>
                                <option value="price_desc" <%= "price_desc".equals(currentSort) ? "selected" : "" %>>Giá giảm dần</option>
                                <option value="name_asc" <%= "name_asc".equals(currentSort) ? "selected" : "" %>>Tên A-Z</option>
                                <option value="bestseller" <%= "bestseller".equals(currentSort) ? "selected" : "" %>>Bán chạy</option>
                            </select>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                    </div>
                </div>

                <!-- Active Filters -->
                <% if (!currentType.isEmpty() || !currentQuery.isEmpty() || !currentPrice.isEmpty()) { %>
                <div class="active-filters">
                    <span class="active-filters-label">Đang lọc:</span>
                    <% if (!currentType.isEmpty()) { %>
                        <span class="active-filter-tag">
                            <% if ("ACCOUNT".equals(currentType)) { %>Tài khoản<% }
                               else if ("KEY".equals(currentType)) { %>Key phần mềm<% }
                               else if ("SERVICE".equals(currentType)) { %>Dịch vụ<% } %>
                            <a href="<%=ctx%>/products?q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>" class="remove-filter">
                                <i class="fas fa-times"></i>
                            </a>
                        </span>
                    <% } %>
                    <% if (!currentQuery.isEmpty()) { %>
                        <span class="active-filter-tag">
                            "<%= currentQuery %>"
                            <a href="<%=ctx%>/products?type=<%= currentType %>&sort=<%= currentSort %>&price=<%= currentPrice %>" class="remove-filter">
                                <i class="fas fa-times"></i>
                            </a>
                        </span>
                    <% } %>
                    <% if (!currentPrice.isEmpty()) { %>
                        <span class="active-filter-tag">
                            <% if ("0-50000".equals(currentPrice)) { %>&lt; 50K<% }
                               else if ("50000-100000".equals(currentPrice)) { %>50K - 100K<% }
                               else if ("100000-200000".equals(currentPrice)) { %>100K - 200K<% }
                               else if ("200000-".equals(currentPrice)) { %>&gt; 200K<% } %>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>" class="remove-filter">
                                <i class="fas fa-times"></i>
                            </a>
                        </span>
                    <% } %>
                    <a href="<%=ctx%>/products" class="clear-all-filters">
                        <i class="fas fa-times-circle"></i> Xóa tất cả
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Products Grid -->
    <main class="products-main">
        <div class="container">
            <% if (products != null && !products.isEmpty()) { %>
            <div class="products-grid" id="productsGrid">
                <% for (Product product : products) {
                    String productUrl = ctx + "/product-detail?slug=" + product.getSlug();
                    boolean hasSale = product.getSalePrice() != null &&
                                    product.getSalePrice().compareTo(product.getPrice()) < 0;
                %>
                <div class="product-card premium animate-on-scroll">
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

                        <!-- Quick Actions -->
                        <div class="product-quick-actions">
                            <button class="quick-action-btn" onclick="quickView(<%= product.getProductId() %>)" title="Xem nhanh">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="quick-action-btn" onclick="addToCart(<%= product.getProductId() %>)" title="Thêm vào giỏ">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
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
                            <button type="button" class="btn btn-add-cart" onclick="addToCart(<%= product.getProductId() %>)">
                                <i class="fas fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination -->
            <% if (totalPages > 1) { %>
            <div class="pagination-wrapper">
                <nav class="pagination">
                    <% if (pageNum > 1) { %>
                        <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>&page=<%= pageNum - 1 %>"
                           class="pagination-btn prev">
                            <i class="fas fa-chevron-left"></i> Trước
                        </a>
                    <% } %>

                    <div class="pagination-numbers">
                        <%
                        int startPage = Math.max(1, pageNum - 2);
                        int endPage = Math.min(totalPages, pageNum + 2);

                        if (startPage > 1) { %>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>&page=1"
                               class="pagination-num">1</a>
                            <% if (startPage > 2) { %>
                                <span class="pagination-dots">...</span>
                            <% } %>
                        <% }

                        for (int i = startPage; i <= endPage; i++) { %>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>&page=<%= i %>"
                               class="pagination-num <%= i == pageNum ? "active" : "" %>"><%= i %></a>
                        <% }

                        if (endPage < totalPages) {
                            if (endPage < totalPages - 1) { %>
                                <span class="pagination-dots">...</span>
                            <% } %>
                            <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>&page=<%= totalPages %>"
                               class="pagination-num"><%= totalPages %></a>
                        <% } %>
                    </div>

                    <% if (pageNum < totalPages) { %>
                        <a href="<%=ctx%>/products?type=<%= currentType %>&q=<%= currentQuery %>&sort=<%= currentSort %>&price=<%= currentPrice %>&page=<%= pageNum + 1 %>"
                           class="pagination-btn next">
                            Sau <i class="fas fa-chevron-right"></i>
                        </a>
                    <% } %>
                </nav>
                <p class="pagination-info">
                    Trang <strong><%= pageNum %></strong> / <strong><%= totalPages %></strong>
                </p>
            </div>
            <% } %>

            <% } else { %>
            <!-- Empty State -->
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h2 class="empty-state-title">Không tìm thấy sản phẩm</h2>
                <p class="empty-state-desc">
                    <% if (!currentQuery.isEmpty()) { %>
                        Không có sản phẩm nào phù hợp với từ khóa "<strong><%= currentQuery %></strong>"
                    <% } else { %>
                        Không có sản phẩm nào trong danh mục này
                    <% } %>
                </p>
                <div class="empty-state-actions">
                    <a href="<%=ctx%>/products" class="btn btn-view-all">
                        <i class="fas fa-th-large"></i> Xem tất cả sản phẩm
                    </a>
                    <a href="<%=ctx%>/" class="btn btn-outline-primary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </div>
            </div>
            <% } %>
        </div>
    </main>

    <!-- Toast Notification -->
    <div class="toast-container" id="toastContainer"></div>

    <!-- Quick View Modal -->
    <div class="modal-overlay" id="quickViewModal">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal()">
                <i class="fas fa-times"></i>
            </button>
            <div class="modal-body" id="quickViewContent">
                <!-- Content loaded via JavaScript -->
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="site-footer premium">
        <div class="footer-wave"></div>
        <div class="container">
            <div class="footer-content">
                <div class="footer-col about">
                    <div class="footer-logo">
                        <i class="fas fa-shopping-bag"></i>
                        <span>Liudijo</span>
                    </div>
                    <p class="footer-desc">
                        Nền tảng bán hàng số uy tín hàng đầu Việt Nam.
                        Cung cấp tài khoản, key phần mềm và dịch vụ online chất lượng.
                    </p>
                    <div class="social-links">
                        <a href="#" class="social-link facebook" aria-label="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link twitter" aria-label="Twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="social-link instagram" aria-label="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="social-link youtube" aria-label="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">
                        <i class="fas fa-box"></i> Sản phẩm
                    </h3>
                    <ul class="footer-links">
                        <li><a href="<%=ctx%>/products?type=ACCOUNT"><i class="fas fa-chevron-right"></i> Tài khoản</a></li>
                        <li><a href="<%=ctx%>/products?type=KEY"><i class="fas fa-chevron-right"></i> Key phần mềm</a></li>
                        <li><a href="<%=ctx%>/products?type=SERVICE"><i class="fas fa-chevron-right"></i> Dịch vụ</a></li>
                        <li><a href="<%=ctx%>/products"><i class="fas fa-chevron-right"></i> Tất cả sản phẩm</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">
                        <i class="fas fa-life-ring"></i> Hỗ trợ
                    </h3>
                    <ul class="footer-links">
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Hướng dẫn mua hàng</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Chính sách bảo mật</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Điều khoản sử dụng</a></li>
                        <li><a href="#"><i class="fas fa-chevron-right"></i> Liên hệ</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">
                        <i class="fas fa-credit-card"></i> Thanh toán
                    </h3>
                    <div class="payment-methods premium">
                        <div class="payment-icon" title="Visa">
                            <i class="fab fa-cc-visa"></i>
                        </div>
                        <div class="payment-icon" title="Mastercard">
                            <i class="fab fa-cc-mastercard"></i>
                        </div>
                        <div class="payment-icon" title="Bank Transfer">
                            <i class="fas fa-university"></i>
                        </div>
                        <div class="payment-icon" title="MoMo">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                    </div>
                    <p class="payment-note">
                        <i class="fas fa-lock"></i> Thanh toán an toàn & bảo mật
                    </p>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="footer-bottom-content">
                    <p class="copyright">&copy; 2024 Liudijo. All rights reserved.</p>
                    <p class="made-with">
                        Made with <i class="fas fa-heart"></i> in Vietnam
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <script src="<%=ctx%>/assets/js/main.js"></script>
    <script src="<%=ctx%>/assets/js/products.js"></script>
    <script>
        // Pass context path to JavaScript
        const contextPath = '<%=ctx%>';
        const currentParams = {
            type: '<%= currentType %>',
            q: '<%= currentQuery %>',
            sort: '<%= currentSort %>',
            price: '<%= currentPrice %>',
            page: '<%= currentPage %>'
        };
    </script>
</body>
</html>
