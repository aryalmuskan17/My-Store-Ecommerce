package com.mystore.controller.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystore.controller.dao.UserDAO;

@WebServlet("/UserDeleteController")
public class UserDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserDeleteController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId"); // Corrected the parameter name to match the JSP
        int userId = Integer.parseInt(userIdStr); // Convert it to an integer

        UserDAO userDao = new UserDAO();
        boolean isDeleted = userDao.deleteUser(userId); // Delete the user from the database

        if (isDeleted) {
            response.sendRedirect(request.getContextPath() + "/UserViewController"); // Redirect to the User View page
        } else {
            request.setAttribute("errorMessage", "Failed to delete user.");
            request.getRequestDispatcher("/pages/ManageUsers.jsp").forward(request, response); // Forward to ViewUsers.jsp with error message
        }
    }
}
