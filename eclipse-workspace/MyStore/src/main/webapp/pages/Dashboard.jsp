<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.mystore.model.Order" %>
<%@ page import="com.mystore.controller.dao.OrderDAO" %>

<c:if test="${empty sessionScope.userWithSession}">
    <c:redirect url="Login.jsp" />
</c:if>
<c:if test="${sessionScope.userWithSession.role ne 'admin'}">
    <c:redirect url="CustomerDashboard.jsp" />
</c:if>

<%
    // Instantiate DAO and fetch all orders
    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();

    // Reverse the list to have the most recent orders first
    Collections.reverse(orders);

    // Set the orders as a request attribute
    request.setAttribute("orders", orders);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
        .bg-soft-green { background-color: #4caf50; color: #f1f8e9; }
        .bg-soft-blue { background-color: #5a9bd5; color: #e8f0fe; }
        .bg-soft-yellow { background-color: #f0c674; color: #4a4a03; }
        .bg-soft-gray { background-color: #6c757d; color: #e9ecef; }
        .bg-soft-teal { background-color: #20a8a0; color: #d1f0f0; }
        .bg-soft-red { background-color: #d9534f; color: #f9d6d5; }
        .info-summary {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #444;
            text-align: left;
        }
        .info-summary p {
            margin: 0.25rem 0;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="row">
        <div class="col-12 text-center">
            <h1>
                Welcome,
                <c:if test="${not empty sessionScope.userWithSession}">
                    <c:out value="${sessionScope.userWithSession.name}" />
                </c:if>
                <c:if test="${empty sessionScope.userWithSession}">
                    Guest
                </c:if>
                !
            </h1>
            <p class="lead">
                Welcome to My Store. We're glad to see you again.<br />
                Manage your products, oversee customer orders, and track the latest sales trends all in one place.
            </p>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-12 text-center">
            <p>Your Role: <strong><c:out value="${sessionScope.userWithSession.role}" /></strong></p>
        </div>
    </div>
</div>

<div class="container mt-5">
    <div class="row g-4">
        <!-- Add Product Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-green">
                    <h4 class="mb-0">Product Management</h4>
                </div>
                <div class="card-body text-center">
                    <h5>Add a New Product</h5>
                    <p>Click the button below to open the product form.</p>
                    <a href="${pageContext.request.contextPath}/pages/AddProduct.jsp" class="btn btn-success">Add Product</a>

                    <div class="info-summary">
                        <p><strong>Products added this month:</strong> 15</p>
                        <p><strong>In stock:</strong> 80 items</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-blue">
                    <h4 class="mb-0">Profile</h4>
                </div>
                <div class="card-body text-center">
                    <p>View and update your profile information.</p>
                    <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="btn btn-primary">Go to Profile</a>

                    <div class="info-summary">
                        <p><strong>Name:</strong> <c:out value="${sessionScope.userWithSession.name}" /></p>
                        <p><strong>Email:</strong> <c:out value="${sessionScope.userWithSession.email}" /></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Manage Users Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-yellow">
                    <h4 class="mb-0">User Management</h4>
                </div>
                <div class="card-body text-center">
                    <p>Manage customer accounts and user details.</p>
                    <a href="${pageContext.request.contextPath}/UserViewController" class="btn btn-warning text-dark">Manage Users</a>

                    <div class="info-summary">
                        <p><strong>Total users:</strong> 5</p>
                        <p><strong>New users this week:</strong> 2</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Manage Products Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-gray">
                    <h4 class="mb-0">Product Management</h4>
                </div>
                <div class="card-body text-center">
                    <p>View, edit, or delete existing products.</p>
                    <a href="${pageContext.request.contextPath}/ProductViewController" class="btn btn-secondary">Manage Products</a>

                    <div class="info-summary">
                        <p><strong>Active products:</strong> 78</p>
                        <p><strong>Out of stock:</strong> 3</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Manage Orders Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-teal">
                    <h4 class="mb-0">Order Management</h4>
                </div>
                <div class="card-body text-center">
                    <p>Track and process customer orders.</p>
                    <a href="${pageContext.request.contextPath}/ViewOrdersServlet" class="btn btn-info">Manage Orders</a>

                    <div class="info-summary">
                        <p><strong>Recent Orders:</strong></p>
                        <ul class="list-unstyled">
                            <c:forEach var="order" items="${orders}" begin="0" end="2">
                                <li>
                                    Order #<c:out value="${order.orderId}" /> - 
                                    <c:out value="${order.userName}" /> - 
                                    Rs.<c:out value="${order.totalAmount}" /> - 
                                    <c:out value="${order.status}" />
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Logout Section -->
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-soft-red">
                    <h4 class="mb-0">Logout</h4>
                </div>
                <div class="card-body text-center">
                    <p>Securely log out from the admin dashboard.</p>
                    <form action="${pageContext.request.contextPath}/LogOutController" method="post">
                        <button type="submit" class="btn btn-danger">Log Out</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-light text-center text-muted py-3 mt-5">
    <div class="container">&copy; 2025 My Store. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
