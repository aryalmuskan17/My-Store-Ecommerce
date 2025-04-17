package com.mystore.controller.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystore.controller.dao.ProductDAO;
import com.mystore.model.Products;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProductServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data from the request
        String productName = request.getParameter("name");  // mapped to 'product_name' in the database
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stock");  // mapped to 'stock_quantity' in the database
        String brandIdStr = request.getParameter("brandId");  // mapped to 'brand_id' in the database
        String imageUrl = request.getParameter("imageUrl");  // mapped to 'image_url' in the database

        // Check if mandatory fields are empty
        if (productName == null || productName.isEmpty() ||
            description == null || description.isEmpty() ||
            priceStr == null || priceStr.isEmpty() ||
            stockQuantityStr == null || stockQuantityStr.isEmpty() ||
            brandIdStr == null || brandIdStr.isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/pages/AddProduct.jsp").forward(request, response);
            return;
        }

        try {
            // Parse the price, stockQuantity, and brandId from string to respective types
            double price = Double.parseDouble(priceStr);
            int stockQuantity = Integer.parseInt(stockQuantityStr);  // mapped to 'stock_quantity'
            int brandId = Integer.parseInt(brandIdStr);  // mapped to 'brand_id'

            // Create product model object
            Products product = new Products(productName, description, price, stockQuantity, brandId, imageUrl);

            // Add product using DAO
            ProductDAO productDAO = new ProductDAO();
            boolean isProductAdded = productDAO.addProduct(product);

            // Set success or error message
            if (isProductAdded) {
                request.setAttribute("successMessage", "Product added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add product.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input. Please enter correct numeric values.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred while adding product.");
        }

        // Forward to the same page for displaying the result
        request.getRequestDispatcher("/pages/AddProduct.jsp").forward(request, response);
    }
}
