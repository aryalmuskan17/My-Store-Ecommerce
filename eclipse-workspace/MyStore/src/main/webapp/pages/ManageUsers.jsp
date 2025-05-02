<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Redirect if session is missing or user is not admin -->
<c:if test="${empty sessionScope.userWithSession}">
    <c:redirect url="Login.jsp" />
</c:if>
<c:if test="${sessionScope.userWithSession.role ne 'admin'}">
    <c:redirect url="CustomerDashboard.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- Content -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">User Management</h2>

    <!-- Error Message if any -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.role}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/UserDeleteController" method="post" style="display:inline-block;">
                        <input type="hidden" name="userId" value="${user.userId}">
                        <button class="btn btn-danger btn-sm" type="submit"
                                onclick="return confirm('Are you sure you want to delete this user?')">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
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
