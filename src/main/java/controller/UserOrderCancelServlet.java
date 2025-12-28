package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import model.Order;
import model.User;

@WebServlet("/user/order/cancel")
public class UserOrderCancelServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // 檢查是否已登入
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 取得訂單 ID
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        // 查詢訂單資訊
        OrderDAO dao = new OrderDAO();
        Order order = dao.getOrderById(orderId);

        // 檢查訂單是否存在，且是否屬於當前用戶
        if (order == null || order.getUserId() != loginUser.getId()) {
            response.sendRedirect(request.getContextPath() + "/user/orders");
            return;
        }

        // 只允許取消 CREATED 狀態的訂單
        if ("CREATED".equals(order.getStatus())) {
            dao.updateStatus(orderId, "CANCEL");
        }

        // 重定向回訂單詳情頁
        response.sendRedirect(request.getContextPath() + "/user/order/detail?id=" + orderId);
    }
}
