<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16/9/2024
  Time: 1:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Your Cart</title>
</head>
<body>
<h1>Your Cart</h1>
<c:if test="${empty cart}">
    <p>Your cart is empty.</p>
</c:if>
<c:if test="${not empty cart}">
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="entry" items="${cart}">
            <tr>
                <td>${entry.key.name}</td>
                <td>${entry.value}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>
</body>
</html>
