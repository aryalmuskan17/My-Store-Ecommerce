<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Redirect to login if no user is in session -->
<c:if test="${empty sessionScope.userWithSession}">
    <c:redirect url="Login.jsp" />
</c:if>

<!-- Redirect to Dashboard if role is not customer -->
<c:if test="${sessionScope.userWithSession.role ne 'customer'}">
    <c:redirect url="Dashboard.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- Welcome Message -->
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
                Welcome to My Store. We're glad to see you again. <br>
                Browse your favorite products, check your orders, and discover the latest deals all in one place.
            </p>
        </div>
    </div>

    <!-- User Role -->
    <div class="row mt-3">
        <div class="col-12 text-center">
            <p>Your Role: <strong><c:out value="${sessionScope.userWithSession.role}" /></strong></p>
        </div>
    </div>

    <!-- Customer Actions -->
    <div class="row mt-4 text-center">
        <div class="col-md-4 mb-3">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Shop Products</h5>
                    <p class="card-text">Explore our latest collection and special offers.</p>
                    <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="btn btn-primary">Browse Products</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">My Orders</h5>
                    <p class="card-text">Track your order history and status.</p>
                    <a href="${pageContext.request.contextPath}/CartServlet" class="btn btn-primary">View Orders</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">My Profile</h5>
                    <p class="card-text">Manage your profile and personal information.</p>
                    <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="btn btn-primary">Go to Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Logout -->
<div class="container mt-4 text-center">
    <form action="${pageContext.request.contextPath}/LogOutController" method="post" class="d-inline-block">
        <button type="submit" class="btn btn-danger">Log Out</button>
    </form>
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
