package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;
import model.User;

@WebServlet("/admin/products/preview")
public class AdminPreviewProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 檢查管理員權限
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 取得所有商品
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        // 將商品列表傳到 JSP
        request.setAttribute("productList", productList);

        // 轉發到預覽頁面
        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_preview_products.jsp");
        rd.forward(request, response);
    }
}
