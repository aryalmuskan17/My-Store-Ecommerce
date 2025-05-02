package com.mystore.controller.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystore.controller.dao.ProductDAO;
import com.mystore.model.Products;

@WebServlet("/ProductViewController")
public class ProductViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ProductDAO productDao = new ProductDAO();
            List<Products> products = productDao.getAllProducts();

            if (products.isEmpty()) {
                request.setAttribute("errorMessage", "No products found.");
            } else {
                request.setAttribute("products", products);
            }

            request.getRequestDispatcher("/pages/ManageProducts.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong while fetching products.");
            request.getRequestDispatcher("/pages/ManageProducts.jsp").forward(request, response);
        }
    }
}
