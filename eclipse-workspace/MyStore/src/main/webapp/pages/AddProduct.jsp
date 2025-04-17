<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Smartphone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Header -->
<header class="bg-light shadow-sm">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center text-decoration-none">
            <img src="../images/logo.png" alt="Logo" style="height: 40px;">
        </a>
        <nav>
            <a href="${pageContext.request.contextPath}/" class="me-3 text-dark text-decoration-none">Home</a>
            <a href="${pageContext.request.contextPath}/pages/products" class="me-3 text-dark text-decoration-none">Product</a>
            <a href="${pageContext.request.contextPath}/pages/Login.jsp" class="me-3 text-dark text-decoration-none">Login</a>
            <a href="${pageContext.request.contextPath}/pages/SignUp.jsp" class="text-dark text-decoration-none">Signup</a>
        </nav>
    </div>
</header>

<!-- Add Smartphone Form -->
<div class="container my-5">
    <h2 class="mb-4 text-center">Add New Smartphone</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/AddProductServlet" method="post" class="shadow p-4 rounded bg-white mx-auto" style="max-width: 600px;">
        <div class="mb-3">
            <label for="productName" class="form-label">Smartphone Name</label>
            <input type="text" class="form-control" id="productName" name="name" required placeholder="e.g., iPhone 15 Pro Max">
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="2" required></textarea>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price (NPR)</label>
            <input type="number" class="form-control" id="price" name="price" required placeholder="e.g., 180000">
        </div>

        <div class="mb-3">
            <label for="stockQuantity" class="form-label">Stock Quantity</label>
            <input type="number" class="form-control" id="stockQuantity" name="stock" required placeholder="e.g., 5">
        </div>

        <div class="mb-3">
            <label for="imageUrl" class="form-label">Image URL</label>
            <input type="text" class="form-control" id="imageUrl" name="imageUrl" placeholder="Paste image URL here">
        </div>

        <div class="mb-3">
            <label for="brandId" class="form-label">Brand</label>
            <select class="form-select" id="brandId" name="brandId" required>
                <option value="">-- Select Brand --</option>
                <option value="1">Apple</option>
                <option value="2">Samsung</option>
                <option value="3">OnePlus</option>
                <option value="4">Xiaomi</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Add Smartphone</button>
    </form>
</div>

<!-- Footer -->
<footer class="bg-light text-center text-muted py-3 mt-auto">
    <div class="container">
        &copy; 2025 My Store. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
