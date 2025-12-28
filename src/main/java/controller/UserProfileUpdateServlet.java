package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/user/profile/update")
public class UserProfileUpdateServlet extends HttpServlet {

    // 處理更新會員資料（POST）
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // 檢查是否已登入
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // 取得表單資料
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // 驗證欄位
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            request.setAttribute("error", "姓名和電子郵件為必填欄位");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/user_profile.jsp").forward(request, response);
            return;
        }

        // 更新用戶資料
        User updateUser = new User();
        updateUser.setId(loginUser.getId());
        updateUser.setName(name);
        updateUser.setEmail(email);
        updateUser.setAddress(address);

        UserDAO dao = new UserDAO();
        boolean success = dao.updateUser(updateUser);

        if (success) {
            // 更新 Session 中的用戶資料
            User refreshedUser = dao.getUserById(loginUser.getId());
            if (refreshedUser != null) {
                session.setAttribute("loginUser", refreshedUser);
            }

            request.setAttribute("success", "會員資料更新成功");
            request.setAttribute("user", refreshedUser);
        } else {
            request.setAttribute("error", "更新失敗，請稍後再試");
            request.setAttribute("user", loginUser);
        }

        request.getRequestDispatcher("/user_profile.jsp").forward(request, response);
    }
}
