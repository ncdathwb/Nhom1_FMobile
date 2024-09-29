
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="searchHeader.jsp" />
<div class="container">
    <div class="row">
        <div class="col-3">
            <div class="filter-container">
                <div class="row">
                    <label>BRAND</label>
                    <div class="row brand-container">
                        <c:forEach items="${['Apple', 'Samsung', 'Xiaomi', 'Oppo', 'Huawei', 'Vivo', 'Realme', 'Dell', 'Asus', 'HP', 'Acer', 'Lenovo', 'MSI']}" var="brand">
                            <div class="col-4">
                                <input type="checkbox" class="brand-checkbox" name="brand" value="${brand}" id="brand-${brand}">
                                <label for="brand-${brand}">
                                    <img src="/images/product/${brand}.png">
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="row">
                    <label>PRICE</label>
                    <div class="row price-container">
                        <div class="col-6">
                            <input type="checkbox" class="price-checkbox" data-min="0" data-max="200" id="price-0-200">
                            <label for="price-0-200">Under 200$</label>
                        </div>
                        <div class="col-6">
                            <input type="checkbox" class="price-checkbox" data-min="200" data-max="400" id="price-200-400">
                            <label for="price-200-400">200 - 400$</label>
                        </div>
                        <div class="col-6">
                            <input type="checkbox" class="price-checkbox" data-min="400" data-max="700" id="price-400-700">
                            <label for="price-400-700">400 - 700$</label>
                        </div>
                        <div class="col-6">
                            <input type="checkbox" class="price-checkbox" data-min="700" data-max="1000" id="price-700-1000">
                            <label for="price-700-1000">700 - 1000$</label>
                        </div>
                        <div class="col-6">
                            <input type="checkbox" class="price-checkbox" data-min="1000" data-max="9999999999" id="price-1000-9999999999">
                            <label for="price-1000-9999999999">Above 1000$</label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <label>RAM</label>
                    <div class="row ram-container">
                        <c:forEach items="${['4GB', '6GB', '8GB', '12GB', '16GB']}" var="ram">
                            <div class="col-3">
                                <input type="checkbox" class="ram-checkbox" name="ram" value="${ram}" id="ram-${ram}">
                                <label for="ram-${ram}">${ram}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-9">
            <div class="container">
                <input id ="productCategory" type="hidden" name="productCategory" value = "3">
                <div id="filterProductResults" data-total="${totalProducts}">
                    <!-- Danh sách sản phẩm khi Filter-->
                </div>
                <div id="searchProductResults">
                    <div class="row title mb-5">
                        <h1>Result: ${results} products</h1>
                    </div>
                    <div class="row" >
                        <div class="listProduct">
                            <!-- Nơi hiển thị kết quả sản phẩm khi Search -->
                            <c:forEach items="${products}" var="products">
                                <div data-id=${products.id} class="item">
                                    <img src="${products.images[0].url}" alt="">
                                    <h2>${products.productName}</h2>
                                    <div class="price">$${products.price}</div>
                                    <div class="detail">
                                        <p>${products.description}</p>
                                        <p>RAM: ${products.ram}</p>
                                        <c:if test="${not empty products.color}">
                                            <p>Màu sắc: ${products.color}</p>
                                        </c:if>
                                    </div>
                                    <div class="row">
                                        <button class="buyNow bg-primary">Buy Now</button>
                                        <button class="addCart bg-warning">Add To Cart</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class ="row">
                        <div class="hpagination">
                            <a href="?query=${param.query}&page=${currentPage - 1}"
                               class="prev ${currentPage == 0 ? 'disabled' : ''}">Previous</a>
                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <strong>${i + 1}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?query=${param.query}&page=${i}">${i + 1}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <a href="?query=${param.query}&page=${currentPage + 1}"
                               class="next ${currentPage >= totalPages - 1 ? 'disabled' : ''}">Next</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="searchFooter.jsp" />
