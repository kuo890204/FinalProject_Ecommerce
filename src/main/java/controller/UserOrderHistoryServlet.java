package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.OrderDAO;
import model.Order;
import model.User;

@WebServlet("/user/orders")
public class UserOrderHistoryServlet extends HttpServlet {

    // 顯示歷史訂單列表（GET）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // 檢查是否已登入
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 查詢該用戶的所有訂單
        OrderDAO dao = new OrderDAO();
        List<Order> orderList = dao.getOrdersByUserId(loginUser.getId());

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/user_order_history.jsp").forward(request, response);
    }
}
