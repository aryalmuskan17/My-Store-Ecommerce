package com.mystore.controller.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.mystore.controller.database.DatabaseConnection;
import com.mystore.model.Products;

public class ProductDAO {
    private Connection conn;

    // Constructor: Establishes database connection when ProductDAO is created
    public ProductDAO() throws SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Add a new product to the database
    public boolean addProduct(Products product) {
        boolean isRowInserted = false;
        String query = "INSERT INTO Product (product_name, description, price, stock_quantity, brand_id, image_url) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setInt(5, product.getBrandId());
            ps.setString(6, product.getImageUrl());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                isRowInserted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Ideally use logging instead of printStackTrace
        }

        return isRowInserted;
    }

    // Update product details
    public boolean updateProductDetail(Products product) {
        boolean isUpdated = false;
        String sql = "UPDATE Product SET product_name = ?, description = ?, price = ?, stock_quantity = ?, brand_id = ?, image_url = ? WHERE product_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setInt(5, product.getBrandId());
            ps.setString(6, product.getImageUrl());
            ps.setInt(7, product.getProductId());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Ideally use logging instead of printStackTrace
        }

        return isUpdated;
    }

    // Fetch all products (used to display on homepage)
    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("product_id");
                String name = rs.getString("product_name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock_quantity");
                int brandId = rs.getInt("brand_id");
                String imageUrl = rs.getString("image_url");

                Products product = new Products(id, name, description, price, stock, brandId, imageUrl, null);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Ideally use logging instead of printStackTrace
        }

        return products;
    }
}
