
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase History</title>
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
        }

        .purchase_history {
            margin-top: 80px;
        }

        tbody {
            font-size: 2rem;
        }

        body.dark-mode tbody,
        body.dark-mode table tr th {
            color: #FFFFFF;
        }

        table tr th {
            color: black;
        }

        .pagination a {
            font-size: 1.5rem;
        }

        .footer li {
            font-size: 1.5rem;
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
        <div class="collapse navbar-collapse ml-5" id="navbarNav" style="width: 800px">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                    <a class="nav-link menu" aria-current="page" href="/client/homepage">Home</a>
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
                        <input class="form-control search_nav" type="search" placeholder="Search"
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
            <label class="form-check-label" style="width: 60px;font-size: 1.2rem" for="darkModeToggle">Dark Mode</label>
        </div>
    </div>
</nav>
<%--Main--%>
    <div class="container">
        <div class="row">
            <div class="purchase_history">
                <h1>Purchase History</h1>
                <div class="content-panel">
                    <div class="row align-items-center">
                        <h3 class="title">FMobile</h3>
                        <div class="col-md-12">
                            <h1 class="mb-0" style="color: #007bff;">ORDER HISTORY</h1>
                        </div>
                    </div>
                    <div class="mt-5">
                        <table class="table table-responsive table-group-divider" style="font-size: 15px;">
                            <thead class="thead-light">
                            <tr>
                                <th><input type="checkbox" class="bsn" id="selectAll"></th>
                                <th>Order</th>
                                <th>Product Name</th>
                                <th>Date</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td><input type="checkbox" class="bso"></td>
                                    <td>${order.id}</td>
                                    <td>
                                        <c:forEach items="${order.orderDetails}" var="orderDetail">
                                            ${orderDetail.productName}<br>
                                        </c:forEach>
                                    </td>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <c:forEach items="${order.orderDetails}" var="orderDetail">
                                            ${orderDetail.quantity}<br>
                                        </c:forEach>
                                    </td>
                                    <td>${order.totalPayment}</td>
                                    <td>${order.status}</td>
                                    <td>
                                        <a href="/client/homepage/orderinformation?id=${order.id}" class="btn btn-outline-info" style="margin-right: 2px;"><i class="fa-solid fa-magnifying-glass"></i></a>
                                        <button class="btn btn-outline-danger delete-row-btn" data-order-id="${order.id}">
                                            <i class="fa-solid fa-delete-left"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <ul class="pagination pagination-lg">
                            <li class="page-item"><a class="page-link" href="#">Prev</a></li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">4</a></li>
                            <li class="page-item"><a class="page-link" href="#">5</a></li>
                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                        </ul>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${not empty orders}">
                                <!-- Bảng hiển thị đơn hàng -->
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info" role="alert">
                                    You have no purchase history yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
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
    // ------------------------ Pagination ------------------------------
    function setupPagination() {
        const rowsPerPage = 5; // Số dòng trên mỗi trang
        const rows = document.querySelectorAll('tbody tr'); // Tất cả các dòng trong bảng
        const totalRows = rows.length;
        const totalPages = Math.ceil(totalRows / rowsPerPage); // Tổng số trang

        let currentPage = 1; // Trang hiện tại mặc định là trang 1

        function showPage(page) {
            currentPage = page;

            // Ẩn tất cả các dòng
            rows.forEach((row) => {
                row.style.display = 'none';
            });

            // Hiển thị dòng thuộc trang hiện tại
            const startRow = (page - 1) * rowsPerPage;
            const endRow = startRow + rowsPerPage;
            for (let i = startRow; i < endRow && i < totalRows; i++) {
                rows[i].style.display = '';
            }

            // Cập nhật trạng thái phân trang (hiển thị trang hiện tại)
            const paginationItems = document.querySelectorAll('.pagination .page-item');
            paginationItems.forEach((item, index) => {
                if (index === page) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
        }

        //-------------------- Tạo phân trang --------------------
        const pagination = document.querySelector('.pagination');
        const pageLinks = pagination.querySelectorAll('.page-item a'); // Lấy tất cả các số trang

        //-------------------- Gắn sự kiện click cho từng số trang -------------------
        pageLinks.forEach((link, index) => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                if (index === 0) { // 'Prev' được chọn
                    if (currentPage > 1) {
                        showPage(currentPage - 1);
                    }
                } else if (index === pageLinks.length - 1) { // 'Next' được chọn
                    if (currentPage < totalPages) {
                        showPage(currentPage + 1);
                    }
                } else {
                    showPage(index); // Chuyển đến số trang tương ứng
                }
            });
        });

        // Hiển thị trang đầu tiên khi tải trang
        showPage(1);
    }

    // ------------------------ Select All ------------------------------
    function setupSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const rowCheckboxes = document.querySelectorAll('.bso');

        selectAllCheckbox.addEventListener('change', function() {
            rowCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        rowCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                selectAllCheckbox.checked = Array.from(rowCheckboxes).every(cb => cb.checked);
            });
        });
    }

    // ------------------------ Delete Row ------------------------------
    function deleteRow(row) {
        if (confirm('Are you sure you want to delete this row?')) {
            row.remove();
            updateTableAfterDeletion();
        }
    }

    function deleteSelectedRows() {
        const selectedRows = Array.from(document.querySelectorAll('.bso:checked'))
            .map(checkbox => checkbox.closest('tr'));

        if (selectedRows.length === 0) {
            alert('No rows selected for deletion.');
            return;
        }

        if (confirm(`Are you sure you want to delete ${selectedRows.length} selected row(s)?`)) {
            selectedRows.forEach(row => {
                row.remove();
            });

            // Reset select all checkbox
            document.getElementById('selectAll').checked = false;

            // Update pagination after deletion
            setupPagination();

            // Update the table display
            showPage(currentPage);

            alert(`${selectedRows.length} row(s) have been deleted.`);
        }
    }

    // ------------------------ Helper function to update table after deletion ------------------------------
    function updateTableAfterDeletion() {
        // Recalculate total rows and adjust pagination if needed
        setupPagination();

        // Reset pagination and display correct rows
        showPage(currentPage);
    }

    // ------------------------ Display and Setup Functions ------------------------------
    function displayPurchaseHistory() {
        setupPagination();
        setupSelectAll();

        // Bulk delete button
        const bulkDeleteButton = document.querySelector('.btn-outline-danger');
        if (bulkDeleteButton) {
            bulkDeleteButton.addEventListener('click', deleteSelectedRows);
        }

        // Add event listeners for individual delete buttons
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach(row => {
            const deleteButton = row.querySelector('.delete-row-btn');
            if (deleteButton) {
                deleteButton.addEventListener('click', () => deleteRow(row));
            }
        });
    }

    // Call this function to initialize everything when the page loads
    window.onload = function() {
        displayPurchaseHistory();
    };

</script>
<script>
    $(document).ready(function() {
        $('.delete-row-btn').on('click', function() {
            var orderId = $(this).data('order-id');
            if (confirm('Are you sure you want to delete this order?')) {
                $.ajax({
                    url: '/client/homepage/purchase-history/delete/' + orderId,
                    type: 'POST',
                    success: function(result) {
                        alert('Order deleted successfully');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to delete order: ' + xhr.responseText);
                    }
                });
            }
        });
    });
</script>
<script>
    const darkModeToggle = document.getElementById("darkModeToggle");
    darkModeToggle.addEventListener("change", function () {
        document.body.classList.toggle("dark-mode", darkModeToggle.checked);
    });
</script>
</body>
</html>
