<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/09/2024
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="searchHeader.jsp" />


<div class="container">
    <header>
        <div class="title">
            <h1>Result: ${results} products</h1>
        </div>
    </header>
    <div class="product listAllProduct">
        <c:forEach items="${products}" var="product">
            <c:if test="${product.productCategory.id == 1 || product.productCategory.id == 2 || product.productCategory.id == 3}">
                <div data-id="${product.id}" class="item">
                    <img src="${product.images[0].url}" alt="">
                    <h2>${product.productName}</h2>
                    <div class="price">$${product.price}</div>
                    <div class="detail">
                        <p>${product.description}</p>
                        <p>RAM: ${product.ram}</p>
                        <c:if test="${not empty product.color}">
                            <p>Màu sắc: ${product.color}</p>
                        </c:if>
                    </div>
                    <div class="row">
                        <button class="buyNow bg-primary">Buy Now</button>
                        <button class="addCart bg-warning">Add To Cart</button>
                    </div>
                </div>
            </c:if>

            <!-- Nếu productCategory.id là 4 -->
            <c:if test="${product.productCategory.id == 4}">
                <div data-id="${product.id}" class="item">
                    <img src="${product.images[0].url}" alt="">
                    <h2>${product.productName}</h2>
                    <div class="price">$${product.price}</div>
                    <div class="detail">
                        <p>${product.description}</p>
                    </div>
                    <div class="row">
                        <button class="buyNow bg-primary">Buy Now</button>
                        <button class="addCart bg-warning">Add To Cart</button>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="row">
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


<jsp:include page="searchFooter.jsp" />
