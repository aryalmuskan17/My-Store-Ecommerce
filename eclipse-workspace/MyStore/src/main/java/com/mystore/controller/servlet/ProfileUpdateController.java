package com.mystore.controller.servlet;

import com.mystore.model.User;
import com.mystore.controller.dao.UserDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileUpdateController")
public class ProfileUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProfileUpdateController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get updated data from the form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userWithSession");

        if (user != null) {
            // Update the user object with the new data
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            // Update the database through the UserDAO
            UserDAO userDAO = new UserDAO();
            boolean isUpdated = userDAO.updateUser(user);

            // Set the message based on the update result
            if (isUpdated) {
                session.setAttribute("userWithSession", user);
                request.setAttribute("updateMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("updateMessage", "Profile update failed. Please try again.");
            }
            // Forward the request to Profile.jsp to display the message
            request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
        } else {
            // If user is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
        }
    }
}
