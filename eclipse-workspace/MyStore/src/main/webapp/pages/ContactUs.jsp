<%@ include file="navbar.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Contact Us - My Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container my-5">
    <div class="bg-white rounded-4 shadow-sm p-5">
        <h1 class="text-primary fw-bold mb-4 text-center">Contact Us</h1>

        <p class="fs-5 text-secondary mb-4 text-center">
            Have questions, feedback, or need assistance? We're here to help! Fill out the form below or reach us using the contact details provided.
        </p>

        <div class="row g-4">
            <!-- Contact Form -->
            <div class="col-md-6">
                <form id="contactForm" action="#" method="post" onsubmit="return showMessage(event)">
                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Your full name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Email address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label fw-semibold">Subject</label>
                        <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject of your message" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label fw-semibold">Message</label>
                        <textarea class="form-control" id="message" name="message" rows="5" placeholder="Write your message here..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary px-4">Send Message</button>
                </form>

                <!-- Success Message -->
                <div id="successMessage" class="alert alert-success mt-3" style="display:none;">
                    Message sent successfully
                </div>
            </div>

            <!-- Contact Details -->
            <div class="col-md-6">
                <h4 class="fw-semibold mb-3">Our Contact Information</h4>
                <p><strong>Address:</strong> Kunti Mall, Pirthivi Chowk-09, Pokhara</p>
                <p><strong>Phone:</strong> +977-9856024240</p>
                <p><strong>Email:</strong> mystore.pkr@gmail.com</p>

                <h5 class="mt-4 mb-3 fw-semibold">Business Hours</h5>
                <p>Sunday - Friday: 9:00 AM - 8:00 PM</p>
                <p>Saturday: 11:00 AM - 7:00 PM</p>

                <!-- Google Map Embed -->
                <div class="mt-4 rounded-3 overflow-hidden shadow-sm" style="height: 250px;">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3515.9695305713894!2d83.98473849999999!3d28.208238299999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x399595bef0f12907%3A0x3cb45d4e56a81def!2sMy%20Store%20Pokhara!5e0!3m2!1sen!2snp!4v1747496363851!5m2!1sen!2snp" 
                        width="100%" height="250" style="border:0;" tabindex="0">
                    </iframe>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer Section -->
<footer class="bg-light text-center text-muted py-3 mt-5">
    <div class="container">
        &copy; 2025 My Store. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showMessage(event) {
        event.preventDefault(); // stop form submission

        // Show success message
        document.getElementById('successMessage').style.display = 'block';

        // Reset the form
        document.getElementById('contactForm').reset();

        return false; // prevent page reload
    }
</script>

</body>
</html>
