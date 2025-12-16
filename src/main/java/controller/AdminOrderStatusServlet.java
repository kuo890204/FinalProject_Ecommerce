package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import model.User;

@WebServlet("/admin/orders/status")
public class AdminOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

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
       

        String ctx = request.getContextPath();

        String idStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (idStr == null || idStr.trim().isEmpty() || status == null || status.trim().isEmpty()) {
            response.sendRedirect(ctx + "/admin/orders");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(ctx + "/admin/orders");
            return;
        }

        OrderDAO orderDao = new OrderDAO();
        orderDao.updateStatus(orderId, status);

        // 改完狀態後回到這筆訂單明細頁
        response.sendRedirect(ctx + "/admin/orders/detail?id=" + orderId);
    }
}
