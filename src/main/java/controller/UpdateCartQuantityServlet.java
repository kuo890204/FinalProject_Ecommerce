//package controller;
//
//import java.io.IOException;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//import dao.CartItemDAO;
//import dao.ProductDAO;
//import model.CartItem;
//import model.Product;
//import model.User;
//
//@WebServlet("/UpdateCartQuantity")
//public class UpdateCartQuantityServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        request.setCharacterEncoding("UTF-8");
//
//        // 1️⃣ 檢查是否登入
//        HttpSession session = request.getSession(false);
//        User loginUser = null;
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }
//        if (loginUser == null) {
//            response.sendRedirect("Login");
//            return;
//        }
//
//        // 2️⃣ 取得參數：購物車項目 id + 新數量
//        String idStr = request.getParameter("cartItemId");
//        String qtyStr = request.getParameter("quantity");
//
//        if (idStr == null || qtyStr == null ||
//            idStr.isEmpty() || qtyStr.isEmpty()) {
//            response.sendRedirect("Cart");
//            return;
//        }
//
//        int cartItemId;
//        int newQty;
//        try {
//            cartItemId = Integer.parseInt(idStr);
//            newQty = Integer.parseInt(qtyStr);
//        } catch (NumberFormatException e) {
//            response.sendRedirect("Cart");
//            return;
//        }
//
//        // 數量不能小於 1
//        if (newQty < 1) {
//            newQty = 1;
//        }
//
//        CartItemDAO cartDao = new CartItemDAO();
//        ProductDAO productDao = new ProductDAO();
//
//        // 3️⃣ 查出這一筆購物車項目，順便拿 productId
//        CartItem item = cartDao.getCartItemById(cartItemId);
//        if (item == null) {
//            response.sendRedirect("Cart");
//            return;
//        }
//
//        // 4️⃣ 查商品，做庫存檢查
//        Product p = productDao.getProductById(item.getProductId());
//        if (p == null) {
//            response.sendRedirect("Cart");
//            return;
//        }
//
//        if (newQty > p.getStock()) {
//            // 庫存不足 → 先簡單導回 Cart，附帶錯誤訊息（之後你要顯示再用）
//            response.sendRedirect("Cart?error=out_of_stock");
//            return;
//        }
//
//        // 5️⃣ 更新數量
//        cartDao.updateQuantity(cartItemId, newQty);
//
//        // 6️⃣ 回購物車頁
//        response.sendRedirect("Cart");
//    }
//}
