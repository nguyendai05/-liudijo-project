<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="admin-container">
        <aside class="sidebar">
            <h2>Admin Panel</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products" class="active">Quản lý sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a></li>
                <li><a href="${pageContext.request.contextPath}/">Về trang chủ</a></li>
            </ul>
        </aside>

        <main class="admin-content">
            <div class="content-header">
                <h2>Quản lý sản phẩm</h2>
                <button class="btn btn-primary" onclick="showAddProductForm()">Thêm sản phẩm mới</button>
            </div>

            <div id="addProductForm" class="modal" style="display:none;">
                <div class="modal-content">
                    <span class="close" onclick="hideAddProductForm()">&times;</span>
                    <h3>Thêm sản phẩm mới</h3>
                    <form method="post" action="${pageContext.request.contextPath}/admin/products">
                        <input type="hidden" name="action" value="create">

                        <div class="form-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="name" required>
                        </div>

                        <div class="form-group">
                            <label>Mô tả:</label>
                            <textarea name="description" rows="3" required></textarea>
                        </div>

                        <div class="form-group">
                            <label>Danh mục:</label>
                            <select name="category" required>
                                <option value="LMHT">Liên Minh Huyền Thoại</option>
                                <option value="LQMB">Liên Quân Mobile</option>
                                <option value="FREEFIRE">Free Fire</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Giá (VNĐ):</label>
                            <input type="number" name="price" required>
                        </div>

                        <div class="form-group">
                            <label>Rank:</label>
                            <input type="text" name="rank" required>
                        </div>

                        <div class="form-group">
                            <label>Server:</label>
                            <input type="text" name="server" required>
                        </div>

                        <div class="form-group">
                            <label>Số tướng:</label>
                            <input type="number" name="championCount" required>
                        </div>

                        <div class="form-group">
                            <label>Số skin:</label>
                            <input type="number" name="skinCount" required>
                        </div>

                        <div class="form-group">
                            <label>URL ảnh:</label>
                            <input type="text" name="imageUrl" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </form>
                </div>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Danh mục</th>
                        <th>Giá</th>
                        <th>Rank</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>${product.category}</td>
                            <td>${product.price} VNĐ</td>
                            <td>${product.rank}</td>
                            <td>
                                <span class="status-badge status-${product.status}">
                                    ${product.status}
                                </span>
                            </td>
                            <td>
                                <button class="btn-small btn-edit" onclick="editProduct(${product.id})">Sửa</button>
                                <form method="post" action="${pageContext.request.contextPath}/admin/products" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn-small btn-delete" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
