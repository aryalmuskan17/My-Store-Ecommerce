package com.mystore.controller.dao;

import com.mystore.controller.database.DatabaseConnection;
import com.mystore.model.Order;
import com.mystore.model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private final Connection connection;

    public OrderDAO() throws SQLException, ClassNotFoundException {
        this.connection = DatabaseConnection.getConnection();
    }

    public void placeOrder(int userId, List<CartItem> cartItems, double totalAmount) throws SQLException {
        String insertOrderSQL = "INSERT INTO `Order` (user_id, order_date, total_amount, status) VALUES (?, NOW(), ?, 'Pending')";
        String insertOrderItemSQL = "INSERT INTO OrderItem (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet generatedKeys = null;

        try {
            connection.setAutoCommit(false); // Start transaction

            // Insert order and get generated order ID
            orderStmt = connection.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.executeUpdate();

            generatedKeys = orderStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                connection.rollback();
                throw new SQLException("Failed to retrieve order ID.");
            }

            int orderId = generatedKeys.getInt(1);

            // Insert order items
            itemStmt = connection.prepareStatement(insertOrderItemSQL);
            for (CartItem item : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId()); // Assuming CartItem has productId stored
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getPrice());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            connection.commit(); // Commit transaction

        } catch (SQLException e) {
            connection.rollback(); // Rollback on error
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (orderStmt != null) orderStmt.close();
            if (itemStmt != null) itemStmt.close();
            connection.setAutoCommit(true); // Reset auto-commit
        }
       
    }
    public List<Order> getAllOrders() throws SQLException, ClassNotFoundException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("name"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        }
        return orders;
    }
    
}
