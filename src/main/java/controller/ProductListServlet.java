package controller;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;     // 用來跟資料庫要商品資料
import model.Product;      // 商品的 Java Bean（資料結構）

// 這行是在設定：當有人訪問網址 "/ProductList" 時，就會由這支 Servlet 處理
@WebServlet("/ProductList")
public class ProductListServlet extends HttpServlet {

    // 使用者用 GET 方法訪問時會執行這支（像是打網址進來）
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ 建立 DAO 物件（負責去資料庫抓商品資料）
        ProductDAO dao = new ProductDAO();

        // 取得分類參數（如果有的話）
        String category = request.getParameter("category");

        // 2️⃣ 根據是否有分類參數來決定查詢方式
        List<Product> list;
        if (category != null && !category.trim().isEmpty()) {
            // 根據分類篩選商品
            list = dao.getProductsByCategory(category);
            request.setAttribute("selectedCategory", category);
        } else {
            // 拿到所有商品
            list = dao.getAllProducts();
        }

        // 取得所有分類清單（用於側邊欄）
        List<String> categories = dao.getAllCategories();

        // 取得排序參數
        String sortBy = request.getParameter("sort");

        // 根據排序參數進行排序
        if (sortBy != null && !list.isEmpty()) {
            switch (sortBy) {
                case "price_asc":
                    // 價格由低到高
                    Collections.sort(list, Comparator.comparingDouble(Product::getPrice));
                    break;
                case "price_desc":
                    // 價格由高到低
                    Collections.sort(list, (p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
                    break;
                case "name_asc":
                    // 名稱 A-Z
                    Collections.sort(list, Comparator.comparing(Product::getName));
                    break;
                case "name_desc":
                    // 名稱 Z-A
                    Collections.sort(list, (p1, p2) -> p2.getName().compareTo(p1.getName()));
                    break;
                // 預設不排序（按資料庫原始順序）
            }
        }

        // 3️⃣ 把商品清單和分類清單放進 request 物件裡，讓 JSP 可以使用
        request.setAttribute("productList", list);
        request.setAttribute("categories", categories);
        request.setAttribute("currentSort", sortBy != null ? sortBy : "default");

        // 4️⃣ 請求轉發（Forward）到 product_list.jsp
        //    → 把資料交給 JSP 顯示畫面
        RequestDispatcher rd = request.getRequestDispatcher("product_list.jsp");
        rd.forward(request, response);
    }
}
