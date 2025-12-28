package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;

@WebServlet("/products/search")
public class ProductSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 取得搜尋關鍵字
        String keyword = request.getParameter("keyword");

        ProductDAO dao = new ProductDAO();
        List<Product> productList;

        if (keyword != null && !keyword.trim().isEmpty()) {
            // 執行搜尋
            productList = dao.searchProducts(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else {
            // 沒有關鍵字，顯示所有商品
            productList = dao.getAllProducts();
        }

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/search_results.jsp").forward(request, response);
    }
}
