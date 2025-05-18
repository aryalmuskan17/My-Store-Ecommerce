<%@ include file="navbar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Your Shopping Cart and Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>
    <div class="container my-4">
        <h1>Your Shopping Cart</h1>

        <!-- Cart items -->
        <c:choose>
            <c:when test="${empty cartItems}">
                <p>Your cart is empty.</p>
                <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="btn btn-primary">Continue Shopping</a>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td>
                                        <form action="<c:url value='/CartServlet' />" method="post" class="d-flex align-items-center gap-2">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="cart_item_id" value="${item.cartItemId}" />
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control form-control-sm" style="width: 70px;" required />
                                            <button type="submit" class="btn btn-sm btn-primary">Update</button>
                                        </form>
                                    </td>
                                    <td>Rs.${item.price}</td>
                                    <td>Rs.${item.price * item.quantity}</td>
                                    <td>
                                        <form action="<c:url value='/CartServlet' />" method="post" onsubmit="return confirm('Are you sure you want to remove this item from the cart?');">
                                            <input type="hidden" name="action" value="remove" />
                                            <input type="hidden" name="cart_item_id" value="${item.cartItemId}" />
                                            <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <a href="${pageContext.request.contextPath}/CheckoutServlet" class="btn btn-success mt-3">Proceed to Checkout</a>
            </c:otherwise>
        </c:choose>

        <hr class="my-5" />

        <h2>Your Order History</h2>

        <c:choose>
            <c:when test="${empty orders}">
                <p>You have no past orders.</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Order ID</th>
                                <th>Order Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td>Rs.${order.totalAmount}</td>
                                    <td>${order.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="bg-light text-center text-muted py-3 mt-5">
        <div class="container">
            &copy; 2025 My Store. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
