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
    	//1) 參數驗證（id 必須存在）
    	   String idStr = request.getParameter("id");
    	    if (idStr == null || idStr.isEmpty()) {
    	        response.sendRedirect(request.getContextPath() + "/admin/orders");
    	        return;
    	    }
    	// 2) 轉數字防爆（避免 id=abc）
    	            int orderId;
    	            try {
    	                orderId = Integer.parseInt(idStr.trim());
    	            } catch (NumberFormatException e) {
    	                response.sendRedirect(request.getContextPath() + "/admin/orders");
    	                return;
    	            }
        
    	  // 查訂單 + 明細
    	           OrderDAO orderDao = new OrderDAO();
    	            Order order = orderDao.getOrderById(orderId);
    	            List<OrderItem> items = orderDao.getOrderItemsWithProduct(orderId);

    	            // 資料不存在 → 回列表
    	            if (order == null) {
    	                response.sendRedirect(request.getContextPath() + "/admin/orders");
    	                return;
    	            }


        request.setAttribute("order", order);
        request.setAttribute("items", items);

        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_order_detail.jsp");
        rd.forward(request, response);
    }
}
