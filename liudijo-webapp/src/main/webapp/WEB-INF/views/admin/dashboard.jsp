<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Liudijo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="admin-container">
        <aside class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                <li><a href="${pageContext.request.contextPath}/">Về trang chủ</a></li>
            </ul>
        </aside>

        <main class="admin-content">
            <h2>Dashboard</h2>

            <div class="stats-grid">
                <div class="stat-card">
                    <h3>Tài khoản khả dụng</h3>
                    <p class="stat-number">${stockStats.available}</p>
                </div>
                <div class="stat-card">
                    <h3>Đã bán</h3>
                    <p class="stat-number">${stockStats.sold}</p>
                </div>
                <div class="stat-card">
                    <h3>Tổng đơn hàng</h3>
                    <p class="stat-number">${recentOrders.size()}</p>
                </div>
            </div>

            <section class="recent-orders">
                <h3>Đơn hàng gần đây</h3>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th>Ngày</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${recentOrders}" begin="0" end="9">
                            <tr>
                                <td>#${order.id}</td>
                                <td>${order.username}</td>
                                <td>${order.productName}</td>
                                <td>${order.totalAmount} VNĐ</td>
                                <td>
                                    <span class="status-badge status-${order.orderStatus}">
                                        ${order.orderStatus}
                                    </span>
                                </td>
                                <td>${order.createdAt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>

            <section class="stock-by-category">
                <h3>Tồn kho theo danh mục</h3>
                <div class="category-stats">
                    <c:forEach var="category" items="${stockStats.byCategory}">
                        <div class="category-stat">
                            <h4>${category.key}</h4>
                            <p>${category.value} tài khoản</p>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
