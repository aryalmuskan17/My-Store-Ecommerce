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

            itemStmt = connection.prepareStatement(insertOrderItemSQL);
            for (CartItem item : cartItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getPrice());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            connection.commit();

        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (orderStmt != null) orderStmt.close();
            if (itemStmt != null) itemStmt.close();
            connection.setAutoCommit(true);
        }
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        }
        return orders;
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id " +
                     "WHERE o.user_id = ? ORDER BY o.order_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setUserName(rs.getString("name"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // Get all orders sorted by date (most recent first)
    public List<Order> getAllOrdersSortedByDateDesc() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        }
        return orders;
    }

    // Get orders by specific date (yyyy-mm-dd format)
    public List<Order> getOrdersByDate(String date) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id " +
                     "WHERE DATE(o.order_date) = ? ORDER BY o.order_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, date);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setUserName(rs.getString("name"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT o.order_id, o.user_id, u.name, o.order_date, o.total_amount, o.status " +
                     "FROM `Order` o JOIN `User` u ON o.user_id = u.user_id WHERE o.order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setUserName(rs.getString("name")); // if you keep this in Order model
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    return order;
                }
            }
        }
        return null; // no order found
    }
    public List<CartItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<CartItem> orderItems = new ArrayList<>();
        String sql = "SELECT oi.order_item_id, oi.product_id, oi.quantity, oi.price, " +
                     "p.product_name " +
                     "FROM OrderItem oi JOIN Product p ON oi.product_id = p.product_id " +
                     "WHERE oi.order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("order_item_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    orderItems.add(item);
                }
            }
        }
        return orderItems;
    }


}
