package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import model.User;

@WebFilter(urlPatterns = {
    "/Cart",
    "/AddToCart",
    "/UpdateCartQuantity",
    "/UpdateCartItem",
    "/DeleteCartItem",
    "/ClearCart",
    "/Checkout"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        User loginUser = (session == null) ? null : (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 沒登入 → 統一導去 Login（用 ctx 保險）
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        chain.doFilter(req, res); // ✅ 放行
    }
}
