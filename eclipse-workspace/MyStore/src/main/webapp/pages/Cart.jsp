<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h1>Your Shopping Cart</h1>
    
    <!-- Check if the cart is empty -->
    <c:if test="${empty cartItems}">
        <p>Your cart is empty.</p>
        <a href="${pageContext.request.contextPath}/pages/Product.jsp">Continue Shopping</a>
    </c:if>

    <!-- If cart has items, display them -->
    <c:if test="${not empty cartItems}">
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through cart items -->
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>${item.productName}</td>  <!-- Display product name -->
                            <td>
                                <!-- Form for updating quantity -->
                                <form action="<c:url value='/CartServlet' />" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="cart_item_id" value="${item.cartItemId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" required>
                                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                </form>
                            </td>
                            <td>${item.price}</td>  <!-- Display price per product -->
                            <td>${item.price * item.quantity}</td>  <!-- Total price for this item -->
                            <td>
                                <!-- Provide action buttons like remove from cart -->
                                <form action="<c:url value='/CartServlet' />" method="post">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cart_item_id" value="${item.cartItemId}">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to remove this item from the cart?')">
                                        Remove
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/CheckoutServlet" class="btn btn-success">Proceed to Checkout</a>
    </c:if>

    <!-- Footer Section -->
    <footer class="bg-light text-center text-muted py-3 mt-4">
        <div class="container">
            &copy; 2025 My Store. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
