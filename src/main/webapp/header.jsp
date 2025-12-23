<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    String ctx = request.getContextPath();
    User loginUser = (User) session.getAttribute("loginUser");
%>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans TC', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background-color: #FAF8F3;
    color: #4A4A4A;
    line-height: 1.6;
}

/* 導航列容器 */
.navbar {
    background: linear-gradient(135deg, #D4A574 0%, #C9996E 100%);
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.15);
    padding: 0;
    position: sticky;
    top: 0;
    z-index: 1000;
    border-bottom: 3px solid #B88A5F;
}

.navbar-container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 2rem;
    height: 65px;
}

/* Logo 區域 */
.navbar-logo {
    font-size: 1.5rem;
    font-weight: 700;
    color: white;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    letter-spacing: 1px;
    transition: all 0.3s;
}

.navbar-logo:hover {
    color: #FAF8F3;
    transform: translateY(-2px);
}

/* 導航連結區域 */
.navbar-links {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.navbar-link {
    color: white;
    text-decoration: none;
    padding: 0.625rem 1rem;
    border-radius: 6px;
    font-weight: 500;
    font-size: 0.95rem;
    transition: all 0.2s;
    white-space: nowrap;
}

.navbar-link:hover {
    background-color: rgba(255, 255, 255, 0.15);
    transform: translateY(-1px);
}

/* 使用者資訊 */
.user-info {
    color: white;
    padding: 0.625rem 1rem;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 6px;
    font-weight: 500;
    font-size: 0.95rem;
}

.user-name {
    font-weight: 600;
    color: #FFFBF7;
}

/* 分隔線 */
.navbar-divider {
    width: 1px;
    height: 20px;
    background-color: rgba(255, 255, 255, 0.3);
    margin: 0 0.25rem;
}

/* 管理員專屬按鈕 */
.admin-link {
    background-color: rgba(156, 175, 136, 0.3);
    border: 1px solid rgba(156, 175, 136, 0.5);
}

.admin-link:hover {
    background-color: rgba(156, 175, 136, 0.5);
}

/* 登出按鈕 */
.logout-link {
    background-color: rgba(232, 180, 184, 0.3);
    border: 1px solid rgba(232, 180, 184, 0.5);
}

.logout-link:hover {
    background-color: rgba(232, 180, 184, 0.5);
}

/* 購物車圖示 */
.cart-icon {
    position: relative;
}

.cart-badge {
    position: absolute;
    top: -8px;
    right: -8px;
    background-color: #E8B4B8;
    color: white;
    font-size: 0.75rem;
    font-weight: 600;
    padding: 2px 6px;
    border-radius: 10px;
    min-width: 18px;
    text-align: center;
}

/* 響應式設計 */
@media (max-width: 768px) {
    .navbar-container {
        flex-direction: column;
        height: auto;
        padding: 1rem;
        gap: 1rem;
    }

    .navbar-links {
        flex-wrap: wrap;
        justify-content: center;
    }
}

/* 頁面標題樣式 */
.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 1.5rem;
    padding-bottom: 0.75rem;
    border-bottom: 3px solid #D4A574;
    display: inline-block;
}

/* 空狀態樣式 */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
}

.empty-state-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
}

.empty-state-text {
    font-size: 1.125rem;
    color: #8B8B8B;
    margin-bottom: 1.5rem;
}
</style>

<header class="navbar">
    <div class="navbar-container">
        <!-- Logo -->
        <a href="<%= ctx %>/ProductList" class="navbar-logo">
            🛍️ 電商平台
        </a>

        <!-- 導航連結 -->
        <nav class="navbar-links">
            <a href="<%= ctx %>/ProductList" class="navbar-link">首頁</a>

            <div class="navbar-divider"></div>

            <a href="<%= ctx %>/Cart" class="navbar-link cart-icon">
                🛒 購物車
            </a>

            <% if (loginUser != null) { %>
                <div class="navbar-divider"></div>

                <span class="user-info">
                    嗨，<span class="user-name"><%= (loginUser.getName() != null && !loginUser.getName().isEmpty())
                             ? loginUser.getName()
                             : loginUser.getUsername() %></span>
                </span>

                <% if ("admin".equals(loginUser.getRole())) { %>
                    <div class="navbar-divider"></div>
                    <a href="<%= ctx %>/admin/products" class="navbar-link admin-link">📦 商品管理</a>
                    <a href="<%= ctx %>/admin/orders" class="navbar-link admin-link">📋 訂單管理</a>
                <% } %>

                <a href="<%= ctx %>/Logout" class="navbar-link logout-link">登出</a>

            <% } else { %>
                <div class="navbar-divider"></div>
                <a href="<%= ctx %>/Login" class="navbar-link">登入</a>
                <a href="<%= ctx %>/Register" class="navbar-link">註冊</a>
            <% } %>
        </nav>
    </div>
</header>
