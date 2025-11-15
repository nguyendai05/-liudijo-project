// ==================== Hero Slider - Premium Experience ====================
document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.hero-slider');
    if (!slider) return;

    const slides = document.querySelectorAll('.hero-slide');
    const dots = document.querySelectorAll('.dot');
    const prevBtn = document.querySelector('.hero-prev');
    const nextBtn = document.querySelector('.hero-next');

    let currentSlide = 0;
    const totalSlides = slides.length;
    let isTransitioning = false;

    // Function to show specific slide with smooth transition
    function showSlide(index) {
        if (isTransitioning) return;
        isTransitioning = true;

        // Ensure index is within bounds
        if (index >= totalSlides) {
            currentSlide = 0;
        } else if (index < 0) {
            currentSlide = totalSlides - 1;
        } else {
            currentSlide = index;
        }

        // Update slides with fade effect
        slides.forEach((slide, i) => {
            slide.classList.remove('active');
            if (i === currentSlide) {
                slide.classList.add('active');
                // Restart animations for active slide content
                restartAnimations(slide);
            }
        });

        // Update dots with morphing effect
        dots.forEach((dot, i) => {
            dot.classList.remove('active');
            if (i === currentSlide) {
                dot.classList.add('active');
            }
        });

        // Reset transition lock
        setTimeout(() => {
            isTransitioning = false;
        }, 800);
    }

    // Restart CSS animations for slide content
    function restartAnimations(slide) {
        const title = slide.querySelector('.hero-title');
        const subtitle = slide.querySelector('.hero-subtitle');
        const buttons = slide.querySelector('.hero-buttons');

        if (title) {
            title.style.animation = 'none';
            title.offsetHeight; // Trigger reflow
            title.style.animation = 'fadeInUp 0.8s ease-out';
        }

        if (subtitle) {
            subtitle.style.animation = 'none';
            subtitle.offsetHeight;
            subtitle.style.animation = 'fadeInUp 0.8s ease-out 0.2s both';
        }

        if (buttons) {
            buttons.style.animation = 'none';
            buttons.offsetHeight;
            buttons.style.animation = 'fadeInUp 0.8s ease-out 0.4s both';

            const primaryBtn = buttons.querySelector('.btn-primary');
            if (primaryBtn) {
                primaryBtn.style.animation = 'none';
                primaryBtn.offsetHeight;
                primaryBtn.style.animation = 'bounceIn 0.8s ease-out 0.6s both';
            }
        }
    }

    // Next slide
    function nextSlide() {
        showSlide(currentSlide + 1);
    }

    // Previous slide
    function prevSlide() {
        showSlide(currentSlide - 1);
    }

    // Event listeners for buttons with ripple effect
    if (nextBtn) {
        nextBtn.addEventListener('click', function(e) {
            createRipple(e, this);
            nextSlide();
        });
    }

    if (prevBtn) {
        prevBtn.addEventListener('click', function(e) {
            createRipple(e, this);
            prevSlide();
        });
    }

    // Ripple effect for buttons
    function createRipple(event, element) {
        const ripple = document.createElement('span');
        ripple.style.cssText = `
            position: absolute;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: scale(0);
            animation: rippleEffect 0.6s linear;
            pointer-events: none;
        `;

        const rect = element.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        ripple.style.width = ripple.style.height = `${size}px`;
        ripple.style.left = `${event.clientX - rect.left - size / 2}px`;
        ripple.style.top = `${event.clientY - rect.top - size / 2}px`;

        element.style.position = 'relative';
        element.style.overflow = 'hidden';
        element.appendChild(ripple);

        setTimeout(() => ripple.remove(), 600);
    }

    // Add ripple animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes rippleEffect {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);

    // Event listeners for dots
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            showSlide(index);
        });
    });

    // Auto play slider with intelligent pause
    let autoPlayInterval = setInterval(nextSlide, 5000);
    let isPaused = false;

    // Pause auto play on hover
    slider.addEventListener('mouseenter', () => {
        clearInterval(autoPlayInterval);
        isPaused = true;
    });

    // Resume auto play on mouse leave
    slider.addEventListener('mouseleave', () => {
        if (isPaused) {
            autoPlayInterval = setInterval(nextSlide, 5000);
            isPaused = false;
        }
    });

    // Pause when user interacts with controls
    [prevBtn, nextBtn, ...dots].forEach(el => {
        if (el) {
            el.addEventListener('click', () => {
                clearInterval(autoPlayInterval);
                autoPlayInterval = setInterval(nextSlide, 5000);
            });
        }
    });

    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft') {
            prevSlide();
            clearInterval(autoPlayInterval);
            autoPlayInterval = setInterval(nextSlide, 5000);
        } else if (e.key === 'ArrowRight') {
            nextSlide();
            clearInterval(autoPlayInterval);
            autoPlayInterval = setInterval(nextSlide, 5000);
        }
    });

    // Touch/Swipe support
    let touchStartX = 0;
    let touchEndX = 0;

    slider.addEventListener('touchstart', (e) => {
        touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });

    slider.addEventListener('touchend', (e) => {
        touchEndX = e.changedTouches[0].screenX;
        handleSwipe();
    }, { passive: true });

    function handleSwipe() {
        const swipeThreshold = 50;
        const diff = touchStartX - touchEndX;

        if (Math.abs(diff) > swipeThreshold) {
            if (diff > 0) {
                nextSlide();
            } else {
                prevSlide();
            }
            clearInterval(autoPlayInterval);
            autoPlayInterval = setInterval(nextSlide, 5000);
        }
    }
});

