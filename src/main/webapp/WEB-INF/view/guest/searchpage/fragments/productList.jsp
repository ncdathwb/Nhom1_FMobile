<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 21/09/2024
  Time: 4:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="searchResults">
    <c:choose>
        <c:when test="${not empty products}">
            <div class = "row title mb-5">
                <h1></h1>
            </div>
            <div class = "row">
                <div class="listProduct">
                    <c:forEach items="${products}" var="product">
                        <div data-id="${product.id}" class="item">
                            <img src="${product.images[0].url}">
                            <h2>${product.productName}</h2>
                            <div class="price">$${product.price}</div>
                            <div class="detail">
                                <p>Chip: ${product.description}</p>
                                <p>RAM: ${product.ram}</p>
                                <p>Color: ${product.color}</p>
                            </div>
                            <div class="row">
                                <button class="buyNow bg-primary">Buy Now</button>
                                <button class="addCart bg-warning">Add To Cart</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <p>Không có sản phẩm phù hợp với bộ lọc.</p>
        </c:otherwise>
    </c:choose>
</div>
