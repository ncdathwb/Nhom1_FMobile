
let listCartHTML = document.querySelector('.listCart');
let iconCart = document.querySelector('.icon-cart');
let iconCartSpan = document.querySelector('.icon-cart span');
let body = document.querySelector('body');
let closeCart = document.querySelector('.close');
let cart = [];
let allProducts = [];

document.addEventListener('DOMContentLoaded', () => {
    initApp();
});

iconCart.addEventListener('click', () => {
    body.classList.toggle('showCart');
    loadProductsFromSession();
    updateCartHTML();
});

closeCart.addEventListener('click', () => {
    body.classList.toggle('showCart');
});

const initApp = () => {
    loadCartFromSession();
    loadProductsFromSession();
    fetchProducts();
    addEventToButtons();
    updateCartHTML();

    const checkoutButton = document.querySelector('.checkOut');
    if (checkoutButton) {
        checkoutButton.addEventListener('click', () => {
            if (cart.length > 0) {
                proceedToCheckout();
            } else {
                showNotification("Giỏ hàng của bạn đang trống!", "#FFA500");
            }
        });
    }
}

// Lắng nghe sự kiện BUY NOW khi DOM đã tải xong
document.addEventListener('DOMContentLoaded', function() {
    const buyNowButtons = document.querySelectorAll('.buyNow');

    buyNowButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            const productId = this.closest('.item').getAttribute('data-id');
            window.location.href = '/client/checkout?productId=' + productId;
        });
    });
});

const saveCartToSession = () => {
    sessionStorage.setItem('cart', JSON.stringify(cart));
}

const loadCartFromSession = () => {
    const savedCart = sessionStorage.getItem('cart');
    if (savedCart) {
        cart = JSON.parse(savedCart);
        updateCartDisplay(cart.reduce((sum, item) => sum + item.quantity, 0));
    }
}

const saveProductsToSession = () => {
    sessionStorage.setItem('allProducts', JSON.stringify(allProducts));
}

const loadProductsFromSession = () => {
    const savedProducts = sessionStorage.getItem('allProducts');
    if (savedProducts) {
        allProducts = JSON.parse(savedProducts);
    }
}

const fetchProducts = () => {
    const productElements = document.querySelectorAll('.item');
    if (productElements.length > 0) {
        allProducts = Array.from(productElements).map(element => ({
            id: element.getAttribute('data-id'),
            productName: element.querySelector('h2').textContent,
            price: parseFloat(element.querySelector('.price').textContent.replace('$', '')),
            image: element.querySelector('img').src
        }));
        saveProductsToSession();
    } else {
        loadProductsFromSession();
    }
    console.log('Fetched products:', allProducts);
}

const addEventToButtons = () => {
    document.body.addEventListener('click', (e) => {
        if (e.target.classList.contains('addCart')) {
            const productId = e.target.closest('.item').getAttribute('data-id');
            addToCart(productId);
        }
    });
}

const addToCart = (productId) => {
    let product = findProductById(productId);
    if (product) {
        let existingItem = cart.find(item => item.id == productId);
        if (existingItem) {
            existingItem.quantity += 1;
            showNotification("Số lượng sản phẩm đã được cập nhật", "#4CAF50");
        } else {
            cart.push({
                ...product,
                quantity: 1
            });
            showNotification("Sản phẩm đã được thêm vào giỏ hàng thành công", "#4CAF50");
        }
        updateCartHTML();
        saveCartToSession();
    } else {
        console.error('Product not found:', productId);
        showNotification("Không tìm thấy sản phẩm", "#FF0000");
    }
}

const updateCartHTML = () => {
    listCartHTML.innerHTML = '';
    let totalQuantity = 0;
    let totalAmount = 0;

    if (cart.length > 0) {
        cart.forEach(item => {
            totalQuantity += item.quantity;
            let newItem = document.createElement('div');
            newItem.classList.add('item');
            newItem.dataset.id = item.id;

            let itemTotal = item.price * item.quantity;
            totalAmount += itemTotal;
            newItem.innerHTML = `
                <div class="image">
                    <img src="${item.image}">
                </div>
                <div class="name">
                    ${item.productName}
                </div>
                <div class="totalPrice">$${itemTotal.toFixed(2)}</div>
                <div class="quantity">
                    <span class="minus">-</span>
                    <span>${item.quantity}</span>
                    <span class="plus">+</span>
                </div>
                <div class="remove">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                width="20" height="20" fill="none" viewBox="0 0 24 24">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M6 18 17.94 6M18 18 6.06 6" />
                </svg>
                </div>
            `;
            listCartHTML.appendChild(newItem);

            newItem.querySelector('.remove').addEventListener('click', () => removeFromCart(item.id));
            newItem.querySelector('.minus').addEventListener('click', () => updateQuantity(item.id, -1));
            newItem.querySelector('.plus').addEventListener('click', () => updateQuantity(item.id, 1));
        });
    }
    updateCartDisplay(totalQuantity);
    document.querySelector('.totalAmount').innerText = `$${totalAmount.toFixed(2)}`;
}

const updateCartDisplay = (totalQuantity) => {
    iconCartSpan.innerText = totalQuantity;
    iconCartSpan.classList.toggle('visible', totalQuantity > 0);
    iconCartSpan.classList.add('animate');
    setTimeout(() => {
        iconCartSpan.classList.remove('animate');
    }, 300);
}

const findProductById = (id) => {
    return allProducts.find(product => product.id == id);
}

const removeFromCart = (productId) => {
    cart = cart.filter(item => item.id != productId);
    updateCartHTML();
    saveCartToSession();
}

const updateQuantity = (productId, change) => {
    const item = cart.find(item => item.id == productId);
    if (item) {
        item.quantity += change;
        if (item.quantity < 1) {
            removeFromCart(productId);
        } else {
            updateCartHTML();
            saveCartToSession();
        }
    }
}

const showNotification = (message, backgroundColor = "#4CAF50") => {
    let notification = document.createElement('div');
    notification.textContent = message;
    notification.style.cssText = `
    position: fixed;
    top: 10%;
    left: 0px;
    background-color: ${backgroundColor};
    color: white;
    padding: 15px;
    border-radius: 4px;
    z-index: 1000;
    width: 13%;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center; 
`;

    document.body.appendChild(notification);
    setTimeout(() => {
        document.body.removeChild(notification);
    }, 1500);
}

const proceedToCheckout = () => {
    const form = document.createElement('form');
    form.method = 'GET';
    form.action = '/checkout';

    cart.forEach(item => {
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'productId[]';
        idInput.value = item.id;
        form.appendChild(idInput);

        const quantityInput = document.createElement('input');
        quantityInput.type = 'hidden';
        quantityInput.name = 'productQuantity[]';
        quantityInput.value = item.quantity;
        form.appendChild(quantityInput);
    });

    const totalInput = document.createElement('input');
    totalInput.type = 'hidden';
    totalInput.name = 'totalAmount';
    totalInput.value = cart.reduce((total, item) => total + (item.price * item.quantity), 0).toFixed(2);
    form.appendChild(totalInput);

    document.body.appendChild(form);
    form.submit();
}

window.updateProducts = () => {
    fetchProducts();
    console.log('Updated product list:', allProducts);
}

window.addEventListener('load', () => {
    setTimeout(window.updateProducts, 1000);
});