<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
    <!-- Add these meta tags in your JSP file -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Profile</title>
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


        /* Increase form control size */
        .form-control {
            padding: 0.75rem;
            font-size: 1.1rem;
            border-radius: 5px;
        }
        /* Increase label font size */
        .form-label {
            font-size: 1.2rem;
        }


        .updateProfile {
            margin-top: 100px;
        }

        #updateProfileForm {
            font-size: 3rem;
        }

        .form_update label, .form_update input {
            font-size: 2rem;
        }

        .form_update input {
            height: 50px;
            width: 90%;
        }

        .footer li {
            font-size: 1.5rem;
        }

        .error-message {
            color: red;
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
        <div class="collapse navbar-collapse ml-5" id="navbarNav" style="width: 750px">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                    <a class="nav-link menu" aria-current="page" href="/home">Home</a>
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
                    <div class="search-icon" style="width: 330px;">
                        <input class="form-control search_nav" type="search" placeholder="Search"
                               aria-label="Search"
                               style="font-size: 1.5rem;
                                        height: 40px;
                                        padding-top: 8px;
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
        <div class="icon-cart" style="margin-left: 30px">
            <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M6 15a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0h8m-8 0-1-4m9 4a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-9-4h10l2-7H3m2 7L3 4m0 0-.792-3H1" />
            </svg>
            <span>0</span>
        </div>
        <div class="navbar-nav">
            <security:authorize access="isAuthenticated()">
                <a href="/client/homepage/userpage" class="me-2">
                    <img class="logo-nav rounded-circle" style="width: 40px; height: 40px; object-fit: cover; background: #007bff;" src="/client/img/avatar.jpg" alt="user" />
                </a>
                <div class="mt-3" style="font-size: 1.5rem">
                    <security:authentication var="userEmail" property="principal.username" />
                    <c:set var="username" value="${fn:substringBefore(userEmail, '@')}" />
                        ${fullName}
                </div>
                <form id="logoutForm" method="post" action="/logout" class="mt-2">
                    <security:csrfInput />
                    <button type="submit" style="width: 70px; height: 30px" class="btn btn-outline-primary" onclick="logout(event)">Logout</button>
                </form>
            </security:authorize>
        </div>
        <div class="form-check form-switch dark-mode-toggle mx-5">
            <input class="form-check-input" type="checkbox" id="darkModeToggle" />
            <label class="form-check-label" for="darkModeToggle">Dark Mode</label>
        </div>
    </div>
</nav>
<%--Main--%>
    <div class="container">
        <h1 class="updateProfile">User Profile</h1>
        <div class="row">
            <!-- Modal for updating profile -->
            <div class="form_update col-md-8">
                <form id="updateProfileForm" action="${pageContext.request.contextPath}/client/homepage/update-profile" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="full_name">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}">
                    </div>
                    <div>
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}">
                    </div>
                    <div>
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                    </div>
                    <div class="mt-5">
                        <a href="/client/homepage/userpage" type="button" class="btn btn-secondary">Close</a>
                        <button type="submit" class="btn btn-primary" value="Validate!">Save changes</button>
                    </div>
                </form>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
            </div>
            <div class="col-md-4">
                <div id="bannerCarousel" class="carousel slide col-md-6" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="/images/product/s22 ultra.jpg" class="d-block w-100 img-fluid" alt="Galaxy Z Fold 4" />
                        </div>
                        <div class="carousel-item">
                            <img src="/images/product/iphone15.png" class="d-block w-100 img-fluid" alt="Iphone 16" />
                        </div>
                        <div class="carousel-item">
                            <img src="/images/product/note20.jpg" class="d-block w-100 img-fluid" alt="Huawei" />
                        </div>
                    </div>

                    <!-- Controls -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>

                    <!-- Indicators -->
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="0" class="active"
                                aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="1"
                                aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#bannerCarousel" data-bs-slide-to="2"
                                aria-label="Slide 3"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- Footer -->
<nav class="navbar navbar-expand-lg navbar-light bg-light mt-5" style="position: fixed; bottom: 0; width: 100%;">
    <div class="container-fluid footer">
        <img class="logo" src="/images/product/FMobileLogo.png" alt="" />
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="row g-5 mt-1">
            <div class="col-md-6">
                <h2 class="mb-4">
                    Be the first to explore and use our new products while others are
                    still waiting
                </h2>
                <button class="btn btn-primary">Get Started</button>
            </div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-sm-3">
                        <h5>Products</h5>
                        <ul class="list-unstyled">
                            <li>Iphone</li>
                            <li>Samsung</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>Category</h5>
                        <ul class="list-unstyled">
                            <li>Alcatel 6850</li>
                            <li>Ruckus ZD 1200</li>
                            <li>Alcatel 6850</li>
                            <li>Ruckus ZD 1200</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>About</h5>
                        <ul class="list-unstyled">
                            <li>Newsletter</li>
                            <li>Privacy</li>
                            <li>Terms</li>
                            <li>Cookies</li>
                        </ul>
                    </div>
                    <div class="col-sm-3">
                        <h5>Contact</h5>
                        <ul class="list-unstyled">
                            <li>0763254524</li>
                            <li>fmobile@gmail.com</li>
                            <li>fmobile@edu.vn</li>
                        </ul>
                    </div>
                </div>
            </div>
            <footer class="text-center" style="font-size: 1.5rem">
                Copyright © 2024 group 1 F Mobile
            </footer>
        </div>
    </div>
</nav>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script>
        const darkModeToggle = document.getElementById("darkModeToggle");
        darkModeToggle.addEventListener("change", function () {
        document.body.classList.toggle("dark-mode", darkModeToggle.checked);
    });
</script>
<script>
    function logout(event) {
        event.preventDefault();
        fetch('/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(new FormData(document.getElementById('logoutForm'))),
        }).then(() => {
            window.location.href = '/client/homepage';  // Redirect to homepage after logout
        }).catch(error => {
            console.error('Logout error:', error);
        });
    }
</script>
<script>
    $(document).ready(function() {
        $("#updateProfileForm").validate({
            rules: {
                fullName: {
                    required: true,
                    minlength: 2,
                    pattern: /^[a-zA-Z\s]+$/
                },
                phone: {
                    required: true,
                    pattern: /^(\+\d{1,3}[- ]?)?\d{10}$/
                },
                address: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                fullName: {
                    required: "Please enter your full name.",
                    minlength: "Full name must be at least 2 characters long.",
                    pattern: "Please enter a valid name (letters and spaces only)."
                },
                phone: {
                    required: "Please enter your phone number.",
                    pattern: "Please enter a valid phone number (10 digits, optional country code)."
                },
                address: {
                    required: "Please enter your address.",
                    minlength: "Address must be at least 5 characters long."
                }
            },
            errorElement: "span",
            errorClass: "error-message",
            errorPlacement: function(error, element) {
                error.insertAfter(element);
            },
            highlight: function(element) {
                $(element).addClass("is-invalid");
            },
            unhighlight: function(element) {
                $(element).removeClass("is-invalid");
            },
            submitHandler: function(form) {
                // Form validation successful, proceed with form submission
                form.submit();
            }
        });
    });
</script>
</body>
</html>
