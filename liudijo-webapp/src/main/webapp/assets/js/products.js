// ==================== Products Page - Premium JavaScript ====================

// ==================== Sort Functionality ====================
function changeSort(value) {
    const url = new URL(window.location.href);
    url.searchParams.set('sort', value);
    url.searchParams.set('page', '1'); // Reset to first page when sorting

    // Add loading state
    showLoadingOverlay();

    window.location.href = url.toString();
}

// ==================== Clear Search ====================
function clearSearch() {
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.value = '';
        searchInput.focus();

        // Add clear animation
        searchInput.style.animation = 'none';
        searchInput.offsetHeight;
        searchInput.style.animation = 'clearPulse 0.3s ease';
    }
}

// ==================== Add to Cart with Animation ====================
function addToCart(productId) {
    // Get cart from localStorage
    let cart = JSON.parse(localStorage.getItem('cart') || '{}');

    // Add or update quantity
    if (cart[productId]) {
        cart[productId].quantity++;
    } else {
        cart[productId] = {
            id: productId,
            quantity: 1,
            addedAt: new Date().toISOString()
        };
    }

    // Save to localStorage
    localStorage.setItem('cart', JSON.stringify(cart));

    // Update cart badge with animation
    updateCartBadge();

    // Show success toast
    showToast('success', 'Thêm vào giỏ hàng thành công!', 'Sản phẩm đã được thêm vào giỏ hàng của bạn.');

    // Trigger custom event
    window.dispatchEvent(new CustomEvent('cartUpdated'));

    // Add button animation
    const button = event.currentTarget;
    button.classList.add('added');
    button.innerHTML = '<i class="fas fa-check"></i>';

    setTimeout(() => {
        button.classList.remove('added');
        button.innerHTML = '<i class="fas fa-cart-plus"></i>';
    }, 1500);
}

// ==================== Quick View Modal ====================
function quickView(productId) {
    const modal = document.getElementById('quickViewModal');
    if (!modal) return;

    // Show loading state in modal
    const modalContent = modal.querySelector('.modal-body');
    if (modalContent) {
        modalContent.innerHTML = `
            <div class="modal-loading">
                <div class="loading-spinner"></div>
                <p>Đang tải thông tin sản phẩm...</p>
            </div>
        `;
    }

    // Show modal with animation
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';

    // Fetch product details (simulated - replace with actual API call)
    setTimeout(() => {
        // In production, fetch from server
        // fetch(`${contextPath}/api/products/${productId}`)
        //     .then(response => response.json())
        //     .then(data => populateModal(data));

        // For now, show placeholder
        if (modalContent) {
            modalContent.innerHTML = `
                <div class="quick-view-content">
                    <div class="quick-view-image">
                        <div class="product-icon-large">
                            <i class="fas fa-box-open"></i>
                        </div>
                    </div>
                    <div class="quick-view-info">
                        <h3>Sản phẩm #${productId}</h3>
                        <p class="product-description">
                            Thông tin chi tiết về sản phẩm sẽ được hiển thị tại đây.
                            Bao gồm mô tả, đặc điểm, và các thông tin quan trọng khác.
                        </p>
                        <div class="quick-view-actions">
                            <button class="btn btn-primary" onclick="addToCart(${productId}); closeModal();">
                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                            </button>
                            <a href="${contextPath}/product/${productId}" class="btn btn-outline">
                                <i class="fas fa-info-circle"></i> Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            `;
        }
    }, 500);
}

// ==================== Close Modal ====================
function closeModal() {
    const modal = document.getElementById('quickViewModal');
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}

// ==================== Toast Notification System ====================
function showToast(type, title, message) {
    const container = document.getElementById('toastContainer');
    if (!container) return;

    // Create toast element
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;

    // Icon based on type
    let icon = 'fa-info-circle';
    if (type === 'success') icon = 'fa-check-circle';
    if (type === 'error') icon = 'fa-exclamation-circle';
    if (type === 'warning') icon = 'fa-exclamation-triangle';

    toast.innerHTML = `
        <div class="toast-icon">
            <i class="fas ${icon}"></i>
        </div>
        <div class="toast-content">
            <div class="toast-title">${title}</div>
            <div class="toast-message">${message}</div>
        </div>
        <button class="toast-close" onclick="this.parentElement.remove()">
            <i class="fas fa-times"></i>
        </button>
        <div class="toast-progress"></div>
    `;

    container.appendChild(toast);

    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 10);

    // Auto remove after 4 seconds
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 4000);
}

