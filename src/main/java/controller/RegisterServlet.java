package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    // 顯示註冊頁面
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        rd.forward(request, response);
    }

    // 處理註冊表單送出
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name     = request.getParameter("name");
        String address  = request.getParameter("address");
        String email    = request.getParameter("email");

        // 可以加一點簡單檢查（必要欄位）
        if (username == null || username.isEmpty() ||
            password == null || password.isEmpty()) {

            request.setAttribute("error", "帳號與密碼不可空白");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        // 組一個 User 物件
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);  // 目前先純文字（專題階段 OK）
        user.setName(name);
        user.setAddress(address);
        user.setEmail(email);
        user.setRole("user");        // 一般註冊者都是 user

        UserDAO dao = new UserDAO();
        boolean ok = dao.register(user);

        if (ok) {
            // 註冊成功：可以選擇直接導向登入頁，或自動登入

            // 這裡先做：導回登入頁，順便顯示一個成功訊息
            request.setAttribute("message", "註冊成功，請登入。");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);

        } else {
            // 註冊失敗（例如帳號重複、DB 例外）
            request.setAttribute("error", "註冊失敗，帳號可能已存在。");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }
}
