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

<div class="categories">
    <a class="category" href="?query=${query}">Tất cả (${products.size()})</a>
    <c:forEach items="${categoryCounts}" var="category">
        <c:if test="${category.key != 'all'}">
            <a class="category" href="?query=${query}&category=${category.key}">
                    ${category.key} (${category.value})
            </a>
        </c:if>
    </c:forEach>
</div>


<div class="container">
    <div class="product">
        <c:forEach items="${products}" var="product">
            <div data-id="${product.id}" class="item">
                <img src="${product.images[0].url}" alt="${product.productName}">
                <div class="item-info">
                    <h2>${product.productName}</h2>
                    <div class="price">$${product.price}</div>
                    <div class="detail">
                        <p>RAM: ${product.ram}</p>
                        <p>Danh mục: ${product.productCategory.categoryName}</p>
                    </div>
                    <div class="buttons">
                        <button class="buyNow bg-primary">Mua ngay</button>
                        <button class="addCart bg-warning">Thêm vào giỏ</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="searchFooter.jsp" />
