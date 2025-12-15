package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;
import model.User;

@WebServlet("/admin/orders/detail")
public class AdminOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
        	response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
        	response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);

        OrderDAO orderDao = new OrderDAO();
        Order order = orderDao.getOrderById(orderId);
        List<OrderItem> items = orderDao.getOrderItemsWithProduct(orderId);

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }


        request.setAttribute("order", order);
        request.setAttribute("items", items);

        RequestDispatcher rd = request.getRequestDispatcher("/admin_order_detail.jsp");
        rd.forward(request, response);
    }
}
