package com.mystore.controller.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mystore.controller.dao.UserDAO;
import com.mystore.model.User;

@WebServlet(asyncSupported = true, urlPatterns = { "/SignUpController" })
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SignUpController() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// Get form data
		String name = request.getParameter("name").trim();
		String email = request.getParameter("email").trim();
		String phone = request.getParameter("phone").trim();
		String address = request.getParameter("address").trim();
		String password = request.getParameter("password").trim();
		String confirmPassword = request.getParameter("confirmPassword").trim();

		try {
			// Check if passwords match
			if (!password.equals(confirmPassword)) {
				request.setAttribute("message", "Passwords do not match!");
				request.getRequestDispatcher("/pages/SignUp.jsp").forward(request, response);
				return;
			}

			// Create new User object
			User newUser = new User();
			newUser.setName(name);
			newUser.setEmail(email);
			newUser.setPhone(phone);
			newUser.setAddress(address);
			newUser.setPassword(password);
			newUser.setRole("customer"); // Default role

			// Call DAO to register user
			UserDAO userDAO = new UserDAO();
			boolean isRegistered = userDAO.registerUser(newUser);  // Correct method name

			if (isRegistered) {
				HttpSession session = request.getSession();
				session.setAttribute("userWithSession", newUser);
				session.setMaxInactiveInterval(600); // 10 minutes
				response.sendRedirect(request.getContextPath() + "/pages/Dashboard.jsp");
			} else {
				request.setAttribute("message", "Registration failed. Email might already exist.");
				request.getRequestDispatcher("/pages/SignUp.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "An internal error occurred. Please try again later.");
			request.getRequestDispatcher("/pages/SignUp.jsp").forward(request, response);
		} finally {
			out.close();
		}
	}
}
