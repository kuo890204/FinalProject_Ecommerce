package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartItemDAO;
import model.User;

@WebServlet("/ClearCart")   // ← 很重要！URL 就是 /ClearCart
public class ClearCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        //  檢查是否登入
//        HttpSession session = request.getSession(false);
//        User loginUser = null;
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }

//        if (loginUser == null) {
//            response.sendRedirect("Login");
//            return;
//        }

    	
    	HttpSession session = request.getSession(false);
    	User loginUser = (User) session.getAttribute("loginUser"); 
        //  清空這個使用者的購物車
    
        int userId = loginUser.getId();
        CartItemDAO dao = new CartItemDAO();
        dao.clearCart(userId);

        //  清完回購物車頁
        response.sendRedirect(request.getContextPath() + "/Cart");
    }
}
