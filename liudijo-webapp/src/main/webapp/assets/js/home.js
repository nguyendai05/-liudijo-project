// Hero Slider
document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.hero-slider');
    if (!slider) return;

    const slides = document.querySelectorAll('.hero-slide');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.hero-prev');
    const nextBtn = document.querySelector('.hero-next');

    let currentSlide = 0;
    const totalSlides = slides.length;

    // Function to show specific slide
    function showSlide(index) {
        // Ensure index is within bounds
        if (index >= totalSlides) {
            currentSlide = 0;
        } else if (index < 0) {
            currentSlide = totalSlides - 1;
        } else {
            currentSlide = index;
        }

        // Update slides
        slides.forEach((slide, i) => {
            slide.classList.remove('active');
            if (i === currentSlide) {
                slide.classList.add('active');
            }
        });

        // Update dots
        dots.forEach((dot, i) => {
            dot.classList.remove('active');
            if (i === currentSlide) {
                dot.classList.add('active');
            }
        });
    }

    // Next slide
    function nextSlide() {
        showSlide(currentSlide + 1);
    }

    // Previous slide
    function prevSlide() {
        showSlide(currentSlide - 1);
    }

    // Event listeners for buttons
    if (nextBtn) {
        nextBtn.addEventListener('click', nextSlide);
    }

    if (prevBtn) {
        prevBtn.addEventListener('click', prevSlide);
    }

    // Event listeners for dots
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            showSlide(index);
        });
    });

    // Auto play slider
    let autoPlayInterval = setInterval(nextSlide, 5000);

    // Pause auto play on hover
    slider.addEventListener('mouseenter', () => {
        clearInterval(autoPlayInterval);
    });

    // Resume auto play on mouse leave
    slider.addEventListener('mouseleave', () => {
        autoPlayInterval = setInterval(nextSlide, 5000);
    });

    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft') {
            prevSlide();
        } else if (e.key === 'ArrowRight') {
            nextSlide();
        }
    });
});

// Smooth scroll for anchor links
document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('a[href^="#"]');

    links.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href === '#') return;

            const target = document.querySelector(href);
            if (target) {
                e.preventDefault();
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Add animation on scroll
document.addEventListener('DOMContentLoaded', function() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '0';
                entry.target.style.transform = 'translateY(20px)';

                setTimeout(() => {
                    entry.target.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }, 100);

                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Observe elements
    const animatedElements = document.querySelectorAll('.category-card, .product-card, .feature-card, .testimonial-card');
    animatedElements.forEach(el => observer.observe(el));
});

// Update cart badge from localStorage
document.addEventListener('DOMContentLoaded', function() {
    function updateCartBadge() {
        const cartBadge = document.querySelector('.cart-badge');
        if (!cartBadge) return;

        try {
            const cart = JSON.parse(localStorage.getItem('cart') || '{}');
            const itemCount = Object.keys(cart).length;
            cartBadge.textContent = itemCount;

            if (itemCount > 0) {
                cartBadge.style.display = 'inline-block';
            } else {
                cartBadge.style.display = 'none';
            }
        } catch (e) {
            console.error('Error updating cart badge:', e);
            cartBadge.textContent = '0';
        }
    }

    // Update on page load
    updateCartBadge();

    // Update when storage changes
    window.addEventListener('storage', updateCartBadge);

    // Custom event for cart updates
    window.addEventListener('cartUpdated', updateCartBadge);
});
