package com.mystore.controller.dao;
import com.mystore.controller.database.DatabaseConnection;
import com.mystore.model.CartItem;
import java.util.ArrayList;
import java.util.List;

import java.sql.*;

public class CartDAO {

    private Connection conn;

    public CartDAO() throws SQLException {
        try {
			conn = DatabaseConnection.getConnection();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    

    // ✅ Step 2.1: Get or create a cart for a user
    public int getOrCreateCartId(int userId) throws SQLException {
        String select = "SELECT cart_id FROM Cart WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(select);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt("cart_id");
        } else {
            String insert = "INSERT INTO Cart (user_id) VALUES (?)";
            ps = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }

        return -1; // Failed to create cart
    }
 // ✅ Step 2.2: Add product to cart
    public void addToCart(int cartId, int productId, int quantity) throws SQLException {
        // Check if product already in cart
        String check = "SELECT quantity FROM CartItem WHERE cart_id = ? AND product_id = ?";
        PreparedStatement ps = conn.prepareStatement(check);
        ps.setInt(1, cartId);
        ps.setInt(2, productId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // Product exists in cart: update quantity
            int existingQty = rs.getInt("quantity");
            int newQty = existingQty + quantity;

            String update = "UPDATE CartItem SET quantity = ? WHERE cart_id = ? AND product_id = ?";
            ps = conn.prepareStatement(update);
            ps.setInt(1, newQty);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);
            ps.executeUpdate();
        } else {
            // Product not in cart: insert new item
            String insert = "INSERT INTO CartItem (cart_id, product_id, quantity) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(insert);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        }
        
    }
    
    public List<CartItem> getCartItems(int cartId) throws SQLException {
    	String sql = "SELECT ci.cart_item_id, ci.product_id, p.product_name, p.price, ci.quantity " +
                "FROM CartItem ci " +
                "JOIN Product p ON ci.product_id = p.product_id " +
                "WHERE ci.cart_id = ?";

        
    	PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);
        ResultSet rs = ps.executeQuery();

        List<CartItem> items = new ArrayList<>();
        while (rs.next()) {
            CartItem item = new CartItem();
            item.setProductId(rs.getInt("product_id"));
            item.setCartItemId(rs.getInt("cart_item_id"));
            item.setProductName(rs.getString("product_name"));
            item.setPrice(rs.getDouble("price"));
            item.setQuantity(rs.getInt("quantity"));
            items.add(item);
        }

        return items;
    }
 // ✅ Step 2.4: Remove item from cart
    public void removeCartItem(int cartItemId) throws SQLException {
        String query = "DELETE FROM CartItem WHERE cart_item_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, cartItemId);
        ps.executeUpdate();
    }
    public void clearCart(int cartId) throws SQLException {
        String sql = "DELETE FROM CartItem WHERE cart_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        }
    }
    public void updateCartItemQuantity(int cartItemId, int quantity) throws SQLException {
        String sql = "UPDATE CartItem SET quantity = ? WHERE cart_item_id = ?";

        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, quantity);
            statement.setInt(2, cartItemId);
            statement.executeUpdate();
        }
    }

    
}
