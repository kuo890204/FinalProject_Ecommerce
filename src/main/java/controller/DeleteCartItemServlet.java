package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import model.User;

@WebServlet("/DeleteCartItem")
public class DeleteCartItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ 檢查是否登入
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null) {
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 取得要刪除的購物車項目 id
        String idStr = request.getParameter("cartItemId");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("Cart");
            return;
        }

        int cartItemId;
        try {
            cartItemId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("Cart");
            return;
        }

        // 3️⃣ 呼叫 DAO 刪除
        CartItemDAO dao = new CartItemDAO();
        dao.deleteItem(cartItemId);

        // 4️⃣ 刪完回購物車
        response.sendRedirect("Cart");
    }
}
