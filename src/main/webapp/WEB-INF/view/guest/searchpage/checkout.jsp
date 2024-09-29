<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout Page</title>
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
        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .img-thumbnail {
            border-radius: 10px;
        }
        .lbform {
            font-weight: bold;
            display: block;
            margin-bottom: 3px;
            margin-top: 15px;
        }
        .text-danger {
            color: #b34040;
            font-size: 0.875rem;
            margin-top: 5px;
        }
        @media (max-width: 768px) {
            .order-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .order-item img {
                margin-bottom: 1rem;
            }
            .order-item button {
                margin-top: 1rem;
            }
        }
        .mr-2 {
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h1 class="mb-4"><i class="fas fa-shopping-cart fa-lg mr-2"></i>Checkout</h1>
    <div class="row">
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="card-title"><i class="fas fa-list-alt fa-lg mr-2"></i>Order Details</h2>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty cart}">
                                <c:set var="total" value="0" />
                                <c:forEach items="${cart}" var="item">
                                    <tr>
                                        <td>${item.key.productName}</td>
                                        <td class="prices">$<fmt:formatNumber value="${item.key.price}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                        <td>${item.value}</td>
                                        <td>$<fmt:formatNumber value="${item.key.price * item.value}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    </tr>
                                    <c:set var="total" value="${total + (item.key.price * item.value)}" />
                                </c:forEach>
                            </c:when>
                            <c:when test="${not empty product}">
                                <tr>
                                    <td>${product.productName}</td>
                                    <td class="prices">$<fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                    <td>1</td>
                                    <td>$<fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                </tr>
                                <c:set var="total" value="${product.price}" />
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4">No items in the order.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <h5>Total:</h5>
                        <h5>$<fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2"/></h5>
                    </div>
                </div>
            </div>
            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="card-title"><i class="fas fa-info-circle fa-lg mr-2"></i>Order Information</h2>
                    <c:if test="${not empty orderError}">
                        <div class="alert alert-danger" role="alert">
                                ${orderError}
                        </div>
                    </c:if>
                    <c:choose>
                        <c:when test="${user != null}">
                            <form:form modelAttribute="orderDTO" method="post" action="/checkout" onsubmit="return validateFormUser(this);">
                                <div class="col-md-6">
                                    <label class="lbform"><i class="fas fa-envelope mr-2"></i>Email</label>
                                    <input value="${user.email}" readonly disabled class="form-control">
                                    <label class="lbform"><i class="fas fa-user mr-2"></i>Full Name</label>
                                    <form:input path="fullName" class="form-control"/>
                                    <form:errors path="fullName" cssClass="text-danger"/>
                                    <div id="fullNameErrorLogin" class="text-danger"></div>
                                    <label class="lbform"><i class="fas fa-map-marker-alt mr-2"></i>Address</label>
                                    <form:input path="address" class="form-control"/>
                                    <form:errors path="address" cssClass="text-danger"/>
                                    <div id="addressErrorLogin" class="text-danger"></div>
                                    <label class="lbform"><i class="fas fa-phone mr-2"></i>Phone Number</label>
                                    <form:input path="phone" class="form-control"/>
                                    <form:errors path="phone" cssClass="text-danger"/>
                                    <div id="phoneErrorLogin" class="text-danger"></div>
                                </div>
                                <div class="col-md-6">
                                    <label class="lbform"><i class="fas fa-credit-card mr-2"></i>Payment Method</label>
                                    <select name="paymentId" class="form-control">
                                        <c:forEach items="${payment}" var="payment">
                                            <option value="${payment.id}">${payment.paymentName}</option>
                                        </c:forEach>
                                    </select>
                                    <button class="btn btn-primary btn-lg w-100 mt-4"><i class="fas fa-check mr-2"></i>Place Order</button>
                                </div>
                            </form:form>
                        </c:when>
                        <c:otherwise>
                            <form:form modelAttribute="orderDTO" method="post" action="/checkout/checkout-not-login" onsubmit="return validateFormGuest(this);">
                                <div class="col-md-6">
                                    <label class="lbform"><i class="fas fa-user mr-2"></i>Full Name</label>
                                    <form:input path="fullName" class="form-control"/>
                                    <form:errors path="fullName" cssClass="text-danger"/>
                                    <div id="fullNameError" class="text-danger"></div>
                                    <label class="lbform"><i class="fas fa-map-marker-alt mr-2"></i>Address</label>
                                    <form:input path="address" class="form-control"/>
                                    <form:errors path="address" cssClass="text-danger"/>
                                    <div id="addressError" class="text-danger"></div>
                                    <label class="lbform"><i class="fas fa-phone mr-2"></i>Phone Number</label>
                                    <form:input path="phone" class="form-control"/>
                                    <form:errors path="phone" cssClass="text-danger"/>
                                    <div id="phoneError" class="text-danger"></div>
                                    <label class="lbform"><i class="fas fa-envelope mr-2"></i>Email</label>
                                    <form:input path="email" class="form-control"/>
                                    <form:errors path="email" cssClass="text-danger"/>
                                    <div id="emailError" class="text-danger"></div>
                                    <c:if test="${not empty emailError}">
                                        <div class="alert alert-danger" role="alert">
                                                ${emailError}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <label class="lbform"><i class="fas fa-credit-card mr-2"></i>Payment Method</label>
                                    <select name="paymentId" class="form-control">
                                        <c:forEach items="${payment}" var="payment">
                                            <option value="${payment.id}">${payment.paymentName}</option>
                                        </c:forEach>
                                    </select>
                                    <button class="btn btn-primary btn-lg w-100 mt-4"><i class="fas fa-check mr-2"></i>Place Order</button>
                                </div>
                            </form:form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h2 class="card-title"><i class="fas fa-receipt fa-lg mr-2"></i>Order Summary</h2>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <span>$<fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2"/></span>
                    </div>
                    <c:if test="${user != null && discount != null}">
                        <div class="d-flex justify-content-between mb-2 text-danger">
                            <span>Discount:</span>
                            <span class="text-danger">$<fmt:formatNumber value="${discount.discountValue}" type="number" maxFractionDigits="2" minFractionDigits="2"/></span>
                        </div>
                        <hr>
                    </c:if>
                    <div class="d-flex justify-content-between mb-4">
                        <h5>Total:</h5>
                        <h5>
                            <c:choose>
                                <c:when test="${user != null && discountedAmount != null}">
                                    $<fmt:formatNumber value="${discountedAmount}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
                                </c:when>
                                <c:otherwise>
                                    $<fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
                                </c:otherwise>
                            </c:choose>
                        </h5>
                    </div>
                    <c:if test="${user == null}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle mr-2"></i>Log in to enjoy discounts on your order!
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validateFormGuest(form) {
        // Reset lại thông báo lỗi trước mỗi lần submit
        document.getElementById('fullNameError').innerHTML = '';
        document.getElementById('addressError').innerHTML = '';
        document.getElementById('phoneError').innerHTML = '';
        document.getElementById('emailError').innerHTML = '';
        let fullName = form.fullName.value.trim();
        let address = form.address.value.trim();
        let phone = form.phone.value.trim();
        let email = form.email.value.trim();
        let isValid = true;
        // Validate Full Name
        if (fullName === '') {
            document.getElementById('fullNameError').innerHTML = 'Full Name is required.';
            isValid = false;
        }
        // Validate Address
        if (address === '') {
            document.getElementById('addressError').innerHTML = 'Address is required.';
            isValid = false;
        }
        // Validate Phone (10-11 số và bắt đầu bằng số 0)
        const phonePattern = /^0\d{9,10}$/;
        if (phone === '') {
            document.getElementById('phoneError').innerHTML = 'Phone Number is required.';
            isValid = false;
        } else if (!phone.match(phonePattern)) {
            document.getElementById('phoneError').innerHTML = 'Phone Number must be 10-11 digits and start with 0.';
            isValid = false;
        }
        // Validate Email
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email === '') {
            document.getElementById('emailError').innerHTML = 'Email is required.';
            isValid = false;
        } else if (!email.match(emailPattern)) {
            document.getElementById('emailError').innerHTML = 'Invalid Email format.';
            isValid = false;
        }
        return isValid;
    }
    function validateFormUser(form) {
        // Reset lại thông báo lỗi trước mỗi lần submit
        document.getElementById('fullNameErrorLogin').innerHTML = '';
        document.getElementById('addressErrorLogin').innerHTML = '';
        document.getElementById('phoneErrorLogin').innerHTML = '';
        let fullName = form.fullName.value.trim();
        let address = form.address.value.trim();
        let phone = form.phone.value.trim();
        let isValid = true;
        // Validate Full Name
        if (fullName === '') {
            document.getElementById('fullNameErrorLogin').innerHTML = 'Full Name is required.';
            isValid = false;
        }
        // Validate Address
        if (address === '') {
            document.getElementById('addressErrorLogin').innerHTML = 'Address is required.';
            isValid = false;
        }
        // Validate Phone
        const phonePattern = /^0\d{9,10}$/;
        if (phone === '') {
            document.getElementById('phoneErrorLogin').innerHTML = 'Phone Number is required.';
            isValid = false;
        } else if (!phone.match(phonePattern)) {
            document.getElementById('phoneErrorLogin').innerHTML = 'Phone Number must be 10-11 digits and start with 0.';
            isValid = false;
        }
        return isValid;
    }

</script>
</body>
</html>