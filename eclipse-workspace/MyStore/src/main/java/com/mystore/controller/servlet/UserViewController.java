package com.mystore.controller.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystore.controller.dao.UserDAO;
import com.mystore.model.User;

@WebServlet("/UserViewController")
public class UserViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserViewController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDao = new UserDAO();
        List<User> users = userDao.getAllUsers(); // Fetch all users from the database

        if (users == null || users.isEmpty()) {
            request.setAttribute("errorMessage", "No users found.");
        } else {
            request.setAttribute("users", users); // Set the attribute for JSP to access
        }

        request.getRequestDispatcher("/pages/ManageUsers.jsp").forward(request, response); // Forward to JSP
    }
}