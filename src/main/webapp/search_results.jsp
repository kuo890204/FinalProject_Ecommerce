<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<%
    String ctx = request.getContextPath();
    List<Product> productList = (List<Product>) request.getAttribute("productList");
    String keyword = (String) request.getAttribute("keyword");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>搜尋結果 - 電商平台</title>
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

.page-header {
    margin-bottom: 2rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.search-info {
    color: #8B8B8B;
    font-size: 1rem;
}

.search-keyword {
    color: #D4A574;
    font-weight: 600;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
    margin-bottom: 2rem;
}

.product-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    transition: all 0.3s;
    display: flex;
    flex-direction: column;
}

.product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 16px rgba(212, 165, 116, 0.15);
}

.product-image {
    width: 100%;
    height: 200px;
    background: #FAF8F3;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 4rem;
    margin-bottom: 1rem;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.product-name {
    font-size: 1.125rem;
    font-weight: 600;
    color: #4A4A4A;
    margin-bottom: 0.5rem;
}

.product-category {
    font-size: 0.875rem;
    color: #8B8B8B;
    margin-bottom: 0.75rem;
}

.product-price {
    font-size: 1.5rem;
    font-weight: 700;
    color: #D4A574;
    margin-bottom: 0.75rem;
}

.product-stock {
    font-size: 0.875rem;
    margin-bottom: 1rem;
}

.stock-available {
    color: #9CAF88;
}

.stock-low {
    color: #E8B4B8;
}

.stock-out {
    color: #B8686E;
}

.btn {
    display: block;
    width: 100%;
    padding: 0.875rem;
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
    margin-top: auto;
}

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
}

.btn-disabled {
    background-color: #E8E3D8;
    color: #8B8B8B;
    cursor: not-allowed;
}

.btn-disabled:hover {
    transform: none;
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

.btn-secondary {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background-color: #FAF8F3;
    color: #4A4A4A;
    border: 1px solid #E8E3D8;
    text-decoration: none;
}

.btn-secondary:hover {
    background-color: #F5F2ED;
    border-color: #D4A574;
    transform: translateY(-1px);
}

@media (max-width: 768px) {
    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1rem;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">🔍 搜尋結果</h1>
        <% if (keyword != null && !keyword.isEmpty()) { %>
            <p class="search-info">搜尋關鍵字：<span class="search-keyword">「<%= keyword %>」</span> - 找到 <%= productList != null ? productList.size() : 0 %> 筆結果</p>
        <% } else { %>
            <p class="search-info">顯示所有商品</p>
        <% } %>
    </div>

    <%
        if (productList == null || productList.isEmpty()) {
    %>
        <div class="empty-state">
            <div class="empty-state-icon">📦</div>
            <div class="empty-state-text">找不到符合條件的商品</div>
            <a href="<%= ctx %>/ProductList" class="btn btn-secondary">瀏覽所有商品</a>
        </div>
    <%
        } else {
    %>
        <div class="product-grid">
        <%
            for (Product p : productList) {
                boolean isOutOfStock = p.getStock() == 0;
                boolean isLowStock = p.getStock() > 0 && p.getStock() < 5;
        %>
            <div class="product-card">
                <div class="product-image">
                    <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                        <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                    <% } else { %>
                        📦
                    <% } %>
                </div>

                <h3 class="product-name"><%= p.getName() %></h3>
                <p class="product-category">分類：<%= p.getCategory() %></p>
                <div class="product-price">$<%= String.format("%,d", (int)p.getPrice()) %></div>

                <div class="product-stock">
                    <% if (isOutOfStock) { %>
                        <span class="stock-out">⚠️ 已售完</span>
                    <% } else if (isLowStock) { %>
                        <span class="stock-low">⏰ 僅剩 <%= p.getStock() %> 件</span>
                    <% } else { %>
                        <span class="stock-available">✓ 庫存充足</span>
                    <% } %>
                </div>

                <a href="<%= ctx %>/ProductDetail?id=<%= p.getId() %>"
                   class="btn <%= isOutOfStock ? "btn-disabled" : "btn-primary" %>">
                    <%= isOutOfStock ? "已售完" : "查看詳情" %>
                </a>
            </div>
        <%
            }
        %>
        </div>
    <%
        }
    %>
</div>

</body>
</html>
