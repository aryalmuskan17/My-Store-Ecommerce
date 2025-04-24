<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- Header -->
<header class="bg-light shadow-sm">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center text-decoration-none">
            <img src="../images/logo.png" alt="Logo" style="height: 40px;">
        </a>
        <nav>
            <a href="${pageContext.request.contextPath}/pages/Home.jsp" class="me-3 text-dark text-decoration-none">Home</a>
            <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="me-3 text-dark text-decoration-none">Product</a>
            <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="me-3 text-dark text-decoration-none">Profile</a>

            <!-- Logout Form -->
            <form action="${pageContext.request.contextPath}/LogOutController" method="post" style="display:inline;">
                <button type="submit" class="btn btn-link text-dark text-decoration-none">Logout</button>
            </form>
        </nav>
    </div>
</header>

<div class="container mt-5">
    <h2>Your Profile</h2>
    
    <!-- Display the message -->
    <c:if test="${not empty requestScope.updateMessage}">
        <div class="alert alert-info">
            <c:out value="${requestScope.updateMessage}" />
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/ProfileUpdateController" method="post">
        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="${sessionScope.userWithSession.name}" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.userWithSession.email}" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.userWithSession.phone}" required>
        </div>

        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" value="${sessionScope.userWithSession.address}" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Profile</button>
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
