package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import model.CartItem;
import model.User;

@WebServlet("/CheckoutSelected")
public class CheckoutSelectedServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 檢查登入狀態
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 取得選中的購物車項目 ID
        String[] cartItemIds = request.getParameterValues("cartItemIds");

        if (cartItemIds == null || cartItemIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/Cart");
            return;
        }

        CartItemDAO cartDAO = new CartItemDAO();
        List<CartItem> selectedItems = new ArrayList<>();
        double totalAmount = 0;

        // 獲取選中的購物車項目
        for (String idStr : cartItemIds) {
            try {
                int cartItemId = Integer.parseInt(idStr);
                CartItem item = cartDAO.getCartItemById(cartItemId);

                // 確保該項目屬於當前用戶
                if (item != null && item.getUserId() == loginUser.getId()) {
                    selectedItems.add(item);
                    totalAmount += item.getProduct().getPrice() * item.getQuantity();
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (selectedItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Cart");
            return;
        }

        // 創建訂單
        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(loginUser.getId(), totalAmount);

        if (orderId > 0) {
            ProductDAO productDAO = new ProductDAO();

            // 將選中的購物車項目加入訂單並扣除庫存
            for (CartItem item : selectedItems) {
                orderDAO.addOrderItem(orderId, item.getProduct().getId(),
                                     item.getQuantity(), item.getProduct().getPrice());

                // 扣除庫存
                productDAO.decreaseStock(item.getProduct().getId(), item.getQuantity());

                // 刪除購物車中的該項目
                cartDAO.deleteItem(item.getId());
            }

            // 設置訂單資訊到 request attributes
            request.setAttribute("orderId", orderId);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("cartItems", selectedItems);

            // Forward 到訂單成功頁面
            request.getRequestDispatcher("/order_success.jsp").forward(request, response);
        } else {
            // 失敗時返回購物車
            request.setAttribute("error", "訂單建立失敗，請稍後再試");
            request.getRequestDispatcher("/Cart").forward(request, response);
        }
    }
}
