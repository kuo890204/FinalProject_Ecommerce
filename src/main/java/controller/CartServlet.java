package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import dao.ProductDAO;
import model.CartItem;
import model.Product;
import model.User;

@WebServlet("/Cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        // 1️ 是否登入
//        HttpSession session = request.getSession(false);
//        User loginUser = null;
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }
//        if (loginUser == null) {
//            response.sendRedirect("Login");
//            return;
//        }

//        int userId = loginUser.getId();
    	
    	User loginUser = (User) request.getSession(false).getAttribute("loginUser");
        int userId = loginUser.getId();
        
        CartItemDAO cartDao = new CartItemDAO();
        ProductDAO productDao = new ProductDAO();

        // 2️查詢購物車清單
        List<CartItem> items = cartDao.getCartItemsByUser(userId);

        // 3️ 每筆 item 補上對應的 Product（讓 JSP 可顯示品名 / 價格）
        for (CartItem item : items) {
            Product p = productDao.getProductById(item.getProductId());
            item.setProduct(p);  // ⭐ 把商品塞回 cart item 裡，JSP 印起來超方便
        }

        // 4️ 傳資料給 cart.jsp
        request.setAttribute("cartItems", items);

        RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
        rd.forward(request, response);
    }
}
