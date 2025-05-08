<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Redirect if session is missing or user is not admin -->
<c:if test="${empty sessionScope.userWithSession}">
    <c:redirect url="Login.jsp" />
</c:if>
<c:if test="${sessionScope.userWithSession.role ne 'admin'}">
    <c:redirect url="CustomerDashboard.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            <p class="lead">Welcome to My Store. We're glad to see you again. <br>Manage your products, oversee customer orders, and track the latest sales trends all in one place.</p>
        </div>
    </div>

    <!-- User Role -->
    <div class="row mt-3">
        <div class="col-12 text-center">
            <p>Your Role: <strong><c:out value="${sessionScope.userWithSession.role}" /></strong></p>
        </div>
    </div>
</div>

<div class="container mt-5">
    <!-- Product Management Section -->
    <div class="row mt-5">
        <div class="col-md-10 mx-auto">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0">Product Management</h4>
                </div>
                <div class="card-body">
                    <h3>Add a New Product</h3>
                    <p>Click the button below to open the product form.</p>
                    <a href="${pageContext.request.contextPath}/pages/AddProduct.jsp" class="btn btn-success mt-2">Add Product</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Profile & Logout Form (Added Profile Link) -->
<div class="container mt-5 text-center">
    <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="btn btn-info me-3">Profile</a>
	<a href="${pageContext.request.contextPath}/UserViewController" class="btn btn-info me-3">Manage Users</a>
	<a href="${pageContext.request.contextPath}/ProductViewController" class="btn btn-info me-3">Manage Products</a>
	<a href="${pageContext.request.contextPath}/ViewOrdersServlet" class="btn btn-info me-3">Manage Orders</a>
    <form action="${pageContext.request.contextPath}/LogOutController" method="post" class="d-inline-block">
        <button type="submit" class="btn btn-danger">Log Out</button>
    </form>
</div>

<!-- Footer -->
<footer class="bg-light text-center text-muted py-3 mt-5">
    <div class="container">
        &copy; 2025 My Store. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
