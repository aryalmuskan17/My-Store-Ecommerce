<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>About Us - My Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container my-5">
    <div class="bg-white rounded-4 shadow-sm p-5">
        <h1 class="text-primary fw-bold mb-4 text-center">About Us</h1>

        <p class="fs-5 text-secondary mb-4">
            Welcome to <strong>My Store</strong>, your premier destination for the latest and most innovative smartphones. We are committed to providing an exceptional online shopping experience, featuring a carefully curated selection of top-tier mobile devices from trusted brands worldwide.
        </p>
        <p class="fs-5 text-secondary mb-4">
            Since our inception in 2021, My Store has focused on quality, reliability, and customer satisfaction. Our passion for technology and dedication to excellence drive us to continually expand and improve our offerings.
        </p>
        <p class="fs-5 text-secondary mb-5">
            We invite you to explore our collection and experience seamless shopping backed by expert customer support. Should you have any inquiries or feedback, please feel free to reach out to us.
        </p>

        <h2 class="text-center mb-5 fw-semibold">Meet Our Team</h2>
        <div class="row justify-content-center gy-4">
            <div class="col-md-4 d-flex flex-column align-items-center text-center">
                <img src="${pageContext.request.contextPath}/images/team-member1.jpg" alt="Muskan Aryal" class="rounded-circle shadow-sm mb-3" style="width:150px; height:150px; object-fit:cover;">
                <h5 class="fw-semibold mb-1">Muskan Aryal</h5>
                <p class="text-muted mb-0">Founder &amp; CEO</p>
            </div>
            <div class="col-md-4 d-flex flex-column align-items-center text-center">
                <img src="${pageContext.request.contextPath}/images/team-member2.jpg" alt="Shishir Paudel" class="rounded-circle shadow-sm mb-3" style="width:150px; height:150px; object-fit:cover;">
                <h5 class="fw-semibold mb-1">Shishir Paudel</h5>
                <p class="text-muted mb-0">Marketing Head</p>
            </div>
            <div class="col-md-4 d-flex flex-column align-items-center text-center">
                <img src="${pageContext.request.contextPath}/images/team-member3.jpg" alt="Suyog Subedi" class="rounded-circle shadow-sm mb-3" style="width:150px; height:150px; object-fit:cover;">
                <h5 class="fw-semibold mb-1">Suyog Subedi</h5>
                <p class="text-muted mb-0">Product Manager</p>
            </div>
            <div class="col-md-4 d-flex flex-column align-items-center text-center">
                <img src="${pageContext.request.contextPath}/images/team-member4.jpg" alt="Pujan Jung Thapa" class="rounded-circle shadow-sm mb-3" style="width:150px; height:150px; object-fit:cover;">
                <h5 class="fw-semibold mb-1">Pujan Jung Thapa</h5>
                <p class="text-muted mb-0">Lead Designer</p>
            </div>
            <div class="col-md-4 d-flex flex-column align-items-center text-center">
                <img src="${pageContext.request.contextPath}/images/team-member5.jpg" alt="Pratik Chettri" class="rounded-circle shadow-sm mb-3" style="width:150px; height:150px; object-fit:cover;">
                <h5 class="fw-semibold mb-1">Pratik Chettri</h5>
                <p class="text-muted mb-0">Customer Relations</p>
            </div>
        </div>
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
