package com.mystore.controller.servlet;

import com.mystore.controller.dao.OrderDAO;
import com.mystore.model.Order;
import com.mystore.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            orderDAO = new OrderDAO();
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Unable to initialize OrderDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/ManageOrders.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);

            // Fetch order details
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                request.setAttribute("errorMessage", "Order not found.");
                request.getRequestDispatcher("/pages/ManageOrders.jsp").forward(request, response);
                return;
            }

            // Fetch order items
            List<CartItem> orderItems = orderDAO.getOrderItemsByOrderId(orderId);

            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/pages/OrderDetails.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/ManageOrders.jsp");
        } catch (SQLException e) {
            throw new ServletException("Database error while retrieving order details", e);
        }
    }
}
