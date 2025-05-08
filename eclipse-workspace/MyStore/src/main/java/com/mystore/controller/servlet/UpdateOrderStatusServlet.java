package com.mystore.controller.servlet;

import com.mystore.controller.database.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status"); // "Approved", "Rejected", "Pending"

        try (Connection conn = DatabaseConnection.getConnection()) {

            if ("Approved".equalsIgnoreCase(newStatus)) {
                // Check stock for each order item
                String itemQuery = "SELECT product_id, quantity FROM OrderItem WHERE order_id = ?";
                PreparedStatement itemStmt = conn.prepareStatement(itemQuery);
                itemStmt.setInt(1, orderId);
                ResultSet rs = itemStmt.executeQuery();

                boolean canApprove = true;
                List<Integer> productIds = new ArrayList<>();
                List<Integer> quantities = new ArrayList<>();

                while (rs.next()) {
                    int pid = rs.getInt("product_id");
                    int qty = rs.getInt("quantity");

                    productIds.add(pid);
                    quantities.add(qty);

                    PreparedStatement stockStmt = conn.prepareStatement("SELECT stock_quantity FROM Product WHERE product_id = ?");
                    stockStmt.setInt(1, pid);
                    ResultSet stockRs = stockStmt.executeQuery();
                    if (stockRs.next() && stockRs.getInt("stock_quantity") < qty) {
                        canApprove = false;
                        break;
                    }
                }

                if (canApprove) {
                    // Deduct stock
                    for (int i = 0; i < productIds.size(); i++) {
                        PreparedStatement updateStock = conn.prepareStatement(
                                "UPDATE Product SET stock_quantity = stock_quantity - ? WHERE product_id = ?");
                        updateStock.setInt(1, quantities.get(i));
                        updateStock.setInt(2, productIds.get(i));
                        updateStock.executeUpdate();
                    }

                    // Update order status to Approved
                    PreparedStatement approveStmt = conn.prepareStatement(
                            "UPDATE `Order` SET status = ? WHERE order_id = ?");
                    approveStmt.setString(1, newStatus);
                    approveStmt.setInt(2, orderId);
                    approveStmt.executeUpdate();
                } else {
                    request.setAttribute("error", "Not enough stock to approve the order.");
                    response.sendRedirect("ViewOrdersServlet");
                    return;
                }

            } else {
                // Just update status directly
                PreparedStatement stmt = conn.prepareStatement("UPDATE `Order` SET status = ? WHERE order_id = ?");
                stmt.setString(1, newStatus);
                stmt.setInt(2, orderId);
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ViewOrdersServlet");
    }
}
