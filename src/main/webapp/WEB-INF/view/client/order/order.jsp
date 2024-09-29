<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Quicksand', Arial, sans-serif;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .card-title {
            color: #0d6efd;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
            transform: translateY(-2px);
        }
        .btn-danger {
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            transform: translateY(-2px);
        }
        .order-details {
            display: none;
        }
        .btneye {
            cursor: pointer;
            color: #0d6efd;
        }
        .pagination {
            justify-content: center;
        }
        .icon-text {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<%--<jsp:include page="header.jsp"/>--%>

<div class="container mt-5">
    <h1 class="mb-4"><i class="fas fa-shopping-bag icon-text"></i>My Orders</h1>

    <c:forEach items="${listOrder}" var="order">
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="card-title"><i class="fas fa-box icon-text"></i>Order #${order.id}</h5>
                    <span class="badge bg-primary"><i class="fas fa-info-circle icon-text"></i>${order.status}</span>
                </div>
                <p class="card-text"><i class="far fa-calendar-alt icon-text"></i>Date: ${order.orderDate}</p>
                <p class="card-text"><i class="fas fa-dollar-sign icon-text"></i>Total: $${order.totalPayment}</p>
                <p class="card-text"><i class="far fa-credit-card icon-text"></i>Payment Method: ${order.paymentMethod.paymentName}</p>
                <div class="d-flex justify-content-between align-items-center">
                    <button class="btn btn-outline-primary btn-sm toggle-details">
                        <i class="fas fa-eye"></i> View Details
                    </button>
                    <c:if test="${order.status != 'Canceled'}">
                        <form action="/client/cancel-order" onsubmit="return confirmCancel()" method="post" class="d-inline">
                            <input type="hidden" name="orderID" value="${order.id}">
                            <button class="btn btn-danger btn-sm"><i class="fas fa-times icon-text"></i>Cancel Order</button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </c:if>
                </div>
                <div class="order-details mt-3">
                    <hr>
                    <p><i class="fas fa-map-marker-alt icon-text"></i>Shipping Address: ${order.shippingAddress}</p>
                    <p><i class="fas fa-tags icon-text"></i>Discount: $${order.discount == null ? '0' : order.discount.discountValue}</p>
                    <!-- Add more order details here if needed -->
                </div>
            </div>
        </div>
    </c:forEach>

    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${currentPage > 0}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                        <span aria-hidden="true"><i class="fas fa-chevron-left"></i> Previous</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPage}">
                <li class="page-item ${i - 1 == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i-1}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPage - 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                        <span aria-hidden="true">Next <i class="fas fa-chevron-right"></i></span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<%--<jsp:include page="footer.jsp"/>--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmCancel() {
        return confirm("Are you sure you want to cancel this order?");
    }

    document.querySelectorAll('.toggle-details').forEach(button => {
        button.addEventListener('click', function() {
            const details = this.closest('.card-body').querySelector('.order-details');
            details.style.display = details.style.display === 'none' ? 'block' : 'none';
            this.innerHTML = details.style.display === 'none' ?
                '<i class="fas fa-eye"></i> View Details' :
                '<i class="fas fa-eye-slash"></i> Hide Details';
        });
    });
</script>
</body>
</html>