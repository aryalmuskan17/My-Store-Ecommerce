<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- SIGNUP FORM -->
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow" style="width: 28rem;">
            <h3 class="text-center mb-3">Sign Up</h3>

            <c:if test="${not empty message}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/SignUpController" method="post" onsubmit="return validatePasswords()">
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phone" name="phone" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Retype Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <div id="passwordError" class="text-danger mb-2" style="display:none;">Passwords do not match!</div>
                <button type="submit" class="btn btn-success w-100">Sign Up</button>
            </form>
        </div>
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
    
    <!-- ✅ Simple JS Validation -->
    <script>
        function validatePasswords() {
            var pass1 = document.getElementById("password").value;
            var pass2 = document.getElementById("confirmPassword").value;
            if (pass1 !== pass2) {
                document.getElementById("passwordError").style.display = "block";
                return false;
            } else {
                document.getElementById("passwordError").style.display = "none";
                return true;
            }
        }
    </script>
</body>
</html>
