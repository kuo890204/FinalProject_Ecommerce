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

@WebServlet("/user/order/detail")
public class UserOrderDetailServlet extends HttpServlet {

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

        // 取得訂單 ID
        String orderIdStr = request.getParameter("id");
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
            request.setAttribute("error", "訂單不存在或無權限查看");
            response.sendRedirect(request.getContextPath() + "/user/orders");
            return;
        }

        // 查詢訂單明細
        List<OrderItem> orderItems = dao.getOrderItemsWithProduct(orderId);

        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);
        request.getRequestDispatcher("/user_order_detail.jsp").forward(request, response);
    }
}
