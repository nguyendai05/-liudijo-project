<%@ page contentType="text/html; charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>
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
