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

        // 1️⃣ 檢查是否登入
        HttpSession session = request.getSession(false);
        User loginUser = null;

        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        // 2️⃣ 未登入 → 導去 Login
        if (loginUser == null) {
            response.sendRedirect("Login");
            return;
        }

        // 3️⃣ 有登入但不是 admin → 導回首頁
        if (!"admin".equals(loginUser.getRole())) {
            response.sendRedirect("ProductList");
            return;
        }

        // 4️⃣ 是 admin → 取得所有商品
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();

        request.setAttribute("products", list);

        // 5️⃣ forward 到後台頁面
        RequestDispatcher rd = request.getRequestDispatcher("admin_product_list.jsp");
        rd.forward(request, response);
    }
}
