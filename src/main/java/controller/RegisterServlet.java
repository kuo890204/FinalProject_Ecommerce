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

        // 1️ 簡單必填檢查
        if (username == null || username.isEmpty() ||
            password == null || password.isEmpty()) {

            request.setAttribute("error", "帳號與密碼不可空白");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // 2️ 先檢查帳號是否存在
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "這個帳號已經被使用了");

            // 順便把使用者剛剛填的資料帶回去（除了密碼）
            request.setAttribute("username", username);
            request.setAttribute("name", name);
            request.setAttribute("address", address);
            request.setAttribute("email", email);

            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3️ 組 User 物件（帳號可用，才建 User）
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); 
        user.setName(name);
        user.setAddress(address);
        user.setEmail(email);
        user.setRole("user");        // 一般註冊者都是 user

        // 4️ 寫入資料庫
        boolean ok = userDAO.register(user);   // ✅ 這裡改成 userDAO

        if (ok) {
            // 5️⃣ 註冊成功 → 回登入頁
            request.setAttribute("message", "註冊成功，請登入。");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);

        } else {
            // 6️⃣ 註冊失敗（DB 發生例外等等）
            request.setAttribute("error", "註冊失敗，請稍後再試。");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }
}
