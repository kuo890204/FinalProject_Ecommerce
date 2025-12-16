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

        // 檢查登入 & 權限（只有 admin 可以看）
//        HttpSession session = request.getSession(false);
//        User loginUser = null;
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }
//
//        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
//            response.sendRedirect("Login");
//            return;
//        }
   
    	
        // 讀取所有訂單
        OrderDAO orderDao = new OrderDAO();
        List<Order> orderList = orderDao.getAllOrders();

        request.setAttribute("orderList", orderList);

        //轉到 JSP 顯示
        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_order_list.jsp");
        rd.forward(request, response);
    }
}
