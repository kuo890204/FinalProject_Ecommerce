package controller; 

import java.io.IOException;
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

        // 2️⃣ 呼叫 DAO 裡的方法 → 拿到所有商品（List<Product>）
        List<Product> list = dao.getAllProducts();

        // 3️⃣ 把商品清單放進 request 物件裡，讓 JSP 可以使用
        //    "productList" 是 JSP 取資料時要用的 key
        request.setAttribute("productList", list);

        // 4️⃣ 請求轉發（Forward）到 product_list.jsp
        //    → 把資料交給 JSP 顯示畫面
        RequestDispatcher rd = request.getRequestDispatcher("product_list.jsp");
        rd.forward(request, response);
    }
}
