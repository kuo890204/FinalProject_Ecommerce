package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import dao.CartItemDAO;
import model.Product;
import model.CartItem;
import model.User;

@WebServlet("/AddToCart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ 檢查是否登入（未登入 → 去 Login）
        HttpSession session = request.getSession(false); // false = 不建立新的
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null) {
            // 尚未登入 → 導去登入畫面
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 取得商品 id（從網址 ?productId=xxx）
        String idStr = request.getParameter("productId");
        if (idStr == null || idStr.isEmpty()) {
            // 沒帶 productId → 回商品列表
            response.sendRedirect("ProductList");
            return;
        }

        int productId = 0;
        try {
            productId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            // 數字轉換失敗 → 回商品列表
            response.sendRedirect("ProductList");
            return;
        }

        // 這次要加幾個？先固定 1
        int addQty = 1;

        ProductDAO productDAO = new ProductDAO();
        CartItemDAO cartItemDAO = new CartItemDAO();

        // 3️⃣ 先查商品資料（順便拿庫存）
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            // 商品不存在 → 回商品列表
            response.sendRedirect("ProductList");
            return;
        }

        // 4️⃣ 查目前購物車裡已經有幾個這個商品
        int userId = loginUser.getId();
        int currentQty = 0;

        List<CartItem> cartItems = cartItemDAO.getCartItemsByUser(userId);
        for (CartItem item : cartItems) {
            if (item.getProductId() == productId) {
                currentQty = item.getQuantity();
                break;
            }
        }

        int newQty = currentQty + addQty;

        // 5️⃣ 庫存檢查：新數量不能超過 stock
        if (newQty > product.getStock()) {
            // 庫存不足 → 先簡單導回商品詳細頁（帶錯誤訊息參數）
            response.sendRedirect("ProductDetail?id=" + productId + "&error=out_of_stock");
            return;
        }

        // 6️⃣ 呼叫 DAO：若有就更新數量，沒有就新增
        cartItemDAO.addOrUpdateItem(userId, productId, addQty);

        // 7️⃣ 加入成功 → 導到購物車頁（之後會做 CartServlet）
        response.sendRedirect("Cart");
    }
}
