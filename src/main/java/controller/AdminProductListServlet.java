package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;
import model.User;

@WebServlet({"/AdminProductList", "/admin/products"})
public class AdminProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        // 檢查是否登入
//        HttpSession session = request.getSession(false);
//        User loginUser = null;
//
//        if (session != null) {
//            loginUser = (User) session.getAttribute("loginUser");
//        }
//
//        // 未登入 → 導去 Login
//        if (loginUser == null) {
//            response.sendRedirect("Login");
//            return;
//        }
//
//        // 有登入但不是 admin → 導回首頁
//        if (!"admin".equals(loginUser.getRole())) {
//            response.sendRedirect("ProductList");
//            return;
//        }
    	
    	String ctx = request.getContextPath();

        // 如果有人走舊網址 /AdminProductList，統一導去新網址 /admin/products
        String uri = request.getRequestURI(); // 例如 /FinalProject_Ecommerce/AdminProductList
        if (uri.endsWith("/AdminProductList")) {
            response.sendRedirect(ctx + "/admin/products");
            return;
        }

        //  是 admin → 取得所有商品
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();

        request.setAttribute("products", list);

        // forward 到後台頁面
        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_product_list.jsp");
        rd.forward(request, response);
    }
}
