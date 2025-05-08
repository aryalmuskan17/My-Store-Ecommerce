package com.mystore.controller.servlet;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystore.controller.dao.OrderDAO;
import com.mystore.model.Order;

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orderList", orders);
            request.getRequestDispatcher("/pages/ManageOrders.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving orders", e);
        }
    }
}
