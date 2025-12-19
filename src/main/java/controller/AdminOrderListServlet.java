package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import model.Order;
import model.User;

@WebServlet("/admin/orders")
public class AdminOrderListServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    OrderDAO orderDao = new OrderDAO();
    List<Order> orderList = orderDao.getAllOrders();

    request.setAttribute("orderList", orderList);
    request.getRequestDispatcher("/admin/admin_order_list.jsp")
           .forward(request, response);
  }
}

