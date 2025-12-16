package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;
import model.Product;
import model.User;

@WebServlet({"/ProductEdit", "/admin/products/edit"})
public class ProductEditServlet extends HttpServlet {

    // 顯示編輯畫面（GET /ProductEdit?id=1）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ 檢查登入 & 權限
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 取得要編輯的商品 id
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("AdminProductList");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminProductList");
            return;
        }

        // 3️⃣ 從 DB 把商品撈出來
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(id);

        if (product == null) {
            // 沒這筆商品 → 回列表
            response.sendRedirect("AdminProductList");
            return;
        }

        // 4️⃣ 放到 request，給 JSP 用
        request.setAttribute("product", product);

        request.getRequestDispatcher("product_edit.jsp").forward(request, response);
    }

    // 處理修改送出（POST）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1️⃣ 再檢查一次權限（保險）
        HttpSession session = request.getSession(false);
        User loginUser = null;
        if (session != null) {
            loginUser = (User) session.getAttribute("loginUser");
        }

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect("Login");
            return;
        }

        // 2️⃣ 拿表單資料
        String idStr     = request.getParameter("id");
        String name      = request.getParameter("name");
        String priceStr  = request.getParameter("price");
        String stockStr  = request.getParameter("stock");
        String category  = request.getParameter("category");
        String image     = request.getParameter("image");

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("AdminProductList");
            return;
        }

        // 3️⃣ 必填檢查
        if (name == null || name.isEmpty() ||
            priceStr == null || priceStr.isEmpty() ||
            stockStr == null || stockStr.isEmpty()) {

            request.setAttribute("error", "商品名稱、價格、庫存為必填");
            // 回填欄位
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_edit.jsp").forward(request, response);
            return;
        }

        double price;
        int stock;

        try {
            price = Double.parseDouble(priceStr);
            stock = Integer.parseInt(stockStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "價格與庫存必須是數字");
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_edit.jsp").forward(request, response);
            return;
        }

        // 4️⃣ 組 Product 物件
        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setPrice(price);
        p.setStock(stock);
        p.setCategory(category);
        p.setImage(image);

        // 5️⃣ 呼叫 DAO 更新
        ProductDAO dao = new ProductDAO();
        boolean ok = dao.updateProduct(p);

        if (ok) {
            // 修改成功 → 回列表
            response.sendRedirect("AdminProductList");
        } else {
            // 修改失敗 → 顯示錯誤
            request.setAttribute("error", "更新商品失敗，請稍後再試。");
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock", stockStr);
            request.setAttribute("category", category);
            request.setAttribute("image", image);

            request.getRequestDispatcher("product_edit.jsp").forward(request, response);
        }
    }
}
