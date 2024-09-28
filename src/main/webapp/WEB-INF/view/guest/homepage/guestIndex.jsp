<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="guestHeader.jsp"/>

<%--NEW MOBILE--%>
<div class="container">
    <header>
        <div class="title">NEW MOBILE</div>
    </header>
    <div class="product newMobile">
        <c:forEach items="${newestMobileProducts}" var="newMobile">
            <div data-id = ${newMobile.id} class="item">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/client/productsDetail/${newMobile.id}"> <!-- Liên kết hình ảnh đến trang chi tiết sản phẩm -->
                                <img src="${newMobile.images[0].url}" alt="">
                            </a>
                        </div>
                        <div class="col-md-6 p-4">
                            <h2>${newMobile.productName}</h2>
                            <div class="price">$${newMobile.price}</div>
                            <div class="detail">
                                <p>Chip: ${newMobile.description}</p>
                                <p>RAM: ${newMobile.ram}</p>
                                <p>Color: ${newMobile.color}</p>
                            </div>
                            <div class="row">
                                <button class="buyNow bg-primary">Buy Now</button>
                                <button class="addCart bg-warning">Add To Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%--BEST-SELLING--%>
<div class="container">
    <header>
        <div class="title">BEST-SELLING</div>
    </header>
    <div class="listProduct">
        <c:forEach items="${bestSellingMobileProducts}" var="bestSellingMobile">
            <div data-id = ${bestSellingMobile.id} class="item">
                <a href="${pageContext.request.contextPath}/client/productsDetail/${bestSellingMobile.id}">
                    <img src="${bestSellingMobile.images[0].url}" alt="">
                </a>
                <h2>${bestSellingMobile.productName}</h2>
                <div class="price">$${bestSellingMobile.price}</div>
                <div class="detail">
                    <p>Chip: ${bestSellingMobile.description} </p>
                    <p>RAM: ${bestSellingMobile.ram}</p>
                    <p>Color: ${bestSellingMobile.color}</p>
                </div>
                <div class="row">
                    <button class="buyNow bg-primary">Buy Now</button>
                    <button class="addCart bg-warning">Add To Cart</button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%--TABLET--%>
<div class="container">
    <header>
        <div class="title">TABLET</div>
    </header>
    <div class="product tablet">
        <c:forEach items="${tabletProducts}" var="tablet">
            <div data-id= ${tablet.id} class="item">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/client/productsDetail/${tablet.id}"> <!-- Liên kết hình ảnh đến trang chi tiết sản phẩm -->
                                <img src="${tablet.images[0].url}" alt="">
                            </a>
                        </div>
                        <div class="col-md-6 p-4">
                            <h2>${tablet.productName}</h2>
                            <div class="price">$${tablet.price}</div>
                            <div class="detail">
                                <p>Chip: ${tablet.description}</p>
                                <p>RAM: ${tablet.ram}</p>
                                <p>Color: ${tablet.color}</p>
                            </div>
                            <div class="row">
                                <button class="buyNow bg-primary">Buy Now</button>
                                <button class="addCart bg-warning">Add To Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<jsp:include page="guestFooter.jsp"/>