<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.userWithSession || sessionScope.userWithSession.role ne 'admin'}">
    <c:redirect url="Login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Product Management</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.productId}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.stock}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/EditProductController?productId=${product.productId}" class="btn btn-warning btn-sm">Edit</a>
                    <form action="${pageContext.request.contextPath}/DeleteProductController" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" class="btn btn-danger btn-sm"
                                onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
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

</body>
</html>
