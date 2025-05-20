<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Order Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Order Details</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <c:if test="${not empty order}">
        <div class="card mb-4">
            <div class="card-header">
                <strong>Order ID:</strong> ${order.orderId}
            </div>
            <div class="card-body">
                <p><strong>Customer Name:</strong> ${order.userName}</p>
                <p><strong>Order Date:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></p>
                <p><strong>Total Amount:</strong> Rs.${order.totalAmount}</p>
                <p><strong>Status:</strong> ${order.status}</p>
            </div>
        </div>

        <h4>Ordered Items</h4>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price (each)</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${orderItems}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${item.productName}</td>
                        <td>${item.quantity}</td>
                        <td>Rs.${item.price}</td>
                        <td>Rs.${item.price * item.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

 <c:choose>
    <c:when test="${sessionScope.userWithSession.role ne 'admin'}">
        <a href="${pageContext.request.contextPath}/CartServlet" class="btn btn-secondary">Back to Cart</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/ViewOrdersServlet" class="btn btn-secondary">Back to Orders</a>
    </c:otherwise>
</c:choose>
        
    </c:if>
</div>

<!-- Footer Section -->
<footer class="bg-light text-center text-muted py-3 mt-4">
    <div class="container">
        <div class="mb-2">
            <a href="${pageContext.request.contextPath}/pages/AboutUs.jsp" class="text-decoration-none text-muted me-3">About Us</a>
            <a href="${pageContext.request.contextPath}/pages/ContactUs.jsp" class="text-decoration-none text-muted">Contact Us</a>
        </div>
        &copy; 2025 My Store. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
