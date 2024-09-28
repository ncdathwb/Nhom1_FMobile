<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Admin User</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">


    <!-- Favicon -->
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.0/webfonts/fa-solid-900.woff2"
          rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/owl.carousel/2.3.4/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.0/css/tempusdominus-bootstrap-4.min.css"
          rel="stylesheet">


    <!-- CDN Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <!-- Link CSS -->
    <link href="/css/admin.css" rel="stylesheet">

    <style>
        .error {
            color: red; /* Màu chữ đỏ */
            font-size: 0.875em; /* Kích thước chữ nhỏ hơn */
            margin-top: 0.25em; /* Khoảng cách trên của thông báo lỗi */
        }

        .fa-solid {
            color: black;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container-xxl position-relative bg-white d-flex p-0">

    <!-- Sidebar Start -->
    <div class="sidebar pe-4 pb-3">
        <nav class="navbar bg-light navbar-light">
            <a href="/admin/home" class="navbar-brand mx-4 mb-3">
                <h3 class="text-primary">ADMIN</h3>
            </a>
            <div class="d-flex align-items-center ms-4 mb-4">
                <div class="position-relative">
                    <div
                            class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1">
                    </div>
                </div>
                <div class="ms-3">
                    <h6 class="mb-0">Fmobile</h6>
                    <span>Admin</span>
                </div>
            </div>
            <div class="navbar-nav w-100">
                <a href="/admin/home" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                <a href="/admin/user" class="nav-item nav-link"><i class="fa fa-user me-2"></i>User</a>
                <a href="/admin/order" class="nav-item nav-link"><i class="fa fa-shopping-cart me-2"></i>Order</a>
                <a href="/admin/product" class="nav-item nav-link"><i class="fa fa-tag me-2"></i>Product</a>
                <a href="/admin/brand" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Brand</a>
                <a href="/admin/category" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>Category</a>
                <a href="/admin/image" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Image</a>
            </div>
        </nav>
    </div>
    <!-- Sidebar End -->


    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
            <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
            </a>
            <a href="#" class="sidebar-toggler flex-shrink-0">
                <i class="fa fa-bars"></i>
            </a>
            <div class="navbar-nav align-items-center ms-auto">
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <span class="d-none d-lg-inline-flex">Fmobile</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                        <form method="post" action="/logout">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button class="dropdown-item">Logout</button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <br>


        <form:form method="post" action="/admin/update/user" modelAttribute="newUser" id="userForm">
        <div class="row">
            <form:hidden path="id"/> <!-- Đảm bảo ID được gửi cùng với các trường khác -->
            <div class="col-md-6">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <form:input class="form-control" path="fullName" id="fullName"/>
                    <label id="fullName-error" class="error" for="fullName"></label>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group" style="pointer-events: none">
                    <label for="email">Email</label>
                    <form:input class="form-control" path="email" id="email"/>
                    <label id="email-error" class="error" for="email"></label>
                    <form:errors path="email" cssClass="text-danger"/>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <form:input class="form-control" path="phone" id="phone"/>
                    <label id="phone-error" class="error" for="phone"></label>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label for="address">Address</label>
                    <form:input class="form-control" path="address" id="address"/>
                    <label id="address-error" class="error" for="address"></label>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group" style="pointer-events: none">
                    <label for="password">Password</label>
                    <form:input class="form-control" type="password" path="password" id="password"/>
                    <label id="password-error" class="error" for="password"></label>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group" style="pointer-events: none">
                    <label for="enabled">Enabled</label>
                    <form:select class="form-control" path="enabled" id="enabled">
                        <option>Yes</option>
                        <option>No</option>
                    </form:select>
                </div>
            </div>
            <div class="col-md-6">
                <button style="margin-top: 10px" type="submit" class="btn btn-primary">Update User</button>
                </form:form>
            </div>

        </div>
        <br>

        <!-- Footer Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded-top p-4">
                <div class="row">
                    <div class="col-12 col-sm-6 text-center text-sm-start">
                        &copy; <a href="https://www.facebook.com/profile.php?id=100030887559873">My Profile</a>, All
                        Right Reserved.
                    </div>
                    <div class="col-12 col-sm-6 text-center text-sm-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By F Mobile
                        </br>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
    </div>
    <!-- Content End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>

<%--CDN Javascript--%>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- CDN jQuery Validation -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.min.js"
        integrity="sha512-KFHXdr2oObHKI9w4Hv1XPKc898mE4kgYx58oqsc/JqqdLMDI4YjOLzom+EMlW8HFUd0QfjfAvxSL6sEq/a42fQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- Bootstrap Bundle JS (Bootstrap 5.0) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart.js (nếu cần biểu đồ) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Owl Carousel (nếu sử dụng carousel) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"
        integrity="sha512-YDr/FllsYt5mPpDsytI+Y1twc4Lgf/Xrh/1hYIS2BEPxDfevPcfovtRUFa+VDP4kNeh4+srDOFexlIn/ksz+wA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- Moment.js (nếu cần xử lý thời gian) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"
        integrity="sha512-qTXRIMyZIFb8JdNgwO1Br6Lq3EY7dx6h7nBbg78X6hfXqUBSXGXk43kO5nc7u7+L2e5jrS3T1KNczHD8Qq9Kog=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Bootstrap Bundle JS (đã bao gồm cả Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>


<!-- Template Javascript -->
<script src="/js/admin.js"></script>

<script>
    $(document).ready(function () {


        // Thêm quy tắc tùy chỉnh cho số điện thoại
        $.validator.addMethod("phonePattern", function (value, element) {
            var phonePattern = /^0[0-9]{9}$/;
            return this.optional(element) || phonePattern.test(value);
        }, "Phone number must be valid");

        $("#userForm").validate({
            rules: {
                fullName: {
                    required: true,
                    minlength: 3
                },
                email: {
                    required: true,
                    email: true
                },
                phone: {
                    required: true,
                    phonePattern: true
                },
                password: {
                    required: true,
                    minlength: 6
                },
                address: {
                    required: true
                },
                enabled: {
                    required: true
                }
            },
            messages: {
                fullName: {
                    required: "Full Name is required",
                    minlength: "Full Name must be at least 3 characters long"
                },
                email: {
                    required: "Email is required",
                    email: "Please enter a valid email address"
                },
                phone: {
                    required: "Phone number is required",
                    phonePattern: "Phone number must be valid"
                },
                password: {
                    required: "Password is required",
                    minlength: "Password must be at least 6 characters long"
                },
                address: {
                    required: "Address is required"
                },
                enabled: {
                    required: "Please select if the user is enabled"
                }
            },
            errorPlacement: function (error, element) {
                var id = element.attr("id");
                $("#" + id + "-error").html(error);
            }
        });
    });

</script>

</body>
</html>
