<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                <a href="${pageContext.request.contextPath}/pages/Home.jsp" class="me-3 text-dark text-decoration-none">Home</a>
                <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="me-3 text-dark text-decoration-none">Product</a>
                <a href="${pageContext.request.contextPath}/pages/Login.jsp" class="me-3 text-dark text-decoration-none">Login</a>
                <a href="${pageContext.request.contextPath}/pages/SignUp.jsp" class="text-dark text-decoration-none">Signup</a>
            </nav>
        </div>
    </header>

    <!-- Login Form -->
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow" style="width: 25rem;">
            <h3 class="text-center">Log In</h3>

            <!-- Error Message Display -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/LogInController" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="Email"
                           placeholder="user@example.com">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="Password">
                </div>
                <button type="submit" class="btn btn-primary w-100">Log In</button>
            </form>
        </div>
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
