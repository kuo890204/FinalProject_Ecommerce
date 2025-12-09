package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;
import model.User;

@WebServlet("/ProductAdd")
public class ProductAddServlet extends HttpServlet {

    // 顯示新增商品的表單（GET）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ 權限檢查：必須是 admin 才能進來
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 顯示新增商品畫面
        request.getRequestDispatcher("product_add.jsp").forward(request, response);
    }

    // 處理表單送出（POST）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        request.setCharacterEncoding("UTF-8");

        // 1️⃣ 權限檢查（保險，POST 也檢查一次）
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 取得表單欄位
        String name     = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String category = request.getParameter("category");
        String image    = request.getParameter("image");

        // 3️⃣ 基本必填檢查
        if (name == null || name.isEmpty() ||
            priceStr == null || priceStr.isEmpty() ||
            stockStr == null || stockStr.isEmpty()) {

            request.setAttribute("error", "商品名稱、價格、庫存為必填");
            // 回填剛剛的欄位
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_add.jsp").forward(request, response);
            return;
        }

        double price = 0;
        int stock = 0;

        try {
            price = Double.parseDouble(priceStr);
            stock = Integer.parseInt(stockStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "價格與庫存必須是數字");
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_add.jsp").forward(request, response);
            return;
        }

        // 4️⃣ 組 Product 物件
        Product p = new Product();
        p.setName(name);
        p.setPrice(price);
        p.setStock(stock);
        p.setCategory(category);
        p.setImage(image);

        // 5️⃣ 呼叫 DAO 寫入資料庫
        ProductDAO dao = new ProductDAO();
        boolean ok = dao.addProduct(p);

        if (ok) {
            // 新增成功 → 回後台列表
            response.sendRedirect("AdminProductList");
        } else {
            // 新增失敗 → 顯示錯誤訊息
            request.setAttribute("error", "新增商品失敗，請稍後再試。");
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_add.jsp").forward(request, response);
        }
    }
}
