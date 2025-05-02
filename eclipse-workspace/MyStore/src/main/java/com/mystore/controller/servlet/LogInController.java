package com.mystore.controller.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mystore.controller.dao.UserDAO;
import com.mystore.model.User;

@WebServlet("/LogInController")
public class LogInController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LogInController() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("Email");
		String password = request.getParameter("Password");

		UserDAO userDao = new UserDAO();
		User user = userDao.login(email, password);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("userWithSession", user);
			session.setAttribute("username", user.getName()); // Store username
			session.setAttribute("role", user.getRole());         // Store role
			session.setMaxInactiveInterval(600); // 10 minutes (instead of 10 sec)
			String role = user.getRole();

			if ("admin".equalsIgnoreCase(role)) {
			    response.sendRedirect(request.getContextPath() + "/pages/Dashboard.jsp");
			} else if ("customer".equalsIgnoreCase(role)) {
			    response.sendRedirect(request.getContextPath() + "/pages/CustomerDashboard.jsp");
			} else {
			    // optional: fallback in case of unknown role
			    response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
			}

		} else {
			request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
			request.getRequestDispatcher("/pages/Login.jsp").forward(request, response);
		}
	}
}
