package com.mystore.controller.servlet;

import com.mystore.controller.dao.ProductDAO;
import com.mystore.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles GET requests to load 3 products
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ProductDAO productDAO = new ProductDAO(); // Model → DAO
            List<Products> allProducts = productDAO.getAllProducts();

            // Show only first 3 products (or fewer if less than 3)
            List<Products> featuredProducts = allProducts.size() > 3
                    ? allProducts.subList(0, 3)
                    : allProducts;

            request.setAttribute("featuredProducts", featuredProducts); // Pass data to View
            request.getRequestDispatcher("/pages/Home.jsp").forward(request, response); // Go to JSP

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Use logging in real projects
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading homepage");
        }
    }
}
