package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Product;
import model.User;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1️⃣ 檢查登入
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }
        if (loginUser == null) {
            response.sendRedirect("Login");
            return;
        }

        int userId = loginUser.getId();

        CartItemDAO cartDao = new CartItemDAO();
        ProductDAO productDao = new ProductDAO();
        OrderDAO orderDao = new OrderDAO();

        // 2️⃣ 取得購物車內容
        List<CartItem> cartItems = cartDao.getCartItemsByUser(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            // 購物車為空，不給結帳
            response.sendRedirect("Cart?error=empty");
            return;
        }

        // 3️⃣ 檢查庫存 + 計算總金額
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            Product p = productDao.getProductById(item.getProductId());
            if (p == null) {
                // 商品不存在 → 直接退回購物車
                response.sendRedirect("Cart?error=product_not_found");
                return;
            }

            int buyQty = item.getQuantity();
            if (buyQty > p.getStock()) {
                // 庫存不足
                response.sendRedirect("Cart?error=out_of_stock");
                return;
            }

            double subTotal = p.getPrice() * buyQty;
            totalAmount += subTotal;
        }

        // 4️⃣ 建立訂單（orders）
        int orderId = orderDao.createOrder(userId, totalAmount);
        if (orderId <= 0) {
            // 建立訂單失敗
            response.sendRedirect("Cart?error=order_failed");
            return;
        }

        // 5️⃣ 建立訂單明細 + 扣庫存
        for (CartItem item : cartItems) {
            Product p = productDao.getProductById(item.getProductId());

            int buyQty = item.getQuantity();
            double unitPrice = p.getPrice();

            // 建立訂單明細
            orderDao.addOrderItem(orderId, p.getId(), buyQty, unitPrice);

            // 扣庫存
            productDao.decreaseStock(p.getId(), buyQty);
        }

        // 6️⃣ 清空購物車
        cartDao.clearCart(userId);

        // 7️⃣ 將訂單資訊塞到 request，轉到成功頁顯示
        request.setAttribute("orderId", orderId);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("cartItems", cartItems); // 給成功頁顯示明細用

        RequestDispatcher rd = request.getRequestDispatcher("order_success.jsp");
        rd.forward(request, response);
    }
}
