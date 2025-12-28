package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {

    // 顯示會員資料頁面（GET）
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // 檢查是否已登入
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 從資料庫重新取得最新的用戶資料
        UserDAO dao = new UserDAO();
        User currentUser = dao.getUserById(loginUser.getId());

        if (currentUser != null) {
            request.setAttribute("user", currentUser);
        } else {
            request.setAttribute("error", "無法取得用戶資料");
        }

        request.getRequestDispatcher("/user_profile.jsp").forward(request, response);
    }
}
