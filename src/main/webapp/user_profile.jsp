<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    String ctx = request.getContextPath();
    User user = (User) request.getAttribute("user");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String passwordError = (String) request.getAttribute("passwordError");
    String passwordSuccess = (String) request.getAttribute("passwordSuccess");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員資料 - 電商平台</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;600;700&display=swap" rel="stylesheet">
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

.container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 2rem;
    padding-bottom: 0.75rem;
    border-bottom: 3px solid #D4A574;
    display: inline-block;
}

.profile-card {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    margin-bottom: 1.5rem;
}

.alert {
    padding: 1rem;
    border-radius: 8px;
    margin-bottom: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.alert-error {
    background-color: rgba(232, 180, 184, 0.15);
    border: 1px solid #E8B4B8;
    color: #B8686E;
}

.alert-success {
    background-color: rgba(156, 175, 136, 0.15);
    border: 1px solid #9CAF88;
    color: #6B7A5C;
}

.profile-section {
    margin-bottom: 2rem;
}

.section-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #4A4A4A;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #E8E3D8;
}

.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.info-item {
    display: flex;
    flex-direction: column;
    padding: 0.75rem;
    background: #FAF8F3;
    border-radius: 8px;
}

.info-label {
    font-weight: 500;
    color: #8B8B8B;
    font-size: 0.875rem;
    margin-bottom: 0.25rem;
}

.info-value {
    font-weight: 600;
    color: #4A4A4A;
    font-size: 1rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
    color: #4A4A4A;
    font-size: 0.95rem;
}

.required {
    color: #E8B4B8;
    margin-left: 0.25rem;
}

.form-input {
    width: 100%;
    padding: 0.875rem 1rem;
    border: 1px solid #E8E3D8;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.2s;
    font-family: inherit;
}

.form-input:focus {
    outline: none;
    border-color: #D4A574;
    box-shadow: 0 0 0 3px rgba(212, 165, 116, 0.1);
}

.form-input:disabled {
    background-color: #F5F2ED;
    color: #8B8B8B;
    cursor: not-allowed;
}

.form-actions {
    display: flex;
    gap: 1rem;
    margin-top: 2rem;
}

.btn {
    flex: 1;
    padding: 0.875rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
    text-align: center;
    font-family: inherit;
    letter-spacing: 0.5px;
}

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

.btn-secondary {
    background-color: #FAF8F3;
    color: #4A4A4A;
    border: 1px solid #E8E3D8;
}

.btn-secondary:hover {
    background-color: #F5F2ED;
    border-color: #D4A574;
    transform: translateY(-1px);
}

.quick-links {
    display: flex;
    gap: 1rem;
    margin-top: 1.5rem;
}

.quick-link {
    flex: 1;
    display: block;
    padding: 1rem;
    background: #FFFBF7;
    border: 1px solid #E8E3D8;
    border-radius: 8px;
    text-align: center;
    text-decoration: none;
    color: #4A4A4A;
    font-weight: 500;
    transition: all 0.2s;
}

.quick-link:hover {
    background: white;
    border-color: #D4A574;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(212, 165, 116, 0.15);
}

@media (max-width: 768px) {
    .info-grid {
        grid-template-columns: 1fr;
    }

    .form-actions, .quick-links {
        flex-direction: column;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <h1 class="page-title">👤 會員資料</h1>

    <% if (error != null) { %>
        <div class="alert alert-error">
            <span>⚠️</span>
            <span><%= error %></span>
        </div>
    <% } %>

    <% if (success != null) { %>
        <div class="alert alert-success">
            <span>✅</span>
            <span><%= success %></span>
        </div>
    <% } %>

    <% if (user != null) { %>

        <!-- 帳號資訊（唯讀） -->
        <div class="profile-card">
            <div class="profile-section">
                <h2 class="section-title">帳號資訊</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">帳號</span>
                        <span class="info-value"><%= user.getUsername() %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">會員角色</span>
                        <span class="info-value"><%= "admin".equals(user.getRole()) ? "管理員" : "一般會員" %></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 個人資料（可編輯） -->
        <div class="profile-card">
            <div class="profile-section">
                <h2 class="section-title">個人資料</h2>

                <form action="<%= ctx %>/user/profile/update" method="post">
                    <div class="form-group">
                        <label class="form-label">
                            姓名
                            <span class="required">*</span>
                        </label>
                        <input type="text"
                               name="name"
                               class="form-input"
                               placeholder="請輸入姓名"
                               value="<%= user.getName() != null ? user.getName() : "" %>"
                               required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            電子郵件
                            <span class="required">*</span>
                        </label>
                        <input type="email"
                               name="email"
                               class="form-input"
                               placeholder="請輸入電子郵件"
                               value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                               required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            地址
                        </label>
                        <input type="text"
                               name="address"
                               class="form-input"
                               placeholder="請輸入地址（選填）"
                               value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">儲存變更</button>
                        <a href="<%= ctx %>/ProductList" class="btn btn-secondary">取消</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- 密碼修改（獨立區塊） -->
        <div class="profile-card">
            <div class="profile-section">
                <h2 class="section-title">修改密碼</h2>

                <% if (passwordError != null) { %>
                    <div class="alert alert-error">
                        <span>⚠️</span>
                        <span><%= passwordError %></span>
                    </div>
                <% } %>

                <% if (passwordSuccess != null) { %>
                    <div class="alert alert-success">
                        <span>✅</span>
                        <span><%= passwordSuccess %></span>
                    </div>
                <% } %>

                <form action="<%= ctx %>/user/password/update" method="post">
                    <div class="form-group">
                        <label class="form-label">
                            舊密碼
                            <span class="required">*</span>
                        </label>
                        <input type="password"
                               name="oldPassword"
                               class="form-input"
                               placeholder="請輸入目前的密碼"
                               required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            新密碼
                            <span class="required">*</span>
                        </label>
                        <input type="password"
                               name="newPassword"
                               class="form-input"
                               placeholder="請輸入新密碼（至少 6 個字元）"
                               minlength="6"
                               required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            確認新密碼
                            <span class="required">*</span>
                        </label>
                        <input type="password"
                               name="confirmPassword"
                               class="form-input"
                               placeholder="請再次輸入新密碼"
                               minlength="6"
                               required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">更新密碼</button>
                        <button type="reset" class="btn btn-secondary">清除</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 快速連結 -->
        <div class="quick-links">
            <a href="<%= ctx %>/user/orders" class="quick-link">
                📋 歷史訂單
            </a>
            <a href="<%= ctx %>/Cart" class="quick-link">
                🛒 購物車
            </a>
            <a href="<%= ctx %>/ProductList" class="quick-link">
                🏠 商品列表
            </a>
        </div>

    <% } else { %>
        <div class="profile-card" style="text-align: center; padding: 3rem;">
            <p style="color: #8B8B8B; font-size: 1.125rem;">無法取得會員資料</p>
            <a href="<%= ctx %>/Login" class="btn btn-primary" style="margin-top: 1.5rem; max-width: 200px; margin-left: auto; margin-right: auto;">重新登入</a>
        </div>
    <% } %>
</div>

</body>
</html>
