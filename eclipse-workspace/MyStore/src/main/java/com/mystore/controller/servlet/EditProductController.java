package com.mystore.controller.servlet;

import com.mystore.controller.dao.ProductDAO;
import com.mystore.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditProductController")
public class EditProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditProductController() {
        super();
    }

    // Handle GET: Load product details and forward to EditProduct.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDAO dao = new ProductDAO();
            Products product = dao.getProductById(productId);
            request.setAttribute("productToEdit", product);

            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/pages/EditProduct.jsp").forward(request, response);
            } else {
                response.sendRedirect("ProductViewController");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProductViewController");
        }
    }

    // Handle POST: Save updated product
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            String imageUrl = request.getParameter("imageUrl");

            Products updatedProduct = new Products(productId, name, description, price, stock, brandId, imageUrl, null);
            ProductDAO dao = new ProductDAO();
            boolean updated = dao.updateProductDetail(updatedProduct);

            if (updated) {
                response.sendRedirect("ProductViewController");
            } else {
                request.setAttribute("errorMessage", "Product update failed.");
                request.setAttribute("product", updatedProduct);
                request.getRequestDispatcher("/pages/EditProduct.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating product.");
            request.getRequestDispatcher("/pages/EditProduct.jsp").forward(request, response);
        }
    }
}
