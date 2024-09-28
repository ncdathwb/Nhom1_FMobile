
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        html {
            font-size: 62.5%;
        }
        body {
            font-family: Monospaced;
        }
        a {
            text-decoration: none;
        }
        .avatar-wrapper {
            position: relative;
            width: 150px;
            height: 150px;
            overflow: hidden;
            border-radius: 50%;
            cursor: pointer;
        }
        .avatar-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .avatar-wrapper input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }


        .btn {
            font-size: 15px;
        }

        input {
            height: 30px;
        }

        table td, table th {
            vertical-align: middle; /* Đảm bảo tất cả nội dung căn giữa theo chiều dọc */
        }

        input[type="checkbox"] {
            position: relative;
            top: 5px;
            transform: translateY(-1px); /* Điều chỉnh nhỏ để căn chỉnh tốt hơn */
            margin: 0; /* Loại bỏ khoảng trống không cần thiết */
        }

        .logout_btn:hover {
            opacity: 0.9;
        }

        /* Increase form control size */
        .form-control {
            padding: 0.75rem;
            font-size: 1.1rem;
        }


        .login_username {
            color: #0d6efd;
            font-size: 15px;
        }
        /*-------------------------- Order Details ---------------------*/
        .order_details {
            margin-top: 80px;
            font-size: 2rem;
        }

        .card-body,h5 {
            font-size: 1.8rem;
        }

        .button_return {
            border: 1px solid #FFFFFF;
            color: black;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<!-- Nav -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container-fluid">
        <a href="#">
            <img class="logo-nav" src="/images/product/FMobileLogo.png" alt="" />
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse ml-5" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                    <a class="nav-link menu" aria-current="page" href="/client/homepage/">Home</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                         viewBox="0 0 24 24">
                        <path fill-rule="evenodd"
                              d="M5 4a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V4Zm12 12V5H7v11h10Zm-5 1a1 1 0 1 0 0 2h.01a1 1 0 1 0 0-2H12Z"
                              clip-rule="evenodd" />
                    </svg>
                    <a class="nav-link menu" href="#">Mobile</a>
                </li>
                <li class="nav-item">
                    <i class="fas fa-laptop"></i>
                    <a class="nav-link menu" href="#">Laptop</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 18h2M5.875 3h12.25c.483 0 .875.448.875 1v16c0 .552-.392 1-.875 1H5.875C5.392 21 5 20.552 5 20V4c0-.552.392-1 .875-1Z" />
                    </svg>
                    <a class="nav-link menu" href="#">Tablet</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                         viewBox="0 0 24 24">
                        <path fill-rule="evenodd"
                              d="M12 5a7 7 0 0 0-7 7v1.17c.313-.11.65-.17 1-.17h2a1 1 0 0 1 1 1v6a1 1 0 0 1-1 1H6a3 3 0 0 1-3-3v-6a9 9 0 0 1 18 0v6a3 3 0 0 1-3 3h-2a1 1 0 0 1-1-1v-6a1 1 0 0 1 1-1h2c.35 0 .687.06 1 .17V12a7 7 0 0 0-7-7Z"
                              clip-rule="evenodd" />
                    </svg>
                    <a class="nav-link menu" href="#">Accessories</a>
                </li>
                <form class="d-flex ml-5">
                    <div class="search-icon">
                        <input class="form-control search_nav" type="search" placeholder="Search"
                               aria-label="Search"
                               style="font-size: 1.5rem;
                                      height: 50px;
                                      padding-top: 10px;border-radius: 5px" />
                        <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                             viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-width="2"
                                  d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z" />
                        </svg>
                    </div>
                </form>
            </ul>
        </div>
        <div class="icon-cart mx-3">
            <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M6 15a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0h8m-8 0-1-4m9 4a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-9-4h10l2-7H3m2 7L3 4m0 0-.792-3H1" />
            </svg>
            <span>0</span>
        </div>
        <div class="navbar-nav ms-auto">
            <div id="userInfo">
                <div class="d-flex align-items-center">
                    <div class="icon-user mx-3">
                        <a href="/client/homepage/userpage"> <img class="logo-nav" style="background: #007bff" src="/client/img/avatar.jpg" alt="" /></a>
                    </div>
                    <span class="login_username me-3"><%=request.getUserPrincipal().getName().split("@")[0]%></span>
                    <a style="background:#007bff; color: #fff; font-size: 15px" class="btn logout_btn" href="/home" onclick="logout()">Logout</a>
                </div>
            </div>
        </div>
        <div class="form-check form-switch dark-mode-toggle mx-5">
            <input class="form-check-input" type="checkbox" id="darkModeToggle" />
            <label class="form-check-label" style="width: 60px;font-size: 1.2rem" for="darkModeToggle">Dark Mode</label>
        </div>
    </div>
</nav>
<%--Main--%>
    <div class="container">
        <div class="row">
            <section class="gradient-custom order_details" style="min-height: 100vh">
                <div class="container py-5">
                    <div class="row d-flex justify-content-center align-items-center">
                        <div class="col-lg-12 col-xl-10">
                            <div class="card" style="border-radius: 10px;">
                                <div class="card-header px-4 py-5 d-flex align-content-center justify-content-between">
                                    <h5 class="text-muted mb-0">Thanks for your Order, <span style="color: #0d6efd;"><span style="font-size: 2rem" class="login_username me-3"><%=request.getUserPrincipal().getName().split("@")[0]%></span></span></h5>
                                    <h5 class="text-muted mb-0">Order Information</h5>
                                </div>
                                <div class="card-body p-5">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <p class="lead fw-normal mb-0" style="color: #0d6efd; font-size: 2rem">Receipt</p>
                                    </div>
                                <c:forEach items="${order.ordersDetails}" var="orderDetails">
                                    <div class="card shadow-0 border mb-4">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <img src="${orderDetails.product.images[0].url}"
                                                         class="img-fluid" alt="Phone">
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0" style="font-size: 2rem">${orderDetails.product.productName}</p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small" style="font-size: 2rem">color: ${orderDetails.product.color}</p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small" style="font-size: 2rem">ram: ${orderDetails.product.ram}</p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small" style="font-size: 2rem">qty: ${orderDetails.quantity}</p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small" style="font-size: 2rem">$${orderDetails.price}</p>
                                                </div>
                                            </div>
                                            <hr class="mb-4" style="background-color: #e0e0e0; opacity: 1;">
                                        </div>
                                    </div>
                                </c:forEach>
                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="fw-bold mb-0" style="font-size: 2rem">Order Details</p>
                                        <p class="text-muted mb-0" style="font-size: 2rem"><span class="fw-bold me-4">Total</span>$${order.totalPayment}</p>
                                    </div>

                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="text-muted mb-0" style="font-size: 2rem">Order ID : ${order.id}</p>
<%--                                        <p class="text-muted mb-0"><span class="fw-bold me-4">Discount</span>${order.discount}</p>--%>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <p class="text-muted mb-0" style="font-size: 2rem">Invoice Date : ${order.orderDate}</p>
                                    </div>

                                    <div class="d-flex justify-content-between mb-5">
                                        <p class="text-muted mb-0" style="font-size: 2rem"><span class="fw-bold me-4">Delivery Charges</span> Free</p>
                                    </div>
                                </div>
                                <div class="card-footer border-0 px-4 py-5"
                                     style="background-color: #0d6efd; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
                                    <div class="d-flex align-content-center justify-content-between text-white text-uppercase mb-0">
                                        <a href="${pageContext.request.contextPath}/client/productsDetail/${order.id}" class="btn mt-1 button_return" style="color: #FFFFFF; font-size: 1.7rem"><i class="fa-solid fa-cart-shopping mx-2"></i>Buy Back</a>
                                        <h5 class="mt-3">Total paid: <span class="">$${order.totalPayment}</span></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const darkModeToggle = document.getElementById("darkModeToggle");
    darkModeToggle.addEventListener("change", function () {
        document.body.classList.toggle("dark-mode", darkModeToggle.checked);
    });
</script>
<script>
    // Hàm để kiểm tra trạng thái đăng nhập
    function checkLoginState() {
        const isLoggedIn = sessionStorage.getItem('isLoggedIn') === 'true';
        updateUI(isLoggedIn);
    }

    // Hàm cập nhật giao diện người dùng
    function updateUI(isLoggedIn) {
        const guestButtons = document.getElementById('guestButtons');
        const guestButtons1 = document.getElementById('guestButtons1');
        const userInfo = document.getElementById('userInfo');

        if (guestButtons) guestButtons.style.display = isLoggedIn ? 'none' : 'inline-block';
        if (guestButtons1) guestButtons1.style.display = isLoggedIn ? 'none' : 'inline-block';
        if (userInfo) userInfo.style.display = isLoggedIn ? 'flex' : 'none';
    }

    // Hàm xử lý đăng nhập
    function handleLogin(event) {
        event.preventDefault();
        // Ở đây bạn sẽ thêm logic xác thực đăng nhập thực tế
        sessionStorage.setItem('isLoggedIn', 'true');
        updateUI(true);
        window.location.href = '/index';
    }

    // Hàm xử lý đăng ký
    function handleRegister(event) {
        event.preventDefault();
        // Ở đây bạn sẽ thêm logic đăng ký thực tế
        sessionStorage.setItem('isLoggedIn', 'true');
        updateUI(true);
        window.location.href = '/index';
    }

    // Hàm xử lý đăng xuất
    function handleLogout(event) {
        event.preventDefault();
        sessionStorage.removeItem('isLoggedIn');
        updateUI(false);
        window.location.href = '/home';  // Changed from '/' to '/index'
    }

    // Thêm các event listener khi DOM đã sẵn sàng
    document.addEventListener('DOMContentLoaded', function() {
        checkLoginState();

        const loginForm = document.getElementById('loginForm');
        if (loginForm) loginForm.addEventListener('submit', handleLogin);

        const registerForm = document.getElementById('registerForm');
        if (registerForm) registerForm.addEventListener('submit', handleRegister);

        const logoutButton = document.querySelector('.logout_btn');  // Changed selector to match the button class
        if (logoutButton) logoutButton.addEventListener('click', handleLogout);

        const loginLink = document.getElementById('guestButtons');
        if (loginLink) loginLink.addEventListener('click', function(e) {
            e.preventDefault();
            window.location.href = '/login';
        });

        const registerLink = document.getElementById('guestButtons1');
        if (registerLink) registerLink.addEventListener('click', function(e) {
            e.preventDefault();
            window.location.href = '/register';
        });
    });

    // Function to handle logout (to be called from onclick attribute)
    function logout() {
        sessionStorage.removeItem('isLoggedIn');
        updateUI(false);
        window.location.href = '/index';
    }
</script>
</body>
</html>
