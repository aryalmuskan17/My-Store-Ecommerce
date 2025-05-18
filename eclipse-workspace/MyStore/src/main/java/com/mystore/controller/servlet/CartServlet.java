package com.mystore.controller.servlet;

import com.mystore.controller.dao.CartDAO;
import com.mystore.controller.dao.OrderDAO;
import com.mystore.model.CartItem;
import com.mystore.model.Order;
import com.mystore.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private OrderDAO orderDAO;  // Add OrderDAO reference

    @Override
    public void init() throws ServletException {
        try {
            cartDAO = new CartDAO();
            orderDAO = new OrderDAO();  // Initialize OrderDAO here
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Database connection error.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userWithSession");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
            return;
        }

        try {
            // Get or create cart ID for the user
            int cartId = cartDAO.getOrCreateCartId(user.getUserId());

            // Fetch all items in the cart
            List<CartItem> cartItems = cartDAO.getCartItems(cartId);
            request.setAttribute("cartItems", cartItems);

            // Fetch all orders (order history) for this user
            List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
            request.setAttribute("orders", orders);

            // Forward to Cart.jsp (or a page where you want to show both cart and order history)
            request.getRequestDispatcher("/pages/Cart.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error fetching cart items or orders.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userWithSession");

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/pages/Login.jsp");
                return;
            }

            try {
                int cartId = cartDAO.getOrCreateCartId(user.getUserId());

                if (action.equals("add")) {
                    int productId = Integer.parseInt(request.getParameter("product_id"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.addToCart(cartId, productId, quantity);
                } else if (action.equals("remove")) {
                    int cartItemId = Integer.parseInt(request.getParameter("cart_item_id"));
                    cartDAO.removeCartItem(cartItemId);
                } else if (action.equals("update")) {
                    int cartItemId = Integer.parseInt(request.getParameter("cart_item_id"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.updateCartItemQuantity(cartItemId, quantity);
                }

                response.sendRedirect(request.getContextPath() + "/CartServlet");
            } catch (SQLException e) {
                throw new ServletException("Error modifying cart.", e);
            }
        }
    }

}
