package com.mystore.controller.dao;

import com.mystore.model.User;
import com.mystore.controller.database.DatabaseConnection;

import java.sql.*;

public class UserDAO {

    // --- Register user into the "User" table ---
    public boolean registerUser(User user) {
        String query = "INSERT INTO User (name, email, phone, address, password, role) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());

            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error in registerUser(): " + e.getMessage());
            return false;
        }
    }

    // --- Log in user using email + password ---
    public User login(String email, String password) {
        String query = "SELECT * FROM User WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error in login(): " + e.getMessage());
        }
        return null;
    }

    // --- Update user details ---
    public boolean updateUser(User user) {
        String query = "UPDATE User SET name = ?, email = ?, phone = ?, address = ? WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setInt(5, user.getUserId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error in updateUser(): " + e.getMessage());
            return false;
        }
    }
}
