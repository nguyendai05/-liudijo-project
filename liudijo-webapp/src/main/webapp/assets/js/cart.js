// Cart specific JavaScript

document.addEventListener('DOMContentLoaded', function() {
    updateCartTotal();
    initCartActions();
});

// Update cart total
function updateCartTotal() {
    const cartItems = document.querySelectorAll('.cart-item');
    let total = 0;

    cartItems.forEach(item => {
        const priceElement = item.querySelector('.price');
        if (priceElement) {
            const price = parseFloat(priceElement.textContent.replace(/[^\d]/g, ''));
            total += price;
        }
    });

    const totalElement = document.querySelector('.cart-total');
    if (totalElement) {
        totalElement.textContent = formatCurrency(total);
    }
}

// Initialize cart actions
function initCartActions() {
    // Remove item buttons
    const removeButtons = document.querySelectorAll('.btn-remove');
    removeButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                e.preventDefault();
            }
        });
    });

    // Update quantity
    const quantityInputs = document.querySelectorAll('.quantity-input');
    quantityInputs.forEach(input => {
        input.addEventListener('change', function() {
            updateItemTotal(this);
        });
    });
}

// Update individual item total
function updateItemTotal(input) {
    const cartItem = input.closest('.cart-item');
    const price = parseFloat(cartItem.dataset.price);
    const quantity = parseInt(input.value);
    const total = price * quantity;

    const totalElement = cartItem.querySelector('.item-total');
    if (totalElement) {
        totalElement.textContent = formatCurrency(total);
    }

    updateCartTotal();
}

// Proceed to checkout
function proceedToCheckout() {
    const cartItems = document.querySelectorAll('.cart-item');

    if (cartItems.length === 0) {
        alert('Giỏ hàng của bạn đang trống');
        return false;
    }

    return true;
}

// Format currency (if not available from main.js)
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}
