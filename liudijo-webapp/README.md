# Liudijo Web Application

Liudijo là một nền tảng web cho phép mua bán tài khoản game trực tuyến một cách an toàn và đáng tin cậy.

## Công nghệ sử dụng

- **Backend**: Java Servlet & JSP
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0+
- **Java Version**: 11+

## Tính năng chính

### Người dùng (Customer)
- Đăng ký/Đăng nhập tài khoản
- Xem danh sách sản phẩm (tài khoản game)
- Tìm kiếm và lọc sản phẩm theo danh mục
- Đặt hàng và thanh toán
- Theo dõi trạng thái đơn hàng
- Quản lý thông tin cá nhân

### Quản trị viên (Admin)
- Dashboard tổng quan
- Quản lý sản phẩm (CRUD)
- Quản lý đơn hàng
- Quản lý người dùng
- Thống kê tồn kho theo danh mục

## Cấu trúc dự án

```
liudijo-webapp/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/liudijo/
│       │       ├── controller/        # Servlet controllers
│       │       ├── service/          # Business logic
│       │       ├── repository/       # Database access
│       │       ├── model/            # Entity models
│       │       ├── filter/           # Authentication filters
│       │       └── util/             # Utility classes
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml
│           │   └── views/            # JSP files
│           └── assets/
│               ├── css/              # Stylesheets
│               ├── js/               # JavaScript files
│               └── images/           # Static images
├── database/
│   └── schema.sql                    # Database schema
└── pom.xml                           # Maven configuration
```

## Cài đặt và chạy dự án

### 1. Yêu cầu hệ thống

- JDK 11 hoặc cao hơn
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.0+

### 2. Cấu hình Database

```bash
# Tạo database và import schema
mysql -u root -p < database/schema.sql
```

Cấu hình kết nối database trong `src/main/java/com/liudijo/util/DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/liudijo_db";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

### 3. Build dự án

```bash
cd liudijo-webapp
mvn clean install
```

### 4. Deploy lên Tomcat

Có 2 cách deploy:

**Cách 1: Deploy file WAR**
```bash
# Sau khi build, copy file WAR vào thư mục webapps của Tomcat
cp target/liudijo-webapp.war $TOMCAT_HOME/webapps/
```

**Cách 2: Sử dụng Maven Tomcat Plugin**
```bash
mvn tomcat7:deploy
```

### 5. Truy cập ứng dụng

- URL: `http://localhost:8080/liudijo-webapp`
- Admin login:
  - Username: `admin`
  - Password: `admin123`

## Cấu hình Email (Optional)

Để kích hoạt tính năng gửi email, cập nhật thông tin trong `src/main/java/com/liudijo/util/EmailUtil.java`:

```java
private static final String SMTP_USERNAME = "your-email@gmail.com";
private static final String SMTP_PASSWORD = "your-app-password";
```

## API Endpoints

### Public Endpoints
- `GET /` - Trang chủ
- `GET /products` - Danh sách sản phẩm
- `GET /login` - Trang đăng nhập
- `POST /login` - Xử lý đăng nhập
- `GET /register` - Trang đăng ký

### Customer Endpoints (Yêu cầu đăng nhập)
- `GET /customer/dashboard` - Dashboard khách hàng
- `GET /checkout` - Trang thanh toán
- `POST /checkout` - Xử lý đặt hàng

### Admin Endpoints (Yêu cầu quyền admin)
- `GET /admin/dashboard` - Dashboard quản trị
- `GET /admin/products` - Quản lý sản phẩm
- `POST /admin/products` - Thêm/Sửa/Xóa sản phẩm

## Database Schema

### Bảng Users
- id, username, email, password, full_name, phone, role, active, created_at, updated_at

### Bảng Products
- id, name, description, category, price, rank, server, champion_count, skin_count, image_url, status, created_at, updated_at

### Bảng Orders
- id, user_id, product_id, total_amount, payment_method, payment_status, order_status, delivery_email, delivery_phone, note, created_at, updated_at

## Bảo mật

- Mật khẩu được mã hóa bằng BCrypt
- Session-based authentication
- CSRF protection (nên implement thêm)
- SQL Injection prevention (sử dụng PreparedStatement)
- XSS protection (JSP escaping)

## Phát triển tiếp

Các tính năng có thể bổ sung:
- [ ] Tích hợp payment gateway thực tế (VNPay, MoMo)
- [ ] Upload ảnh sản phẩm
- [ ] Đánh giá và nhận xét sản phẩm
- [ ] Chat support
- [ ] Quản lý inventory tự động
- [ ] REST API cho mobile app
- [ ] OAuth2 authentication

## Liên hệ

- Email: support@liudijo.com
- Website: https://liudijo.com

## License

Copyright © 2024 Liudijo. All rights reserved.
