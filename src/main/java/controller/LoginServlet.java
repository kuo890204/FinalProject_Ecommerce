package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    // 顯示登入畫面（GET）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // LoginServlet 不需要檢查登入狀態
        // 因為 Login 本身就是給「尚未登入」的人進來的頁面

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // 處理登入表單（POST）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);

        if (user != null) {
            // 登入成功 → 建立 Session
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user);

            // 根據角色導向不同頁面
            if ("admin".equals(user.getRole())) {
                // 管理員 → 導向訂單管理
                response.sendRedirect("admin/orders");
            } else {
                // 一般用戶 → 導向商品列表
                response.sendRedirect("ProductList");
            }

        } else {
            // 登入失敗 → 顯示錯誤訊息並回到登入頁
            request.setAttribute("error", "帳號或密碼錯誤");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
