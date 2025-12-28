<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員註冊 - 電商平台</title>
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
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.container {
    max-width: 600px;
    margin: 3rem auto;
    padding: 2rem;
}

.register-card {
    background: white;
    border-radius: 12px;
    padding: 2.5rem;
    box-shadow: 0 4px 16px rgba(212, 165, 116, 0.12);
    border: 1px solid #E8E3D8;
}

.register-header {
    text-align: center;
    margin-bottom: 2rem;
}

.register-icon {
    font-size: 3rem;
    margin-bottom: 0.5rem;
}

.register-title {
    color: #4A4A4A;
    font-size: 1.75rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.register-subtitle {
    color: #8B8B8B;
    font-size: 0.95rem;
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

.alert-icon {
    font-size: 1.25rem;
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

.form-label-icon {
    margin-right: 0.375rem;
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

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
}

.btn {
    display: block;
    width: 100%;
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
    margin-bottom: 1rem;
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
}

.link-text {
    color: #8B8B8B;
    font-size: 0.875rem;
    text-align: center;
    margin-top: 1.5rem;
}

.link-text a {
    color: #D4A574;
    text-decoration: none;
    font-weight: 500;
}

.link-text a:hover {
    color: #B88A5F;
    text-decoration: underline;
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 576px) {
    .container {
        margin: 2rem auto;
        padding: 1rem;
    }

    .register-card {
        padding: 2rem 1.5rem;
    }

    .register-title {
        font-size: 1.5rem;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="register-card">
        <div class="register-header">
            <div class="register-icon">📝</div>
            <h1 class="register-title">會員註冊</h1>
            <p class="register-subtitle">建立新帳號，開始您的購物之旅</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
        %>

        <% if (error != null) { %>
        <div class="alert alert-error">
            <span class="alert-icon">⚠️</span>
            <span><%= error %></span>
        </div>
        <% } %>

        <% if (message != null) { %>
        <div class="alert alert-success">
            <span class="alert-icon">✅</span>
            <span><%= message %></span>
        </div>
        <% } %>

        <form action="Register" method="post">
            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">👤</span>
                    帳號
                    <span class="required">*</span>
                </label>
                <input type="text"
                       name="username"
                       class="form-input"
                       placeholder="請輸入帳號（用於登入）"
                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                       required
                       autofocus>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">🔑</span>
                    密碼
                    <span class="required">*</span>
                </label>
                <input type="password"
                       name="password"
                       class="form-input"
                       placeholder="請輸入密碼"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">✏️</span>
                    姓名
                    <span class="required">*</span>
                </label>
                <input type="text"
                       name="name"
                       class="form-input"
                       placeholder="請輸入真實姓名"
                       value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">📧</span>
                    Email
                    <span class="required">*</span>
                </label>
                <input type="email"
                       name="email"
                       class="form-input"
                       placeholder="example@email.com"
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">🏠</span>
                    地址
                </label>
                <input type="text"
                       name="address"
                       class="form-input"
                       placeholder="請輸入完整地址（選填）"
                       value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>">
            </div>

            <button type="submit" class="btn btn-primary">註冊</button>
        </form>

        <a href="Login" class="btn btn-secondary">
            已經有帳號？返回登入
        </a>

        <p class="link-text">
            註冊即表示您同意我們的
            <a href="#">服務條款</a> 和 <a href="#">隱私政策</a>
        </p>
    </div>
</div>

</body>
</html>