// ==================== Update Cart Badge ====================
function updateCartBadge() {
    const cartBadge = document.querySelector('.cart-badge');
    if (!cartBadge) return;

    try {
        const cart = JSON.parse(localStorage.getItem('cart') || '{}');
        const itemCount = Object.keys(cart).length;
        cartBadge.textContent = itemCount;

        if (itemCount > 0) {
            cartBadge.style.display = 'inline-block';
            // Add bounce animation
            cartBadge.style.animation = 'none';
            cartBadge.offsetHeight;
            cartBadge.style.animation = 'cartBounce 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
        } else {
            cartBadge.style.display = 'none';
        }
    } catch (e) {
        console.error('Error updating cart badge:', e);
        cartBadge.textContent = '0';
    }
}

// ==================== Show Loading Overlay ====================
function showLoadingOverlay() {
    const overlay = document.createElement('div');
    overlay.className = 'page-loading-overlay';
    overlay.innerHTML = `
        <div class="loading-content">
            <div class="loading-spinner-large"></div>
            <p>Đang tải...</p>
        </div>
    `;
    document.body.appendChild(overlay);

    setTimeout(() => overlay.classList.add('active'), 10);
}

// ==================== DOM Content Loaded ====================
document.addEventListener('DOMContentLoaded', function() {

    // ========== Initialize Cart Badge ==========
    updateCartBadge();

    // ========== Scroll Animations for Product Cards ==========
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const productObserver = new IntersectionObserver((entries) => {
        let delay = 0;
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }, delay);
                delay += 100; // Stagger effect
                productObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    const productCards = document.querySelectorAll('.product-card');
    productCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
        card.style.transition = 'opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1), transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
        productObserver.observe(card);
    });

    // ========== Filter Section Animations ==========
    const filtersSection = document.querySelector('.filters-section');
    if (filtersSection) {
        const filtersObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, { threshold: 0.3 });

        filtersObserver.observe(filtersSection);
    }

    // ========== Search Input Enhancement ==========
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        // Add focus animation
        searchInput.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });

        searchInput.addEventListener('blur', function() {
            this.parentElement.classList.remove('focused');
        });

        // Enter key to search
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const form = this.closest('form');
                if (form) form.submit();
            }
        });
    }

    // ========== Filter Button Hover Effects ==========
    const filterButtons = document.querySelectorAll('.filter-btn');
    filterButtons.forEach(btn => {
        btn.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });

        btn.addEventListener('mouseleave', function() {
            if (!this.classList.contains('active')) {
                this.style.transform = '';
            }
        });
    });

    // ========== Sort Dropdown Enhancement ==========
    const sortSelect = document.getElementById('sortSelect');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            this.style.animation = 'none';
            this.offsetHeight;
            this.style.animation = 'sortChange 0.3s ease';
        });
    }

    // ========== Active Filter Tags Animation ==========
    const filterTags = document.querySelectorAll('.active-filter-tag');
    filterTags.forEach((tag, index) => {
        tag.style.opacity = '0';
        tag.style.transform = 'scale(0.8)';

        setTimeout(() => {
            tag.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            tag.style.opacity = '1';
            tag.style.transform = 'scale(1)';
        }, index * 100);
    });

    // ========== Pagination Hover Effects ==========
    const paginationNums = document.querySelectorAll('.pagination-num');
    paginationNums.forEach(num => {
        num.addEventListener('mouseenter', function() {
            if (!this.classList.contains('active')) {
                this.style.transform = 'scale(1.1)';
            }
        });

        num.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    });

    // ========== Quick Action Buttons ==========
    const quickActions = document.querySelectorAll('.quick-actions .action-btn');
    quickActions.forEach(btn => {
        btn.addEventListener('click', function(e) {
            // Create ripple effect
            const ripple = document.createElement('span');
            ripple.className = 'ripple-effect';
            this.appendChild(ripple);

            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            ripple.style.width = ripple.style.height = `${size}px`;
            ripple.style.left = `${e.clientX - rect.left - size / 2}px`;
            ripple.style.top = `${e.clientY - rect.top - size / 2}px`;

            setTimeout(() => ripple.remove(), 600);
        });
    });

    // ========== Modal Close on Outside Click ==========
    const modal = document.getElementById('quickViewModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // Close on Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modal.classList.contains('active')) {
                closeModal();
            }
        });
    }

    // ========== Smooth Page Load Animation ==========
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease';

    setTimeout(() => {
        document.body.style.opacity = '1';
    }, 50);

    // ========== Breadcrumb Hover Animation ==========
    const breadcrumbLinks = document.querySelectorAll('.breadcrumb a');
    breadcrumbLinks.forEach(link => {
        link.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });

        link.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    });

    // ========== Page Header Animation ==========
    const pageHeader = document.querySelector('.page-header-section');
    if (pageHeader) {
        pageHeader.style.opacity = '0';
        pageHeader.style.transform = 'translateY(-20px)';

        setTimeout(() => {
            pageHeader.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
            pageHeader.style.opacity = '1';
            pageHeader.style.transform = 'translateY(0)';
        }, 100);
    }

    // ========== Empty State Animation ==========
    const emptyState = document.querySelector('.empty-state');
    if (emptyState) {
        const emptyIcon = emptyState.querySelector('.empty-icon');
        if (emptyIcon) {
            emptyIcon.style.animation = 'emptyFloat 3s ease-in-out infinite';
        }
    }

    // ========== Scroll to Top on New Search ==========
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('q') || urlParams.has('type') || urlParams.has('price')) {
        const resultsSection = document.querySelector('.page-header-section');
        if (resultsSection) {
            resultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    }

    // ========== View Toggle (Grid/List) ==========
    const viewBtns = document.querySelectorAll('.view-btn');
    viewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            viewBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            const view = this.getAttribute('data-view');
            const productsGrid = document.querySelector('.products-grid');

            if (productsGrid) {
                if (view === 'list') {
                    productsGrid.classList.add('list-view');
                } else {
                    productsGrid.classList.remove('list-view');
                }
            }
        });
    });

    // ========== Lazy Load Images ==========
    const productImages = document.querySelectorAll('.product-image img');
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.classList.add('loaded');
                    }
                    imageObserver.unobserve(img);
                }
            });
        });

        productImages.forEach(img => imageObserver.observe(img));
    }

    // ========== Product Card Hover State ==========
    productCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.zIndex = '10';
        });

        card.addEventListener('mouseleave', function() {
            setTimeout(() => {
                this.style.zIndex = '';
            }, 300);
        });
    });

});

