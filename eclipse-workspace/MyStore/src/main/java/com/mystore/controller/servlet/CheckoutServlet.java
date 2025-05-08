package com.mystore.controller.servlet;

import com.mystore.controller.dao.CartDAO;
import com.mystore.controller.dao.OrderDAO;
import com.mystore.model.CartItem;
import com.mystore.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            cartDAO = new CartDAO();
            orderDAO = new OrderDAO();
        } catch (SQLException e) {
            throw new ServletException("Initialization failed: " + e.getMessage(), e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Log the exception (use a logger in production)
            throw new ServletException("Initialization failed: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("userWithSession");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        try {
            int userId = user.getUserId();
            int cartId = cartDAO.getOrCreateCartId(userId);

            List<CartItem> cartItems = cartDAO.getCartItems(cartId);

            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Cart is empty. Cannot proceed to checkout.");
                request.getRequestDispatcher("/pages/Cart.jsp").forward(request, response);
                return;
            }

            double totalAmount = cartItems.stream()
                    .mapToDouble(item -> item.getPrice() * item.getQuantity())  // Directly using price and quantity
                    .sum();



            // Place the order and clear cart
            orderDAO.placeOrder(userId, cartItems, totalAmount);
            cartDAO.clearCart(cartId);

            // Set success message and forward back to Checkout.jsp
            request.setAttribute("success", "Order Success!");
            request.getRequestDispatcher("/pages/Checkout.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();  // Log the error stack trace (use a logger in production)
            throw new ServletException("Error during checkout", e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("userWithSession");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        try {
            int userId = user.getUserId();
            int cartId = cartDAO.getOrCreateCartId(userId);

            List<CartItem> cartItems = cartDAO.getCartItems(cartId);

            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty.");
            } else {
                request.setAttribute("cartItems", cartItems);
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/pages/Checkout.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error loading checkout page", e);
        }
    }

}
