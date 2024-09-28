
<%--
  Created by IntelliJ IDEA.
  User: Quy
  Date: 13/09/2024
  Time: 09:24 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/extras/spring-security">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FMOBILE</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        #guestButtons, #userInfo {
            display: none;
        }


        body.dark-mode .login_username {
            color: #0d6efd;
        }

        form {
            display: flex;
            flex-direction: column;
        }
        label, input {
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<div id="notification" style="
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #f8d7da;
    color: #721c24;
    padding: 15px 20px;
    border-radius: 5px;
    z-index: 1000;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    font-size: 16px;
    text-align: center;
    max-width: 80%;
">
</div>
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
        <div class="collapse navbar-collapse ml-5" id="navbarNav" style="width: 850px">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                    <a class="nav-link menu" aria-current="page" href="#">Home</a>
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
                <form class="d-flex ml-5 mb-2">
                    <div class="search-icon" style="width: 330px">
                        <input class="form-control search_nav" style="line-height: 20px; padding-top: 5px" type="search" placeholder="Search"
                               aria-label="Search"
                               style="font-size: 1.5rem;
                                        height: 40px;
                                        padding-top: 5px;
                                        border-radius: 5px;"/>
                        <svg style="right: 105px;
                                    top: 60%;" class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                             viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-width="2"
                                  d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z" />
                        </svg>
                    </div>
                </form>
            </ul>
        </div>
        <div class="icon-cart" style="margin-left: 20px">
            <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M6 15a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0h8m-8 0-1-4m9 4a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-9-4h10l2-7H3m2 7L3 4m0 0-.792-3H1" />
            </svg>
            <span>0</span>
        </div>
        <div class="navbar-nav" style="margin-left: 15px">
            <security:authorize access="isAuthenticated()">
                <a href="/client/homepage/userpage" class="me-2">
                    <img class="logo-nav rounded-circle" style="width: 40px; height: 40px; object-fit: cover; background: #007bff;" src="/client/img/avatar.jpg" alt="user" />
                </a>
                <div class="mt-3" style="font-size: 1.5rem;width: 150px">
                    <security:authentication var="userEmail" property="principal.username" />
                    <c:set var="username" value="${fn:substringBefore(userEmail, '@')}" />
                        ${fullName}
                </div>
                <form method="post" action="/logout" class="mt-3">
                    <button type="submit" style="width: 70px; height: 30px" class="btn btn-outline-primary" onclick="logout()">Logout</button>
                </form>
            </security:authorize>
        </div>
    </div>
    <div class="form-check form-switch dark-mode-toggle mx-3" style="margin-top: 15px">
        <input class="form-check-input" type="checkbox" id="darkModeToggle" />
        <label class="form-check-label" style="width: 100px;" for="darkModeToggle">Dark Mode</label>
    </div>
    </div>
    </div>
</nav>

<%--<!-- Header -->--%>
<%--<div class="container">--%>
<%--    <div class="row header">--%>
<%--        <div class="col-md-6 header_baner">--%>
<%--            <h1 style="font-size: 6rem">--%>
<%--                Let's go to store. You have what you need.--%>
<%--            </h1>--%>
<%--            <a class="btn btn_header btn-primary">Get Started</a>--%>
<%--        </div>--%>
<%--        <!-- Anh truoc ngang -->--%>
<%--        <div id="bannerCarousel" class="carousel slide col-md-6" data-bs-ride="carousel">--%>
<%--            <div class="carousel-inner">--%>
<%--                <div class="carousel-item active">--%>
<%--                    <img src="/images/product/galaxy z fold 4.jpg" class="d-block w-100 img-fluid" alt="Galaxy Z Fold 4" />--%>
<%--                </div>--%>
<%--                <div class="carousel-item">--%>
<%--                    <img src="/images/product/iphone-16-pro-fi.webp" class="d-block w-100 img-fluid" alt="Iphone 16" />--%>
<%--                </div>--%>
<%--                <div class="carousel-item">--%>
<%--                    <img src="/images/product/huaweinew.png" class="d-block w-100 img-fluid" alt="Huawei" />--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Controls -->--%>
<%--            <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel"--%>
<%--                    data-bs-slide="prev">--%>
<%--                <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
<%--                <span class="visually-hidden">Previous</span>--%>
<%--            </button>--%>
<%--            <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel"--%>
<%--                    data-bs-slide="next">--%>
<%--                <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
<%--                <span class="visually-hidden">Next</span>--%>
<%--            </button>--%>

<%--            <!-- Indicators -->--%>
<%--            <div class="carousel-indicators">--%>
<%--                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="0" class="active"--%>
<%--                        aria-current="true" aria-label="Slide 1"></button>--%>
<%--                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="1"--%>
<%--                        aria-label="Slide 2"></button>--%>
<%--                <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="2"--%>
<%--                        aria-label="Slide 3"></button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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
        window.location.href = '/';
    }

    // Thêm các event listener khi DOM đã sẵn sàng
    document.addEventListener('DOMContentLoaded', function() {
        checkLoginState();

        const loginForm = document.getElementById('loginForm');
        if (loginForm) loginForm.addEventListener('submit', handleLogin);

        const registerForm = document.getElementById('registerForm');
        if (registerForm) registerForm.addEventListener('submit', handleRegister);

        const logoutButton = document.querySelector('form[action="/logout"] button');
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
</script>