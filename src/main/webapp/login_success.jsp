<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登入成功 - 電商平台</title>
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
    max-width: 550px;
    margin: 5rem auto;
    padding: 2rem;
}

.success-card {
    background: white;
    border-radius: 12px;
    padding: 3rem 2.5rem;
    box-shadow: 0 4px 16px rgba(212, 165, 116, 0.12);
    border: 1px solid #E8E3D8;
    text-align: center;
}

.success-icon {
    font-size: 5rem;
    margin-bottom: 1.5rem;
    animation: bounce 0.6s ease;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-20px); }
}

.success-title {
    color: #9CAF88;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 1rem;
}

.welcome-text {
    color: #4A4A4A;
    font-size: 1.125rem;
    margin-bottom: 0.5rem;
}

.username {
    color: #D4A574;
    font-weight: 700;
    font-size: 1.5rem;
}

.redirect-notice {
    color: #8B8B8B;
    font-size: 0.875rem;
    margin: 2rem 0 1.5rem;
    padding: 1rem;
    background: #FAF8F3;
    border-radius: 8px;
}

.btn {
    display: inline-block;
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
    margin-bottom: 1rem;
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

@media (max-width: 576px) {
    .container {
        margin: 3rem auto;
        padding: 1rem;
    }

    .success-card {
        padding: 2rem 1.5rem;
    }

    .success-title {
        font-size: 1.5rem;
    }

    .success-icon {
        font-size: 3.5rem;
    }

    .username {
        font-size: 1.25rem;
    }
}
</style>
<script>
// 5秒後自動跳轉到商品列表
setTimeout(function() {
    window.location.href = 'ProductList';
}, 5000);
</script>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="success-card">
        <div class="success-icon">🎉</div>
        <h1 class="success-title">登入成功！</h1>
        <p class="welcome-text">歡迎回來，</p>
        <div class="username"><%= session.getAttribute("username") %></div>

        <div class="redirect-notice">
            ⏱️ 5 秒後將自動跳轉至商品列表...
        </div>

        <a href="ProductList" class="btn btn-primary">立即前往商品列表</a>
    </div>
</div>

</body>
</html>
