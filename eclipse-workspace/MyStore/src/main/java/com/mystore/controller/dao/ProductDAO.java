package com.mystore.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mystore.controller.database.DatabaseConnection;
import com.mystore.model.Products;

public class ProductDAO {
    private Connection conn;
    private PreparedStatement ps;

    // Constructor: Establishes database connection when ProductDAO is created
    public ProductDAO() throws SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Add a new product to the database
    public boolean addProduct(Products product) {
        boolean isRowInserted = false;
        // SQL query with corrected column names
        String query = "INSERT INTO Product (product_name, description, price, stock_quantity, brand_id, image_url) VALUES (?, ?, ?, ?, ?, ?)";

        if (conn != null) {
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, product.getName()); // Corrected column: product_name
                ps.setString(2, product.getDescription());
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getStock()); // Corrected column: stock_quantity
                ps.setInt(5, product.getBrandId()); // brand ID
                ps.setString(6, product.getImageUrl()); // image URL

                int affectedRows = ps.executeUpdate(); // Execute the query
                if (affectedRows > 0) {
                    isRowInserted = true; // Success
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error
            }
        }

        return isRowInserted;
    }

    // Update product details (with corrected column names)
    public boolean updateProductDetail(Products product) {
        boolean isUpdated = false;
        // Correct the table name and column names
        String sql = "UPDATE Product SET product_name = ?, description = ?, price = ?, stock_quantity = ?, brand_id = ?, image_url = ? WHERE product_id = ?";

        if (conn != null) {
            try {
                ps = conn.prepareStatement(sql);
                ps.setString(1, product.getName()); // Corrected column: product_name
                ps.setString(2, product.getDescription());
                ps.setDouble(3, product.getPrice());
                ps.setInt(4, product.getStock()); // Corrected column: stock_quantity
                ps.setInt(5, product.getBrandId());
                ps.setString(6, product.getImageUrl());
                ps.setInt(7, product.getProductId());

                int affectedRows = ps.executeUpdate(); // Execute the query
                if (affectedRows > 0) {
                    isUpdated = true; // Success
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error
            }
        }

        return isUpdated;
    }
}
