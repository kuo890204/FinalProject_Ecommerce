<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>

<%
    Product p = (Product) request.getAttribute("product");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= p != null ? p.getName() + " - " : "" %>商品詳情 - 電商平台</title>
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
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

.product-detail {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
}

.product-layout {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
    padding: 3rem;
}

.product-image-section {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.product-image {
    width: 100%;
    aspect-ratio: 1;
    background: linear-gradient(135deg, #FAF8F3 0%, #F5F2ED 100%);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 8rem;
    border: 2px solid #E8E3D8;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.product-image-name {
    text-align: center;
    color: #8B8B8B;
    font-size: 0.875rem;
    padding: 0.5rem;
    background: #FAF8F3;
    border-radius: 6px;
}

.product-info-section {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.product-category {
    display: inline-block;
    padding: 0.375rem 1rem;
    background-color: rgba(212, 165, 116, 0.1);
    color: #B88A5F;
    border-radius: 20px;
    font-size: 0.875rem;
    font-weight: 500;
    width: fit-content;
}

.product-name {
    font-size: 2rem;
    font-weight: 700;
    color: #4A4A4A;
    line-height: 1.3;
}

.product-id {
    color: #8B8B8B;
    font-size: 0.875rem;
}

.product-price {
    font-size: 2.5rem;
    font-weight: 700;
    color: #D4A574;
    margin: 0.5rem 0;
}

.product-stock {
    font-size: 1.125rem;
    padding: 1rem;
    background: #FAF8F3;
    border-radius: 8px;
    border-left: 4px solid #9CAF88;
}

.stock-label {
    color: #8B8B8B;
    font-weight: 500;
}

.stock-value {
    font-weight: 600;
    margin-left: 0.5rem;
}

.stock-available {
    color: #9CAF88;
}

.stock-low {
    color: #E8B4B8;
}

.stock-out {
    color: #D99DA1;
}

.product-actions {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
}

.btn {
    flex: 1;
    padding: 1rem 1.5rem;
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
    display: inline-block;
}

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover:not(:disabled) {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

.btn-primary:disabled {
    background-color: #E8E3D8;
    cursor: not-allowed;
    opacity: 0.6;
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

.divider {
    height: 1px;
    background: #E8E3D8;
    margin: 1.5rem 0;
}

.product-meta {
    display: grid;
    gap: 0.75rem;
}

.meta-item {
    display: flex;
    align-items: center;
    padding: 0.75rem;
    background: #FFFBF7;
    border-radius: 6px;
}

.meta-label {
    font-weight: 500;
    color: #8B8B8B;
    min-width: 80px;
}

.meta-value {
    color: #4A4A4A;
    font-weight: 600;
}

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

@media (max-width: 992px) {
    .product-layout {
        grid-template-columns: 1fr;
        gap: 2rem;
        padding: 2rem;
    }

    .product-image {
        max-width: 500px;
        margin: 0 auto;
    }
}

@media (max-width: 576px) {
    .container {
        padding: 1rem;
    }

    .product-layout {
        padding: 1.5rem;
    }

    .product-name {
        font-size: 1.5rem;
    }

    .product-price {
        font-size: 2rem;
    }

    .product-actions {
        flex-direction: column;
    }
}
</style>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <% if (p != null) { %>
        <%
            boolean isLowStock = p.getStock() < 10;
            boolean isOutOfStock = p.getStock() == 0;
            String stockClass = isOutOfStock ? "stock-out" : (isLowStock ? "stock-low" : "stock-available");
            String stockText = isOutOfStock ? "已售完" : (isLowStock ? "即將售完" : "供貨充足");
        %>

        <div class="product-detail">
            <div class="product-layout">
                <!-- 左側：商品圖片 -->
                <div class="product-image-section">
                    <div class="product-image">
                        <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                            <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                        <% } else { %>
                            📦
                        <% } %>
                    </div>
                </div>

                <!-- 右側：商品資訊 -->
                <div class="product-info-section">
                    <span class="product-category"><%= p.getCategory() %></span>

                    <div>
                        <h1 class="product-name"><%= p.getName() %></h1>
                        <p class="product-id">商品編號：#<%= p.getId() %></p>
                    </div>

                    <div class="product-price">
                        $<%= String.format("%,d", (int)p.getPrice()) %>
                    </div>

                    <div class="product-stock">
                        <span class="stock-label">庫存狀態：</span>
                        <span class="stock-value <%= stockClass %>">
                            <%= p.getStock() %> 件 (<%= stockText %>)
                        </span>
                    </div>

                    <div class="divider"></div>

                    <div class="product-meta">
                        <div class="meta-item">
                            <span class="meta-label">💰 單價</span>
                            <span class="meta-value">NT$ <%= String.format("%,d", (int)p.getPrice()) %></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">📦 庫存</span>
                            <span class="meta-value"><%= p.getStock() %> 件</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">🏷️ 分類</span>
                            <span class="meta-value"><%= p.getCategory() %></span>
                        </div>
                    </div>

                    <div class="product-actions">
                        <form action="<%= ctx %>/AddToCart" method="post" style="flex: 2;">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <button type="submit" class="btn btn-primary" <%= isOutOfStock ? "disabled" : "" %>>
                                <%= isOutOfStock ? "已售完" : "🛒 加入購物車" %>
                            </button>
                        </form>
                        <a href="<%= ctx %>/ProductList" class="btn btn-secondary" style="flex: 1;">
                            返回列表
                        </a>
                    </div>
                </div>
            </div>
        </div>

    <% } else { %>

        <div class="empty-state">
            <div class="empty-state-icon">❌</div>
            <div class="empty-state-text">沒有取得商品資料</div>
            <a href="<%= ctx %>/ProductList" class="btn btn-primary" style="max-width: 200px; margin: 0 auto;">回商品列表</a>
        </div>

    <% } %>
</div>

</body>
</html>
