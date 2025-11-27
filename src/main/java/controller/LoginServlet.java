package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/Login")   // URL: /Login
public class LoginServlet extends HttpServlet {

    // 顯示登入畫面（當用 GET 訪問 /Login 時）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 直接轉到 login.jsp
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    // 處理表單送出的帳號 + 密碼（POST）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 避免亂碼（保險用）
        request.setCharacterEncoding("UTF-8");

        // 1️⃣ 從jsp取得表單的帳號 & 密碼   getParameter("欄位名")取得表單傳來的資料（文字欄位、密碼欄位、URL ?id=xxx）
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2️⃣ 呼叫 UserDAO 檢查帳密
        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);

        if (user != null) {
            // ✅ 登入成功

            // 3️⃣ 把使用者資訊放進 Session（代表「已登入」） 
            HttpSession session = request.getSession();//getSession()取得 Session（記住登入狀態用）
            session.setAttribute("loginUser", user);  // key: "loginUser"之後你要在別的頁面顯示使用者名字，就可以寫：${loginUser.name}
            
            // 4️⃣ 登入後導到商品列表（或首頁）
            response.sendRedirect("ProductList");

        } else {
            // ❌ 登入失敗：回到 login.jsp，顯示錯誤訊息

            request.setAttribute("error", "帳號或密碼錯誤");

            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }
}
