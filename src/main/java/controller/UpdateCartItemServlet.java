package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import dao.ProductDAO;
import model.User;
import model.Product;

@WebServlet("/UpdateCartItem")
public class UpdateCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        // 2️⃣ 取得表單參數：cartItemId, productId, quantity
        String cartItemIdStr = request.getParameter("cartItemId");
        String productIdStr  = request.getParameter("productId");
        String qtyStr        = request.getParameter("quantity");

        if (cartItemIdStr == null || productIdStr == null || qtyStr == null ||
            cartItemIdStr.isEmpty() || productIdStr.isEmpty() || qtyStr.isEmpty()) {
            response.sendRedirect("Cart");
            return;
        }

        int cartItemId;
        int productId;
        int newQty;

        try {
            cartItemId = Integer.parseInt(cartItemIdStr);
            productId  = Integer.parseInt(productIdStr);
            newQty     = Integer.parseInt(qtyStr);
        } catch (NumberFormatException e) {
            // 輸入不是有效數字 → 回購物車
            response.sendRedirect("Cart");
            return;
        }

        // 3️⃣ 數量必須 >= 1
        if (newQty <= 0) {
            // 不接受 0 或負數，直接回購物車（之後需要可以加錯誤訊息）
            response.sendRedirect("Cart");
            return;
        }

        // 4️⃣ 檢查庫存：不能超過 product.stock
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product == null) {
            // 商品不存在，直接回購物車
            response.sendRedirect("Cart");
            return;
        }

        if (newQty > product.getStock()) {
            // 超過庫存，不更新
            response.sendRedirect("Cart");
            return;
        }

        // 5️⃣ 通過檢查，更新數量
        CartItemDAO cartDao = new CartItemDAO();
        cartDao.updateQuantity(cartItemId, newQty);

        // 6️⃣ 完成後回到購物車
        response.sendRedirect("Cart");
    }
}
