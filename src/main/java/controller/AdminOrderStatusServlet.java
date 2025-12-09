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

        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect("Login");
            return;
        }

        String idStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (idStr == null || idStr.isEmpty() || status == null || status.isEmpty()) {
            response.sendRedirect("admin/orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);

        OrderDAO orderDao = new OrderDAO();
        orderDao.updateStatus(orderId, status);

        // 改完狀態後回到這筆訂單明細頁
        response.sendRedirect("detail?id=" + orderId);
    }
}
