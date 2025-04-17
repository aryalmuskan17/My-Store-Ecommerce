<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<!-- Header -->
<header class="bg-light shadow-sm">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center text-decoration-none">
            <img src="../images/logo.png" alt="Logo" style="height: 40px;">
        </a>
        <!-- Navigation Links -->
        <nav>
            <a href="${pageContext.request.contextPath}/" class="me-3 text-dark text-decoration-none">Home</a>
            <a href="${pageContext.request.contextPath}/pages/products" class="me-3 text-dark text-decoration-none">Product</a>
            <a href="${pageContext.request.contextPath}/pages/Login.jsp" class="me-3 text-dark text-decoration-none">Login</a>
            <a href="${pageContext.request.contextPath}/pages/SignUp.jsp" class="text-dark text-decoration-none">Signup</a>
        </nav>
    </div>
</header>

<div class="container mt-5">
    <div class="row">
        <div class="col-12 text-center">
            <h1>
                Welcome, <c:out value="${sessionScope.userWithSession.name}" />!
            </h1>
            <p class="lead">Welcome to My Store. We are glad to have you here. Explore the products and services we offer!</p>
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

<!-- Logout -->
<div class="container mt-5 text-center">
    <form action="LogOutController" method="post">
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
