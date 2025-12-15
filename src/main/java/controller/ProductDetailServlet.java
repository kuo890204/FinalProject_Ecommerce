	package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;

@WebServlet({"/ProductDelete", "/admin/products/delete"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1️⃣ 從網址取得 id 參數，例如 /ProductDetail?id=2
            String idStr = request.getParameter("id");

            // 安全一點：防止 id 是空的或亂打字
            if (idStr == null || idStr.isEmpty()) {
                // 沒給 id 就導回商品列表或顯示錯誤
                response.sendRedirect("ProductList");
                return;
            }

            int id = Integer.parseInt(idStr);

            // 2️⃣ 用 DAO 去資料庫查這一筆商品
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);

            if (product == null) {
                // 找不到商品：你可以顯示一個簡單的訊息頁
                request.setAttribute("message", "找不到這個商品。");
                RequestDispatcher rd = request.getRequestDispatcher("product_not_found.jsp");
                rd.forward(request, response);
                return;
            }

            // 3️⃣ 查到的商品放進 request，交給 JSP 顯示
            request.setAttribute("product", product);

            RequestDispatcher rd = request.getRequestDispatcher("product_detail.jsp");
            rd.forward(request, response);

        } catch (NumberFormatException e) {
            // id 不是數字，就當作錯誤處理
            response.sendRedirect("ProductList");
        }
    }
}
