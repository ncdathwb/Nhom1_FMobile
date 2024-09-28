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
        label {
            margin: 3px;
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
                        <a href="#" class="dropdown-item">My Profile</a>
                        <a href="#" class="dropdown-item">Settings</a>
                        <form method="post" action="/logout">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="dropdown-item">Logout</button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div class="row">
            <h5 class="mb-4"><c:choose><c:when test="${isEdit}">Update Product</c:when>
                <c:otherwise>Add new product</c:otherwise></c:choose></h5>
            <form:form action="/admin/product/saveOrUpdate" modelAttribute="product" method="post">
                <div class="row">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="id" value="${product.id}" />

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_name">Product Name</label>
                            <input class="form-control" type="text" id="product_name" name="productName" value="${product.productName}" />
                            <div class="error-message" id="productNameError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="productName"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_price">Product Price</label>
                            <input class="form-control" type="number" id="product_price" name="price" step="1" value="${product.price}" />
                            <div class="error-message" id="priceError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="price"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_quantity">Product Quantity</label>
                            <input class="form-control" type="number" id="product_quantity" name="quantity" value="${product.quantity}" />
                            <div class="error-message" id="quantityError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="quantity"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_sold">Product Sold</label>
                            <input class="form-control" type="number" id="product_sold" name="sold" value="${product.sold}" />
                            <div class="error-message" id="soldError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="sold"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_color">Product Color</label>
                            <input class="form-control" type="text" placeholder="Example: Black" id="product_color" name="color" value="${product.color}" />
                            <div class="error-message" id="colorError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="color"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_ram">RAM</label>
                            <input class="form-control" type="text" placeholder="Example: 8GB" id="product_ram" name="ram" value="${product.ram}" />
                            <div class="error-message" id="ramError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="ram"></form:errors></p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="product_description">Description</label>
                            <input class="form-control" type="text" id="product_description" name="description" value="${product.description}" />
                            <div class="error-message" id="descriptionError" style="color: red; display: none;"></div>
                            <p style="color: red"><form:errors path="description"></form:errors></p>
                        </div>
                    </div>

                    <div class="form-group col-md-3">
                        <label for="brand">Brand</label>
                        <select class="form-control" id="brand" name="brand.id" required>
                            <option value="">-- Choose Brand --</option>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.id}" <c:if test="${brand.id == product.brand.id}">selected</c:if>>${brand.brandName}</option>
                            </c:forEach>
                        </select>
                        <div class="error-message" id="brandError" style="color: red; display: none;"></div>
                    </div>

                    <div class="form-group col-md-3">
                        <label for="category">Category</label>
                        <select class="form-control" id="category" name="productCategory.id" required>
                            <option value="">-- Choose Category --</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" <c:if test="${category.id == product.productCategory.id}">selected</c:if>>${category.categoryName}</option>
                            </c:forEach>
                        </select>
                        <div class="error-message" id="categoryError" style="color: red; display: none;"></div>
                    </div>

                    <input class="form-control" type="hidden" id="create_day" name="createdAt" value="${product.createdAt}" />
                    <input class="form-control" type="hidden" id="update_day" name="updatedAt" value="${product.updatedAt}" readonly />

                    <div>
                        <button type="submit" id="submit-button" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${isEdit}">Update Product</c:when>
                                <c:otherwise>Add New Product</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </div>
            </form:form>

        </div>
        <!-- Bảng product -->
        <div class="row">
            <div class="col-lg-12">
                <div class="bg-light rounded h-100 p-4">
                    <h5 class="mb-4">Product Table</h5>
                    <form action="" method="GET" class="d-none d-md-flex col-4" style="background-color: gainsboro">
                        <div class="input-group input-group-sm col-3">
                            <input class="form-control border-0" type="text" placeholder="Search by name or color or ram" name="keyword" value="${keyword}" >
                            <button type="submit" class="btn btn-group-lg"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                    <br>
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Sold</th>
                            <th scope="col">Color</th>
                            <th scope="col">Ram</th>
                            <th scope="col">Brand</th>
                            <th scope="col">Category</th>
                            <th scope="col">Description</th>
                            <th scope="col">Created</th>
                            <th scope="col">Update</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.productName}</td>
                                <td>${product.price}</td>
                                <td>${product.quantity}</td>
                                <td>${product.sold}</td>
                                <td>${product.color}</td>
                                <td>${product.ram}</td>
                                <td>${product.brand.brandName}</td>
                                <td>${product.productCategory.categoryName}</td>
                                <td>${product.description}</td>
                                <td>${product.createdAt}</td>
                                <td>${product.updatedAt}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/product/edit/${product.id}" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete/${product.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure to delete?');">Del</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-end">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?pageNo=${currentPage - 1}&keyword=${keyword}">Previous</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPage}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?pageNo=${i}&keyword=${keyword}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                                <a class="page-link" href="?pageNo=${currentPage + 1}&keyword=${keyword}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Footer Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded-top p-4">
                <div class="row">
                    <div class="col-12 col-sm-6 text-center text-sm-start">
                        &copy;All
                        Right Reserved.
                    </div>
                    <div class="col-12 col-sm-6 text-center text-sm-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By F Mobile
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
    </div>
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
    document.getElementById("submit-button").onclick = function(event) {
        // Lấy giá trị của các trường
        var productName = document.getElementById("product_name").value.trim();
        var price = document.getElementById("product_price").value.trim();
        var quantity = document.getElementById("product_quantity").value.trim();
        var sold = document.getElementById("product_sold").value.trim();
        var color = document.getElementById("product_color").value.trim();
        var ram = document.getElementById("product_ram").value.trim();
        var description = document.getElementById("product_description").value.trim();
        var brand = document.getElementById("brand").value;
        var category = document.getElementById("category").value;

        // Reset thông báo lỗi
        document.getElementById("productNameError").style.display = "none";
        document.getElementById("priceError").style.display = "none";
        document.getElementById("quantityError").style.display = "none";
        document.getElementById("soldError").style.display = "none";
        document.getElementById("colorError").style.display = "none";
        document.getElementById("ramError").style.display = "none";
        document.getElementById("descriptionError").style.display = "none";
        document.getElementById("brandError").style.display = "none";
        document.getElementById("categoryError").style.display = "none";

        // Kiểm tra Product Name
        if (!productName) {
            document.getElementById("productNameError").innerText = "Product Name cannot be empty!";
            document.getElementById("productNameError").style.display = "block";
            event.preventDefault();
            return;
        }
        if (productName.length > 255) {
            document.getElementById("productNameError").innerText = "Product Name cannot exceed 255 characters!";
            document.getElementById("productNameError").style.display = "block";
            event.preventDefault();
            return;
        }
        var regex = /^[a-zA-Z0-9\s]+$/; // Không chứa ký tự đặc biệt
        if (!regex.test(productName)) {
            document.getElementById("productNameError").innerText = "Product Name can only contain letters, numbers, and spaces!";
            document.getElementById("productNameError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Price
        if (!price) {
            document.getElementById("priceError").innerText = "Product Price cannot be empty!";
            document.getElementById("priceError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Quantity
        if (!quantity) {
            document.getElementById("quantityError").innerText = "Product Quantity cannot be empty!";
            document.getElementById("quantityError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Sold
        if (!sold) {
            document.getElementById("soldError").innerText = "Product Sold cannot be empty!";
            document.getElementById("soldError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Color
        if (!color) {
            document.getElementById("colorError").innerText = "Product Color cannot be empty!";
            document.getElementById("colorError").style.display = "block";
            event.preventDefault();
            return;
        }
        if (color.length > 255) {
            document.getElementById("colorError").innerText = "Product Color cannot exceed 255 characters!";
            document.getElementById("colorError").style.display = "block";
            event.preventDefault();
            return;
        }
        if (!regex.test(color)) {
            document.getElementById("colorError").innerText = "Product Color can only contain letters, numbers, and spaces!";
            document.getElementById("colorError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra RAM
        if (ram && !/^(?=.*\d)(?=.*GB)[a-zA-Z0-9 ]*$/.test(ram)) {
            document.getElementById("ramError").innerText = "RAM must match the format: 'number' + 'GB' (e.g. 8GB)!";
            document.getElementById("ramError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Description
        if (description.length > 255) {
            document.getElementById("descriptionError").innerText = "Description cannot exceed 255 characters!";
            document.getElementById("descriptionError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Brand
        if (!brand) {
            document.getElementById("brandError").innerText = "Brand must be selected!";
            document.getElementById("brandError").style.display = "block";
            event.preventDefault();
            return;
        }

        // Kiểm tra Category
        if (!category) {
            document.getElementById("categoryError").innerText = "Category must be selected!";
            document.getElementById("categoryError").style.display = "block";
            event.preventDefault();
            return;
        }
    };
</script>
</body>
</html>
