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
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h2 class="mb-0">Edit Product</h2>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/EditProductController" method="post">
                        <input type="hidden" name="productId" value="${productToEdit.productId}" />

                        <div class="mb-3">
                            <label class="form-label">Product Name:</label>
                            <input type="text" name="name" class="form-control" value="${productToEdit.name}" required />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description:</label>
                            <textarea name="description" class="form-control" rows="3" required>${productToEdit.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Price:</label>
                            <input type="number" name="price" class="form-control" value="${productToEdit.price}" step="0.01" required />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Stock Quantity:</label>
                            <input type="number" name="stock" class="form-control" value="${productToEdit.stock}" required />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Brand ID:</label>
                            <input type="number" name="brandId" class="form-control" value="${productToEdit.brandId}" required />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Image URL:</label>
                            <input type="text" name="imageUrl" class="form-control" value="${productToEdit.imageUrl}" />
                        </div>

                        <c:if test="${not empty productToEdit.imageUrl}">
                            <div class="mb-4 text-center">
                                <label class="form-label">Current Image:</label><br/>
                                <img src="${productToEdit.imageUrl}" alt="Product Image" class="img-thumbnail" style="max-height: 200px;" />
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-success">Update Product</button>
                            <a href="${pageContext.request.contextPath}/ProductViewController" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Footer -->
            <footer class="text-center text-muted py-3 mt-4">
                &copy; 2025 My Store. All rights reserved.
            </footer>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
