<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Bootstrap Header -->
<header class="bg-light shadow-sm mb-4">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <a href="${pageContext.request.contextPath}/pages/Home.jsp" class="d-flex align-items-center text-decoration-none">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" style="height: 40px;">
        </a>
        <nav class="d-flex align-items-center gap-3">
            <%
                String role = (String) session.getAttribute("role");
                String username = (String) session.getAttribute("username");

                if (username == null) {
            %>
                <!-- Guest Links -->
                <a href="${pageContext.request.contextPath}/pages/Home.jsp" class="me-3 text-dark text-decoration-none">Home</a>
                <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="me-3 text-dark text-decoration-none">Products</a>
                <a href="${pageContext.request.contextPath}/pages/Login.jsp" class="me-3 text-dark text-decoration-none">Login</a>
                <a href="${pageContext.request.contextPath}/pages/SignUp.jsp" class="text-dark text-decoration-none">Signup</a>

            <%
                } else if ("admin".equals(role)) {
            %>
                <!-- Admin Links -->
                <a href="${pageContext.request.contextPath}/pages/Dashboard.jsp" class="me-3 text-dark text-decoration-none">Dashboard</a>
                <a href="${pageContext.request.contextPath}/EditProductController" class="me-3 text-dark text-decoration-none">Products</a>
                <a href="${pageContext.request.contextPath}/pages/AddProduct.jsp" class="me-3 text-dark text-decoration-none">Add Product</a>
                <a href="${pageContext.request.contextPath}/UserViewController" class="me-3 text-dark text-decoration-none">Users</a>
                <a href="${pageContext.request.contextPath}/ViewOrdersServlet" class="me-3 text-dark text-decoration-none">Manage Orders</a>
                <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="me-3 text-dark text-decoration-none">Profile</a>
                <span class="me-3 text-dark">Welcome, <%= username %></span>
                <a href="${pageContext.request.contextPath}/LogOutController" class="text-dark text-decoration-none">Logout</a>

            <%
                } else if ("customer".equals(role)) {
            %>
                <!-- Customer Links -->
                <a href="${pageContext.request.contextPath}/pages/CustomerDashboard.jsp" class="me-3 text-dark text-decoration-none">Dashboard</a>
                <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="me-3 text-dark text-decoration-none">Products</a>
                <a href="${pageContext.request.contextPath}/pages/Profile.jsp" class="me-3 text-dark text-decoration-none">Profile</a>
                <span class="me-3 text-dark">Welcome, <%= username %></span>
                <a href="${pageContext.request.contextPath}/LogOutController" class="text-dark text-decoration-none">Logout</a>
            <%
                }
            %>
        </nav>
    </div>
</header>
