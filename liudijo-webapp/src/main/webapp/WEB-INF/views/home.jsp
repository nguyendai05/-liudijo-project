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
    <title>Liudijo - Nền tảng bán hàng số #1 Việt Nam</title>
    <% String ctx = request.getContextPath(); %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/css/style.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/css/home.css">
</head>
<body>
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
                    <a href="<%=ctx%>/products">Sản phẩm</a>
                    <a href="<%=ctx%>/products?type=ACCOUNT">Tài khoản</a>
                    <a href="<%=ctx%>/products?type=KEY">Key phần mềm</a>
                    <a href="<%=ctx%>/products?type=SERVICE">Dịch vụ</a>
                </nav>

                <div class="header-actions">
                    <form action="<%=ctx%>/products" method="get" class="search-form">
                        <input type="search" name="q" placeholder="Tìm kiếm sản phẩm..." class="search-input">
                        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                    </form>

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

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-slider">
            <div class="hero-slide active" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">Nền tảng bán hàng số #1 Việt Nam</h1>
                        <p class="hero-subtitle">Mua tài khoản, key phần mềm, dịch vụ online - Giao hàng tức thì, uy tín, bảo mật</p>
                        <div class="hero-buttons">
                            <a href="<%=ctx%>/products" class="btn btn-primary btn-lg">
                                <i class="fas fa-rocket"></i> Khám phá ngay
                            </a>
                            <a href="#features" class="btn btn-secondary btn-lg">
                                <i class="fas fa-info-circle"></i> Tìm hiểu thêm
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hero-slide" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">Ưu đãi cực khủng</h1>
                        <p class="hero-subtitle">Giảm giá lên đến 50% cho tất cả sản phẩm - Chỉ trong tuần này!</p>
                        <div class="hero-buttons">
                            <a href="<%=ctx%>/products" class="btn btn-primary btn-lg">
                                <i class="fas fa-tags"></i> Xem ưu đãi
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hero-slide" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">Giao hàng tức thì 24/7</h1>
                        <p class="hero-subtitle">Nhận sản phẩm ngay sau khi thanh toán - Hỗ trợ 24/7</p>
                        <div class="hero-buttons">
                            <a href="<%=ctx%>/products" class="btn btn-primary btn-lg">
                                <i class="fas fa-bolt"></i> Mua ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <button class="hero-prev"><i class="fas fa-chevron-left"></i></button>
        <button class="hero-next"><i class="fas fa-chevron-right"></i></button>

        <div class="hero-dots">
            <span class="dot active" data-slide="0"></span>
            <span class="dot" data-slide="1"></span>
            <span class="dot" data-slide="2"></span>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Danh mục sản phẩm</h2>
                <p class="section-subtitle">Chọn danh mục bạn quan tâm</p>
            </div>

            <div class="categories-grid">
                <a href="<%=ctx%>/products?type=ACCOUNT" class="category-card">
                    <div class="category-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <h3 class="category-name">Tài khoản</h3>
                    <p class="category-desc">Netflix, Spotify, Game...</p>
                    <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                </a>

                <a href="<%=ctx%>/products?type=KEY" class="category-card">
                    <div class="category-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                        <i class="fas fa-key"></i>
                    </div>
                    <h3 class="category-name">Key phần mềm</h3>
                    <p class="category-desc">Windows, Office, Adobe...</p>
                    <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                </a>

                <a href="<%=ctx%>/products?type=SERVICE" class="category-card">
                    <div class="category-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                        <i class="fas fa-cog"></i>
                    </div>
                    <h3 class="category-name">Dịch vụ</h3>
                    <p class="category-desc">Hosting, VPS, Email...</p>
                    <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                </a>

                <a href="<%=ctx%>/products" class="category-card">
                    <div class="category-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
                        <i class="fas fa-fire"></i>
                    </div>
                    <h3 class="category-name">Hot Deals</h3>
                    <p class="category-desc">Giảm giá đặc biệt</p>
                    <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section class="products-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Sản phẩm nổi bật</h2>
                <p class="section-subtitle">Những sản phẩm được yêu thích nhất</p>
            </div>

            <div class="products-grid">
                <%
                    List<Product> featuredProducts = (List<Product>) request.getAttribute("featuredProducts");
                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

                    if (featuredProducts != null && !featuredProducts.isEmpty()) {
                        for (Product product : featuredProducts) {
                            String productUrl = ctx + "/product-detail?slug=" + product.getSlug();
                            boolean hasSale = product.getSalePrice() != null &&
                                            product.getSalePrice().compareTo(product.getPrice()) < 0;
                %>
                <div class="product-card">
                    <% if (hasSale) { %>
                    <div class="product-badge sale">Sale</div>
                    <% } %>

                    <div class="product-image">
                        <div class="product-icon">
                            <% if ("ACCOUNT".equals(product.getType())) { %>
                                <i class="fas fa-user-circle"></i>
                            <% } else if ("KEY".equals(product.getType())) { %>
                                <i class="fas fa-key"></i>
                            <% } else { %>
                                <i class="fas fa-cog"></i>
                            <% } %>
                        </div>
                    </div>

                    <div class="product-info">
                        <span class="product-type">
                            <% if ("ACCOUNT".equals(product.getType())) { %>
                                Tài khoản
                            <% } else if ("KEY".equals(product.getType())) { %>
                                Key phần mềm
                            <% } else { %>
                                Dịch vụ
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
                            <a href="<%=productUrl%>" class="btn btn-primary btn-sm">
                                <i class="fas fa-eye"></i> Xem chi tiết
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

            <div class="section-footer">
                <a href="<%=ctx%>/products" class="btn btn-outline btn-lg">
                    Xem tất cả sản phẩm <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="features-section" id="features">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Tại sao chọn Liudijo?</h2>
                <p class="section-subtitle">Những lý do khách hàng tin tưởng chúng tôi</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3 class="feature-title">Giao hàng tức thì</h3>
                    <p class="feature-desc">Nhận sản phẩm ngay sau khi thanh toán thành công. Tự động 100% không cần chờ đợi.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Bảo mật tuyệt đối</h3>
                    <p class="feature-desc">Thông tin khách hàng được mã hóa và bảo mật ở mức cao nhất. An toàn 100%.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3 class="feature-title">Hỗ trợ 24/7</h3>
                    <p class="feature-desc">Đội ngũ hỗ trợ luôn sẵn sàng giải đáp mọi thắc mắc của bạn mọi lúc mọi nơi.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3 class="feature-title">Giá cả cạnh tranh</h3>
                    <p class="feature-desc">Cam kết giá tốt nhất thị trường với nhiều chương trình ưu đãi hấp dẫn.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Khách hàng nói gì về chúng tôi</h2>
                <p class="section-subtitle">Hơn 10,000+ khách hàng hài lòng</p>
            </div>

            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Dịch vụ tuyệt vời! Giao hàng nhanh chóng, sản phẩm chất lượng.
                        Tôi đã mua Netflix và nhận được tài khoản ngay lập tức. Rất hài lòng!"
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4 class="author-name">Nguyễn Văn A</h4>
                            <p class="author-role">Khách hàng thân thiết</p>
                        </div>
                    </div>
                </div>

                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Giá cả hợp lý, hỗ trợ nhiệt tình. Mình đã mua Windows key và
                        được hướng dẫn kích hoạt rất chi tiết. Sẽ quay lại ủng hộ!"
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4 class="author-name">Trần Thị B</h4>
                            <p class="author-role">Khách hàng mới</p>
                        </div>
                    </div>
                </div>

                <div class="testimonial-card">
                    <div class="testimonial-rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="testimonial-text">
                        "Uy tín và chuyên nghiệp! Đã mua nhiều lần và luôn hài lòng.
                        Website dễ sử dụng, thanh toán nhanh gọn. Highly recommended!"
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4 class="author-name">Lê Văn C</h4>
                            <p class="author-role">Khách hàng VIP</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title">Sẵn sàng bắt đầu?</h2>
                <p class="cta-subtitle">Tham gia cùng hàng ngàn khách hàng đã tin tưởng Liudijo</p>
                <a href="<%=ctx%>/products" class="btn btn-primary btn-lg">
                    <i class="fas fa-rocket"></i> Mua sắm ngay
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="site-footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-col">
                    <h3 class="footer-title">Về Liudijo</h3>
                    <p class="footer-desc">
                        Nền tảng bán hàng số uy tín hàng đầu Việt Nam.
                        Cung cấp tài khoản, key phần mềm và dịch vụ online chất lượng.
                    </p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">Sản phẩm</h3>
                    <ul class="footer-links">
                        <li><a href="<%=ctx%>/products?type=ACCOUNT">Tài khoản</a></li>
                        <li><a href="<%=ctx%>/products?type=KEY">Key phần mềm</a></li>
                        <li><a href="<%=ctx%>/products?type=SERVICE">Dịch vụ</a></li>
                        <li><a href="<%=ctx%>/products">Tất cả sản phẩm</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">Hỗ trợ</h3>
                    <ul class="footer-links">
                        <li><a href="#">Hướng dẫn mua hàng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Liên hệ</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h3 class="footer-title">Thanh toán</h3>
                    <div class="payment-methods">
                        <div class="payment-icon"><i class="fab fa-cc-visa"></i></div>
                        <div class="payment-icon"><i class="fab fa-cc-mastercard"></i></div>
                        <div class="payment-icon"><i class="fas fa-university"></i></div>
                        <div class="payment-icon"><i class="fas fa-mobile-alt"></i></div>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2024 Liudijo. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="<%=ctx%>/assets/js/main.js"></script>
    <script src="<%=ctx%>/assets/js/home.js"></script>
</body>
</html>
