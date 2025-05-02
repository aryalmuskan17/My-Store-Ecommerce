package com.mystore.controller.servlet;

import com.mystore.controller.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteProductController")
public class DeleteProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteProductController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        try {
            ProductDAO dao = new ProductDAO();
            boolean deleted = dao.deleteProduct(productId);

            if (deleted) {
                response.sendRedirect("ProductViewController");
            } else {
                request.setAttribute("errorMessage", "Failed to delete product.");
                request.getRequestDispatcher("/pages/ManageProducts.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred.");
            request.getRequestDispatcher("/pages/ManageProducts.jsp").forward(request, response);
        }
    }
}
