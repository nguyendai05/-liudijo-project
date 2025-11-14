-- Liudijo Database Schema
-- Create database
CREATE DATABASE IF NOT EXISTS liudijo_db;
USE liudijo_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role ENUM('ADMIN', 'CUSTOMER') DEFAULT 'CUSTOMER',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    category ENUM('LMHT', 'LQMB', 'FREEFIRE', 'OTHER') NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rank VARCHAR(50),
    server VARCHAR(50),
    champion_count INT,
    skin_count INT,
    image_url VARCHAR(500),
    status ENUM('AVAILABLE', 'SOLD', 'RESERVED') DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_price (price)
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('BANK_TRANSFER', 'MOMO', 'VNPAY') NOT NULL,
    payment_status ENUM('PENDING', 'PAID', 'FAILED') DEFAULT 'PENDING',
    order_status ENUM('PENDING', 'PROCESSING', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    delivery_email VARCHAR(100) NOT NULL,
    delivery_phone VARCHAR(20) NOT NULL,
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_product_id (product_id),
    INDEX idx_payment_status (payment_status),
    INDEX idx_order_status (order_status)
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, full_name, role, active)
VALUES ('admin', 'admin@liudijo.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYCj.Pq9xOK', 'Administrator', 'ADMIN', TRUE);

-- Insert sample products
INSERT INTO products (name, description, category, price, rank, server, champion_count, skin_count, image_url, status) VALUES
('Tài khoản LMHT #1', 'Tài khoản Liên Minh Huyền Thoại rank Kim Cương', 'LMHT', 2000000, 'Kim Cương', 'VN', 150, 80, '/assets/images/products/lmht1.jpg', 'AVAILABLE'),
('Tài khoản LMHT #2', 'Tài khoản Liên Minh Huyền Thoại rank Bạch Kim', 'LMHT', 1500000, 'Bạch Kim', 'VN', 120, 50, '/assets/images/products/lmht2.jpg', 'AVAILABLE'),
('Tài khoản LQMB #1', 'Tài khoản Liên Quân Mobile rank Cao Thủ', 'LQMB', 1000000, 'Cao Thủ', 'Việt Nam', 80, 40, '/assets/images/products/lqmb1.jpg', 'AVAILABLE'),
('Tài khoản Free Fire #1', 'Tài khoản Free Fire level cao', 'FREEFIRE', 500000, 'Heroic', 'VN', 0, 30, '/assets/images/products/ff1.jpg', 'AVAILABLE');
