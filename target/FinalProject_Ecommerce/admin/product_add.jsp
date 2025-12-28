<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增商品 - 電商平台</title>
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
    max-width: 700px;
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

.form-card {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
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

.btn-success {
    background-color: #9CAF88;
    color: white;
}

.btn-success:hover {
    background-color: #87996F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(156, 175, 136, 0.3);
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

@media (max-width: 576px) {
    .container {
        padding: 1rem;
    }

    .form-card {
        padding: 1.5rem;
    }

    .form-actions {
        flex-direction: column;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<%
    String ctx = request.getContextPath();
%>

<div class="container">
    <h1 class="page-title">➕ 新增商品</h1>

    <div class="form-card">
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert alert-error">
            <span>⚠️</span>
            <span><%= error %></span>
        </div>
        <%
            }
        %>

        <form action="<%= ctx %>/admin/products/add" method="post">
            <div class="form-group">
                <label class="form-label">
                    商品名稱
                    <span class="required">*</span>
                </label>
                <input type="text"
                       name="name"
                       class="form-input"
                       placeholder="請輸入商品名稱"
                       value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    價格
                    <span class="required">*</span>
                </label>
                <input type="number"
                       name="price"
                       class="form-input"
                       placeholder="請輸入價格"
                       value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>"
                       required
                       min="0"
                       step="0.01">
            </div>

            <div class="form-group">
                <label class="form-label">
                    庫存數量
                    <span class="required">*</span>
                </label>
                <input type="number"
                       name="stock"
                       class="form-input"
                       placeholder="請輸入庫存數量"
                       value="<%= request.getAttribute("stock") != null ? request.getAttribute("stock") : "" %>"
                       required
                       min="0">
            </div>

            <div class="form-group">
                <label class="form-label">
                    分類
                    <span class="required">*</span>
                </label>
                <input type="text"
                       name="category"
                       class="form-input"
                       placeholder="請輸入商品分類"
                       value="<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    圖片路徑
                </label>
                <input type="text"
                       name="image"
                       class="form-input"
                       placeholder="請輸入圖片檔名或路徑（選填）"
                       value="<%= request.getAttribute("image") != null ? request.getAttribute("image") : "" %>">
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-success">新增商品</button>
                <a href="<%= ctx %>/admin/products" class="btn btn-secondary">返回列表</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
