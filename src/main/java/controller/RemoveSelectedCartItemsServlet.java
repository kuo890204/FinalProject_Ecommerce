package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import model.CartItem;
import model.User;

@WebServlet("/RemoveSelectedCartItems")
public class RemoveSelectedCartItemsServlet extends HttpServlet {

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

        if (cartItemIds != null && cartItemIds.length > 0) {
            CartItemDAO cartDAO = new CartItemDAO();
            int successCount = 0;
            int failCount = 0;

            // 逐一刪除選中的購物車項目
            for (String idStr : cartItemIds) {
                try {
                    int cartItemId = Integer.parseInt(idStr);
                    CartItem item = cartDAO.getCartItemById(cartItemId);

                    // 確保該項目屬於當前用戶
                    if (item != null && item.getUserId() == loginUser.getId()) {
                        cartDAO.deleteItem(cartItemId);
                        successCount++;
                    } else {
                        failCount++;
                    }
                } catch (Exception e) {
                    failCount++;
                    e.printStackTrace();
                }
            }

            // 設定結果訊息（可選）
            if (failCount > 0) {
                session.setAttribute("message",
                    "批量移除完成：成功 " + successCount + " 項，失敗 " + failCount + " 項");
            } else {
                session.setAttribute("message",
                    "成功移除 " + successCount + " 項商品");
            }
        }

        // 重新導向到購物車頁面
        response.sendRedirect(request.getContextPath() + "/Cart");
    }
}