// ==================== Parallax Effect for Hero ====================
document.addEventListener('DOMContentLoaded', function() {
    const heroContent = document.querySelector('.hero-content');
    if (!heroContent) return;

    heroContent.classList.add('parallax');

    let ticking = false;

    function updateParallax() {
        const scrollY = window.scrollY;
        const heroSection = document.querySelector('.hero-section');
        if (!heroSection) return;

        const heroHeight = heroSection.offsetHeight;
        const scrollPercentage = Math.min(scrollY / heroHeight, 1);

        // Subtle parallax movement
        const translateY = scrollY * 0.3;
        const opacity = 1 - scrollPercentage * 0.5;

        heroContent.style.transform = `translateY(${translateY}px)`;
        heroContent.style.opacity = Math.max(opacity, 0.5);

        ticking = false;
    }

    window.addEventListener('scroll', () => {
        if (!ticking) {
            requestAnimationFrame(updateParallax);
            ticking = true;
        }
    }, { passive: true });
});

// ==================== Smooth Scroll with Easing ====================
document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('a[href^="#"]');

    links.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href === '#') return;

            const target = document.querySelector(href);
            if (target) {
                e.preventDefault();

                const targetPosition = target.getBoundingClientRect().top + window.pageYOffset;
                const startPosition = window.pageYOffset;
                const distance = targetPosition - startPosition;
                const duration = 1000;
                let start = null;

                // Easing function for smooth scroll
                function easeInOutCubic(t) {
                    return t < 0.5
                        ? 4 * t * t * t
                        : 1 - Math.pow(-2 * t + 2, 3) / 2;
                }

                function animation(currentTime) {
                    if (start === null) start = currentTime;
                    const timeElapsed = currentTime - start;
                    const progress = Math.min(timeElapsed / duration, 1);
                    const ease = easeInOutCubic(progress);

                    window.scrollTo(0, startPosition + distance * ease);

                    if (timeElapsed < duration) {
                        requestAnimationFrame(animation);
                    }
                }

                requestAnimationFrame(animation);
            }
        });
    });
});

// ==================== Advanced Scroll Animations ====================
document.addEventListener('DOMContentLoaded', function() {
    const observerOptions = {
        threshold: 0.15,
        rootMargin: '0px 0px -100px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const element = entry.target;

                // Add stagger delay for category cards
                if (element.classList.contains('category-card')) {
                    element.classList.add('animate');
                } else {
                    // For other elements, use standard animation
                    element.style.opacity = '0';
                    element.style.transform = 'translateY(30px)';

                    setTimeout(() => {
                        element.style.transition = 'opacity 0.7s cubic-bezier(0.4, 0, 0.2, 1), transform 0.7s cubic-bezier(0.4, 0, 0.2, 1)';
                        element.style.opacity = '1';
                        element.style.transform = 'translateY(0)';
                    }, 100);
                }

                observer.unobserve(element);
            }
        });
    }, observerOptions);

    // Observe elements with stagger effect
    const animatedElements = document.querySelectorAll('.category-card, .product-card, .feature-card, .testimonial-card');
    animatedElements.forEach(el => observer.observe(el));

    // Special animation for section headers
    const sectionHeaders = document.querySelectorAll('.section-header');
    sectionHeaders.forEach(header => {
        observer.observe(header);
    });
});

// ==================== Category Cards Stagger Animation ====================
document.addEventListener('DOMContentLoaded', function() {
    const categoryCards = document.querySelectorAll('.category-card');

    const categoryObserver = new IntersectionObserver((entries, observer) => {
        let delay = 0;
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('animate');
                }, delay);
                delay += 100; // 0.1s stagger
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.2,
        rootMargin: '0px 0px -50px 0px'
    });

    categoryCards.forEach(card => {
        card.style.opacity = '0';
        categoryObserver.observe(card);
    });
});

// ==================== Magnetic Button Effect ====================
document.addEventListener('DOMContentLoaded', function() {
    const magneticButtons = document.querySelectorAll('.hero-buttons .btn, .hero-prev, .hero-next');

    magneticButtons.forEach(btn => {
        btn.addEventListener('mousemove', function(e) {
            const rect = this.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;

            const strength = 0.15;
            this.style.transform = `translate(${x * strength}px, ${y * strength}px)`;
        });

        btn.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    });
});

// ==================== Number Counter Animation ====================
document.addEventListener('DOMContentLoaded', function() {
    const counters = document.querySelectorAll('[data-count]');

    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.getAttribute('data-count'));
                const duration = 2000;
                const increment = target / (duration / 16);
                let current = 0;

                const updateCounter = () => {
                    current += increment;
                    if (current < target) {
                        counter.textContent = Math.floor(current).toLocaleString('vi-VN');
                        requestAnimationFrame(updateCounter);
                    } else {
                        counter.textContent = target.toLocaleString('vi-VN');
                    }
                };

                updateCounter();
                counterObserver.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(counter => counterObserver.observe(counter));
});

// ==================== Update Cart Badge ====================
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
                // Add bounce animation when updated
                cartBadge.style.animation = 'none';
                cartBadge.offsetHeight;
                cartBadge.style.animation = 'pulse 0.5s ease';
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

// ==================== Preloader Animation ====================
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth page entrance
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease';

    setTimeout(() => {
        document.body.style.opacity = '1';
    }, 100);
});

// ==================== Scroll Progress Indicator ====================
document.addEventListener('DOMContentLoaded', function() {
    // Create progress bar element
    const progressBar = document.createElement('div');
    progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 0%;
        height: 3px;
        background: linear-gradient(90deg, #667eea, #764ba2);
        z-index: 9999;
        transition: width 0.1s ease;
    `;
    document.body.appendChild(progressBar);

    window.addEventListener('scroll', () => {
        const scrollTop = window.scrollY;
        const docHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrollPercent = (scrollTop / docHeight) * 100;
        progressBar.style.width = `${scrollPercent}%`;
    }, { passive: true });
});
