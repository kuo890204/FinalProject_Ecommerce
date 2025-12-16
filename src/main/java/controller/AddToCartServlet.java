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

    // ✅ 共用邏輯：不管是 GET / POST 都走這裡
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

//        // 檢查是否登入（未登入 → 去 Login）
//        HttpSession session = request.getSession(false); // false = 不建立新的
//        User loginUser = null;
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }

//        if (loginUser == null) {
//            // 尚未登入 → 導去登入畫面
//            response.sendRedirect("Login");
//            return;
//        }
        
        User loginUser = (User) request.getSession(false).getAttribute("loginUser");
        int userId = loginUser.getId();
        
        // 取得商品 id（從網址 / 表單的 productId）
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

        // 固定 +1
        int addQty = 1;

        ProductDAO productDAO = new ProductDAO();
        CartItemDAO cartItemDAO = new CartItemDAO();

        // 先查商品資料（順便拿庫存）
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            // 商品不存在 → 回商品列表
            response.sendRedirect("ProductList");
            return;
        }

        // 查目前購物車裡已經有幾個這個商品
        int currentQty = 0;

        List<CartItem> cartItems = cartItemDAO.getCartItemsByUser(userId);
        for (CartItem item : cartItems) {
            if (item.getProductId() == productId) {
                currentQty = item.getQuantity();
                break;
            }
        }

        int newQty = currentQty + addQty;

        // 庫存檢查：新數量不能超過 stock
        if (newQty > product.getStock()) {
            // 庫存不足 → 導回商品詳細頁（帶錯誤訊息參數）
            response.sendRedirect("ProductDetail?id=" + productId + "&error=out_of_stock");
            return;
        }

        // 呼叫 DAO：若有就更新數量，沒有就新增
        cartItemDAO.addOrUpdateItem(userId, productId, addQty);

        // 加入成功 → 導到購物車頁
        response.sendRedirect(request.getContextPath() + "/Cart");
//        response.sendRedirect("Cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