// ==================== Additional CSS Animations ====================
const additionalStyles = document.createElement('style');
additionalStyles.textContent = `
    @keyframes clearPulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(0.98); }
    }

    @keyframes cartBounce {
        0% { transform: scale(1); }
        30% { transform: scale(1.3); }
        50% { transform: scale(0.9); }
        70% { transform: scale(1.15); }
        100% { transform: scale(1); }
    }

    @keyframes sortChange {
        0% { transform: scale(1); }
        50% { transform: scale(1.02); }
        100% { transform: scale(1); }
    }

    @keyframes emptyFloat {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-15px); }
    }

    .ripple-effect {
        position: absolute;
        background: rgba(255, 255, 255, 0.4);
        border-radius: 50%;
        transform: scale(0);
        animation: rippleAnimation 0.6s linear;
        pointer-events: none;
    }

    @keyframes rippleAnimation {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }

    .page-loading-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.9);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 10000;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .page-loading-overlay.active {
        opacity: 1;
    }

    .loading-content {
        text-align: center;
    }

    .loading-spinner-large {
        width: 50px;
        height: 50px;
        border: 4px solid #e2e8f0;
        border-top-color: var(--primary-color, #667eea);
        border-radius: 50%;
        animation: spin 0.8s linear infinite;
        margin: 0 auto 16px;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    .modal-loading {
        text-align: center;
        padding: 40px;
    }

    .loading-spinner {
        width: 40px;
        height: 40px;
        border: 3px solid #e2e8f0;
        border-top-color: var(--primary-color, #667eea);
        border-radius: 50%;
        animation: spin 0.8s linear infinite;
        margin: 0 auto 16px;
    }

    .quick-view-content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 32px;
        padding: 24px;
    }

    .product-icon-large {
        width: 200px;
        height: 200px;
        background: linear-gradient(135deg, var(--primary-color, #667eea), var(--secondary-color, #764ba2));
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
    }

    .product-icon-large i {
        font-size: 80px;
        color: white;
    }

    .quick-view-info h3 {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 16px;
        color: #1a202c;
    }

    .product-description {
        color: #4a5568;
        line-height: 1.6;
        margin-bottom: 24px;
    }

    .quick-view-actions {
        display: flex;
        gap: 12px;
    }

    .quick-view-actions .btn {
        padding: 12px 24px;
        border-radius: 8px;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .quick-view-actions .btn-primary {
        background: linear-gradient(135deg, var(--primary-color, #667eea), var(--secondary-color, #764ba2));
        color: white;
        border: none;
    }

    .quick-view-actions .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    }

    .quick-view-actions .btn-outline {
        background: transparent;
        color: var(--primary-color, #667eea);
        border: 2px solid var(--primary-color, #667eea);
        text-decoration: none;
    }

    .quick-view-actions .btn-outline:hover {
        background: var(--primary-color, #667eea);
        color: white;
    }

    .action-btn.added {
        background: #48bb78 !important;
        transform: scale(1.1);
    }

    @media (max-width: 768px) {
        .quick-view-content {
            grid-template-columns: 1fr;
            gap: 24px;
        }

        .product-icon-large {
            width: 150px;
            height: 150px;
        }

        .product-icon-large i {
            font-size: 60px;
        }
    }
`;
document.head.appendChild(additionalStyles);
