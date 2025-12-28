package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ProductDAO;

@WebServlet("/admin/products/bulkDelete")
public class AdminProductBulkDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 檢查管理員權限
        HttpSession session = request.getSession();
        model.User loginUser = (model.User) session.getAttribute("loginUser");

        if (loginUser == null || !"admin".equals(loginUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        // 取得選中的商品 ID 陣列
        String[] productIds = request.getParameterValues("productIds");

        if (productIds != null && productIds.length > 0) {
            ProductDAO dao = new ProductDAO();
            int successCount = 0;
            int failCount = 0;

            // 逐一刪除商品
            for (String idStr : productIds) {
                try {
                    int productId = Integer.parseInt(idStr);
                    dao.deleteProduct(productId);
                    successCount++;
                } catch (Exception e) {
                    failCount++;
                    e.printStackTrace();
                }
            }

            // 設定結果訊息
            if (failCount > 0) {
                request.getSession().setAttribute("message",
                    "批量刪除完成：成功 " + successCount + " 項，失敗 " + failCount + " 項");
            } else {
                request.getSession().setAttribute("message",
                    "成功刪除 " + successCount + " 項商品");
            }
        }

        // 重新導向到商品列表
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
