package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 拿到現有 Session（不建立新的，所以用 false）
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 把這個使用者的 Session 資料全部清掉 = 登出
            session.invalidate();
        }

        // 登出後導回登入頁或首頁
        response.sendRedirect("Login");
    }
}
