<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String search = request.getParameter("search") != null ? request.getParameter("search") : "";
    String brandFilter = request.getParameter("brand") != null ? request.getParameter("brand") : "";
    String sortBy = request.getParameter("sort") != null ? request.getParameter("sort") : "";

    String query = "SELECT p.*, b.brand_name FROM Product p JOIN Brand b ON p.brand_id = b.brand_id WHERE 1=1";
    if (!search.isEmpty()) {
        query += " AND p.product_name LIKE '%" + search + "%'";
    }
    if (!brandFilter.isEmpty()) {
    	query += " AND LOWER(b.brand_name) = '" + brandFilter.toLowerCase() + "'";
    }
    if (sortBy.equals("price_asc")) {
        query += " ORDER BY p.price ASC";
    } else if (sortBy.equals("price_desc")) {
        query += " ORDER BY p.price DESC";
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mystore", "root", "");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smartphones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- Bootstrap Header -->
<header class="bg-light shadow-sm mb-4">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center text-decoration-none">
            <img src="../images/logo.png" alt="Logo" style="height: 40px;">
        </a>
        <nav>
            <a href="${pageContext.request.contextPath}/pages/Home.jsp" class="me-3 text-dark text-decoration-none">Home</a>
            <a href="${pageContext.request.contextPath}/pages/Product.jsp" class="me-3 text-dark text-decoration-none">Products</a>
            <a href="${pageContext.request.contextPath}/pages/Login.jsp" class="me-3 text-dark text-decoration-none">Login</a>
            <a href="${pageContext.request.contextPath}/pages/SignUp.jsp" class="text-dark text-decoration-none">Signup</a>
        </nav>
    </div>
</header>

<div class="container mb-4">
    <!-- Search and Filter Form -->
    <form method="get" action="${pageContext.request.contextPath}/pages/Product.jsp" class="row g-3 align-items-center">
        <div class="col-md-4">
            <input type="text" class="form-control" name="search" placeholder="Search..." value="<%= search %>" />
        </div>
        <div class="col-md-3">
            <select name="brand" class="form-select">
                <option value="">All Brands</option>
                <option value="Apple" <%= brandFilter.equals("Apple") ? "selected" : "" %>>Apple</option>
                <option value="Samsung" <%= brandFilter.equals("Samsung") ? "selected" : "" %>>Samsung</option>
                <option value="OnePlus" <%= brandFilter.equals("OnePlus") ? "selected" : "" %>>OnePlus</option>
                <option value="Xiaomi" <%= brandFilter.equals("Xiaomi") ? "selected" : "" %>>Xiaomi</option>
            </select>
        </div>
        <div class="col-md-3">
            <select name="sort" class="form-select">
                <option value="">Sort By</option>
                <option value="price_asc" <%= sortBy.equals("price_asc") ? "selected" : "" %>>Price: Low to High</option>
                <option value="price_desc" <%= sortBy.equals("price_desc") ? "selected" : "" %>>Price: High to Low</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Apply</button>
        </div>
    </form>
</div>

<!-- Product Cards -->
<div class="container">
    <div class="row">
        <%
            while (rs.next()) {
        %>
        <div class="col-md-4">
            <div class="product-card shadow-sm rounded">
                <img src="<%= rs.getString("image_url") %>" alt="Image" class="product-img mb-2">
                <h5><%= rs.getString("product_name") %></h5>
                <p><strong>Brand:</strong> <%= rs.getString("brand_name") %></p>
                <p><strong>Price:</strong> Rs. <%= rs.getInt("price") %></p>
                <p><%= rs.getString("description") %></p>
                <form action="AddToCartServlet" method="post" class="d-flex">
                    <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>" />
                    <input type="number" name="quantity" value="1" min="1" class="form-control me-2" style="width: 80px;" />
                    <button type="submit" class="btn btn-success">Add to Cart</button>
                </form>
            </div>
        </div>
        <%
            }
            conn.close();
        %>
    </div>
</div>

<!-- Footer -->
<footer class="bg-light text-center text-muted py-3 mt-4">
    <div class="container">
        &copy; 2025 My Store. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
