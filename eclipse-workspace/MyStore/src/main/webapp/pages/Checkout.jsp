<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
</head>
<body>
    <!-- Main Container -->
    <div class="container mt-5">
        <h1 class="text-center mb-4">Checkout</h1>

        <!-- Cart Empty Message -->
        <c:if test="${empty cartItems}">
            <div class="alert alert-warning text-center">
                Your cart is empty. <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="btn btn-primary">Go back to shopping</a>

            </div>
        </c:if>

        <!-- Cart Details Form -->
        <c:if test="${not empty cartItems}">
            <form action="<c:url value='/CheckoutServlet' />" method="post">
                <!-- Shipping Details Card -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5>Shipping Details</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Address:</strong> ${user.address}</p>
                        <p><strong>Phone:</strong> ${user.phone}</p>
                    </div>
                </div>

                <!-- Order Summary Card -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5>Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <li class="list-group-item">
                                    ${item.productName} x ${item.quantity} = Rs. ${item.price * item.quantity}
                                </li>
                                <c:set var="total" value="${total + (item.price * item.quantity)}" />
                            </c:forEach>
                        </ul>
                        <p class="mt-3"><strong>Total Amount: Rs. ${total}</strong></p>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="btn btn-success btn-lg">Place Order</button>
                </div>
            </form>
        </c:if>

        <!-- Success Message -->
        <c:if test="${not empty success}">
            <div class="alert alert-success mt-4">
                <p style="color:green;">${success}</p>
            </div>
        </c:if>
    </div>

    <!-- Footer Section -->
    <footer class="bg-light text-center text-muted py-3 mt-4">
        <div class="container">
            &copy; 2025 My Store. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
