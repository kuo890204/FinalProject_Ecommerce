<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員登入 - 電商平台</title>
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
    max-width: 450px;
    margin: 3rem auto;
    padding: 2rem;
}

.login-card {
    background: white;
    border-radius: 12px;
    padding: 2.5rem;
    box-shadow: 0 4px 16px rgba(212, 165, 116, 0.12);
    border: 1px solid #E8E3D8;
}

.login-header {
    text-align: center;
    margin-bottom: 2rem;
}

.login-icon {
    font-size: 3rem;
    margin-bottom: 0.5rem;
}

.login-title {
    color: #4A4A4A;
    font-size: 1.75rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.login-subtitle {
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
    margin-bottom: 0.75rem;
}

.btn-secondary:hover {
    background-color: #F5F2ED;
    border-color: #D4A574;
}

.divider {
    display: flex;
    align-items: center;
    text-align: center;
    margin: 1.5rem 0;
    color: #8B8B8B;
    font-size: 0.875rem;
}

.divider::before,
.divider::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid #E8E3D8;
}

.divider span {
    padding: 0 1rem;
}

.link-text {
    color: #8B8B8B;
    font-size: 0.875rem;
    text-align: center;
    margin-top: 1rem;
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

@media (max-width: 576px) {
    .container {
        margin: 2rem auto;
        padding: 1rem;
    }

    .login-card {
        padding: 2rem 1.5rem;
    }

    .login-title {
        font-size: 1.5rem;
    }
}
</style>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-icon">🔐</div>
            <h1 class="login-title">會員登入</h1>
            <p class="login-subtitle">登入您的帳號以繼續購物</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert alert-error">
            <span class="alert-icon">⚠️</span>
            <span><%= error %></span>
        </div>
        <%
            }
        %>

        <form action="Login" method="post">
            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">👤</span>
                    帳號
                </label>
                <input type="text" name="username" class="form-input" placeholder="請輸入帳號" required autofocus>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <span class="form-label-icon">🔑</span>
                    密碼
                </label>
                <input type="password" name="password" class="form-input" placeholder="請輸入密碼" required>
            </div>

            <button type="submit" class="btn btn-primary">登入</button>
        </form>

        <div class="divider">
            <span>或</span>
        </div>

        <a href="Register" class="btn btn-secondary">
            還沒有帳號？立即註冊
        </a>

        <a href="ProductList" class="btn btn-secondary">
            先去逛逛商品（訪客模式）
        </a>

        <p class="link-text">
            登入即表示您同意我們的
            <a href="#">服務條款</a> 和 <a href="#">隱私政策</a>
        </p>
    </div>
</div>

</body>
</html>
