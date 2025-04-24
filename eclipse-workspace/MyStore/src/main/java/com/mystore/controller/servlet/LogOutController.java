package com.mystore.controller.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogOutController")
public class LogOutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogOutController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidating the session to log the user out
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Redirect to the Product page after logout
        response.sendRedirect(request.getContextPath() + "/pages/Product.jsp");
    }
}
