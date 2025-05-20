<%@ include file="navbar.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>My Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }
        .product-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 280px;
            margin: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }
        .product-card h3 {
            font-size: 20px;
            margin-top: 15px;
            font-weight: 600;c
        }
        .product-card p {
            font-size: 14px;
            color: #555;
            margin-top: 10px;
        }
        .product-card .price {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
            color: #2ecc71;
        }
        .product-card .btn {
            margin-top: 15px;
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            font-size: 16px;
        }
        .product-card .btn:hover {
            background-color: #0056b3;
        }
        .explore-btn {
            margin-top: 30px;
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 15px;
            font-size: 18px;
        }
        .explore-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<!-- Welcome Message -->
<h1 class="text-center my-4">Welcome to My Store</h1>

<!-- Product Cards Section -->
<div class="container mb-4">
    <div class="row product-container">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mystore", "root", "");
                Statement stmt = con.createStatement();
                // Fetch 4 random products
                ResultSet rs = stmt.executeQuery("SELECT * FROM product ORDER BY RAND() LIMIT 4");

                while (rs.next()) {
        %>
                    <div class="col-md-4 col-sm-6">
                        <div class="product-card">
                            <img src="<%= rs.getString("image_url") %>" alt="Product Image" />
                            <h3><%= rs.getString("product_name") %></h3>
                            <p><%= rs.getString("description") %></p>
                            <div class="price">Rs. <%= rs.getDouble("price") %></div>
                        </div>
                    </div>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </div>
    <!-- Explore More Products Button -->
    <div class="text-center">
        <a href="Product.jsp" class="btn explore-btn">Explore More Products</a>
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
</body>
</html>
