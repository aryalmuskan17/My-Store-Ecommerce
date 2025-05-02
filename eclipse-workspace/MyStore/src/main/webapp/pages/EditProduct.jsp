<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.userWithSession || sessionScope.userWithSession.role ne 'admin'}">
    <c:redirect url="Login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
 
<div class="container mt-5">
    <h2 class="text-center mb-4">Edit Product</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/EditProductController" method="post">
    <input type="hidden" name="productId" value="${productToEdit.productId}" />

        <div class="form-group">
            <label>Product Name:</label>
            <input type="text" name="name" class="form-control" value="${productToEdit.name}" required />
        </div>

        <div class="form-group">
            <label>Description:</label>
            <textarea name="description" class="form-control" required>${productToEdit.description}</textarea>
        </div>

        <div class="form-group">
            <label>Price:</label>
            <input type="number" name="price" class="form-control" value="${productToEdit.price}" step="0.01" required />
        </div>

        <div class="form-group">
            <label>Stock Quantity:</label>
            <input type="number" name="stock" class="form-control" value="${productToEdit.stock}" required />
        </div>

        <div class="form-group">
            <label>Brand ID:</label>
            <input type="number" name="brandId" class="form-control" value="${productToEdit.brandId}" required />
        </div>

        <div class="form-group">
            <label>Image URL:</label>
            <input type="text" name="imageUrl" class="form-control" value="${productToEdit.imageUrl}" />
        </div>

        <button type="submit" class="btn btn-primary">Update Product</button>
        <a href="${pageContext.request.contextPath}/ProductViewController" class="btn btn-secondary">Cancel</a>
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
