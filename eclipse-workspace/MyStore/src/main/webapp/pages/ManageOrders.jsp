<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="navbar.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Customer Orders</h2>

    <!-- Date Filter Form -->
    <form action="${pageContext.request.contextPath}/ViewOrdersServlet" method="get" class="row g-3 mb-4">
        <div class="col-auto">
            <label for="orderDate" class="col-form-label">Filter by Date:</label>
        </div>
        <div class="col-auto">
            <input type="date" name="orderDate" id="orderDate" class="form-control" value="${param.orderDate}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Filter</button>
            <a href="${pageContext.request.contextPath}/ViewOrdersServlet" class="btn btn-secondary">Clear</a>
        </div>
    </form>

    <c:if test="${empty orderList}">
        <div class="alert alert-info">No orders found.</div>
    </c:if>

    <c:if test="${not empty orderList}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>Date</th>
                    <th>Total (Rs.)</th>
                    <th>Status</th>
                    <th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <!-- Make Order ID clickable to go to order details -->
                        <td>
                            <a href="${pageContext.request.contextPath}/OrderDetailsServlet?orderId=${order.orderId}">
                                ${order.orderId}
                            </a>
                        </td>
                        <td>${order.userId}</td>
                        <td>${order.userName}</td>
                        <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                        <td>Rs. ${order.totalAmount}</td>
                        <td>${order.status}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/UpdateOrderStatusServlet" method="post" class="form-inline">
                                <input type="hidden" name="orderId" value="${order.orderId}" />
                                <select name="status" class="form-control me-2">
                                    <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                    <option value="Approved" ${order.status == 'Approved' ? 'selected' : ''}>Approved</option>
                                    <option value="Rejected" ${order.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                                </select>
                                <button type="submit" class="btn btn-success btn-sm">Update</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
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
