package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.User;

@WebServlet("/admin/products/delete")
public class ProductDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        //  檢查登入 & 權限（必須是 admin）
//        HttpSession session = request.getSession(false);
//        User loginUser = null;	
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }
    	String ctx = request.getContextPath();
//        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
//        	response.sendRedirect(ctx + "/Login");
//            return;
//        }

        //  取得要刪除的商品 id
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
        	response.sendRedirect(ctx + "/admin/products");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
        	response.sendRedirect(ctx + "/admin/products");
            return;
        }

        //  呼叫 DAO 執行刪除
        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);   // 成功或失敗都是回列表，這裡先不用分太細

        //  刪除後回後台列表
        response.sendRedirect(ctx + "/admin/products");
    }

    // 想更嚴謹，也可以只允許 POST 刪除，
    // 這裡先讓 GET 版本可以用就好（對專題來說夠用了）
}
