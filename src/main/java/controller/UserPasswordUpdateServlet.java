package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

@WebServlet("/user/password/update")
public class UserPasswordUpdateServlet extends HttpServlet {

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
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 驗證欄位
        if (oldPassword == null || oldPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("passwordError", "所有欄位均為必填");
            request.getRequestDispatcher("/user/profile").forward(request, response);
            return;
        }

        // 驗證新密碼與確認密碼是否一致
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "新密碼與確認密碼不一致");
            request.getRequestDispatcher("/user/profile").forward(request, response);
            return;
        }

        // 驗證新密碼長度
        if (newPassword.length() < 6) {
            request.setAttribute("passwordError", "新密碼長度至少需要 6 個字元");
            request.getRequestDispatcher("/user/profile").forward(request, response);
            return;
        }

        // 取得用戶資料並驗證舊密碼
        UserDAO dao = new UserDAO();
        User currentUser = dao.getUserById(loginUser.getId());

        if (currentUser == null) {
            request.setAttribute("passwordError", "無法取得用戶資料");
            request.getRequestDispatcher("/user/profile").forward(request, response);
            return;
        }

        // 驗證舊密碼是否正確
        boolean oldPasswordCorrect = PasswordUtil.checkPassword(oldPassword, currentUser.getPassword());
        if (!oldPasswordCorrect) {
            request.setAttribute("passwordError", "舊密碼輸入錯誤");
            request.getRequestDispatcher("/user/profile").forward(request, response);
            return;
        }

        // 更新密碼
        boolean success = dao.updatePassword(loginUser.getId(), newPassword);

        if (success) {
            request.setAttribute("passwordSuccess", "密碼修改成功");
        } else {
            request.setAttribute("passwordError", "密碼修改失敗，請稍後再試");
        }

        request.getRequestDispatcher("/user/profile").forward(request, response);
    }
}
