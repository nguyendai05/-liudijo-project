// Admin panel JavaScript

document.addEventListener('DOMContentLoaded', function() {
    initAdminActions();
    initModals();
});

// Initialize admin actions
function initAdminActions() {
    // Confirm delete actions
    const deleteButtons = document.querySelectorAll('.btn-delete');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc muốn xóa mục này?')) {
                e.preventDefault();
            }
        });
    });

    // Order status update
    const statusSelects = document.querySelectorAll('.status-select');
    statusSelects.forEach(select => {
        select.addEventListener('change', function() {
            updateOrderStatus(this);
        });
    });
}

// Initialize modals
function initModals() {
    const modals = document.querySelectorAll('.modal');

    modals.forEach(modal => {
        const closeBtn = modal.querySelector('.close');
        if (closeBtn) {
            closeBtn.addEventListener('click', function() {
                modal.style.display = 'none';
            });
        }

        window.addEventListener('click', function(e) {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    });
}

// Show add product form
function showAddProductForm() {
    const modal = document.getElementById('addProductForm');
    if (modal) {
        modal.style.display = 'flex';
    }
}

// Hide add product form
function hideAddProductForm() {
    const modal = document.getElementById('addProductForm');
    if (modal) {
        modal.style.display = 'none';
    }
}

// Edit product
function editProduct(productId) {
    // In a real application, this would fetch product data and show edit form
    alert('Chức năng chỉnh sửa sản phẩm #' + productId);
}

// Update order status
function updateOrderStatus(selectElement) {
    const orderId = selectElement.dataset.orderId;
    const newStatus = selectElement.value;

    if (!confirm('Cập nhật trạng thái đơn hàng?')) {
        return;
    }

    // Send AJAX request to update order status
    fetch('/admin/orders/update-status', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `orderId=${orderId}&status=${newStatus}`
    })
    .then(response => {
        if (response.ok) {
            alert('Đã cập nhật trạng thái');
            location.reload();
        } else {
            alert('Có lỗi xảy ra');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Có lỗi xảy ra');
    });
}

// Delete user
function deleteUser(userId) {
    if (!confirm('Bạn có chắc muốn xóa người dùng này?')) {
        return false;
    }
    return true;
}

// Toggle user status
function toggleUserStatus(userId) {
    if (!confirm('Thay đổi trạng thái người dùng?')) {
        return false;
    }
    return true;
}

// Statistics chart (if using Chart.js)
function initCharts() {
    const chartElement = document.getElementById('salesChart');
    if (chartElement) {
        // Initialize chart here
        console.log('Chart initialized');
    }
}

// Export data
function exportData(type) {
    alert('Xuất dữ liệu ' + type);
    // Implement export functionality
}

// Search and filter
function initSearch() {
    const searchInput = document.querySelector('.admin-search');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(function() {
            filterTable(this.value);
        }, 300));
    }
}

function filterTable(searchTerm) {
    const rows = document.querySelectorAll('.admin-table tbody tr');
    searchTerm = searchTerm.toLowerCase();

    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchTerm) ? '' : 'none';
    });
}

// Debounce function
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}
