<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品列表 - 電商平台</title>
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

/* 頁面標題 */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    padding-bottom: 0.75rem;
    border-bottom: 3px solid #D4A574;
}

/* 排序選單 */
.sort-container {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.sort-label {
    font-weight: 600;
    color: #4A4A4A;
    font-size: 0.95rem;
}

.sort-select {
    padding: 0.5rem 1rem;
    border: 1px solid #E8E3D8;
    border-radius: 8px;
    background-color: white;
    color: #4A4A4A;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    min-width: 180px;
}

.sort-select:hover {
    border-color: #D4A574;
    box-shadow: 0 2px 4px rgba(212, 165, 116, 0.1);
}

.sort-select:focus {
    outline: none;
    border-color: #D4A574;
    box-shadow: 0 0 0 3px rgba(212, 165, 116, 0.1);
}

/* 商品網格布局 */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

/* 商品卡片 */
.product-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    transition: all 0.3s;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    position: relative;
}

.product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 16px rgba(212, 165, 116, 0.15);
}

.product-card-link {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 1;
}

/* 商品圖片區域 */
.product-image {
    width: 100%;
    height: 200px;
    background: linear-gradient(135deg, #FAF8F3 0%, #F5F2ED 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 4rem;
    border-bottom: 2px solid #E8E3D8;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* 商品資訊區域 */
.product-info {
    padding: 1.25rem;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.product-name {
    font-size: 1.125rem;
    font-weight: 600;
    color: #4A4A4A;
    margin-bottom: 0.5rem;
    text-decoration: none;
    display: block;
    transition: color 0.2s;
}

.product-name:hover {
    color: #D4A574;
}

.product-category {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    background-color: rgba(212, 165, 116, 0.1);
    color: #B88A5F;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    margin-bottom: 0.75rem;
}

.product-price {
    font-size: 1.5rem;
    font-weight: 700;
    color: #D4A574;
    margin-bottom: 0.5rem;
}

.product-stock {
    font-size: 0.875rem;
    color: #8B8B8B;
    margin-bottom: 1rem;
}

.stock-available {
    color: #9CAF88;
    font-weight: 500;
}

.stock-low {
    color: #E8B4B8;
    font-weight: 500;
}

/* 商品底部操作區 */
.product-actions {
    margin-top: auto;
    position: relative;
    z-index: 2;
}

.btn-add-cart {
    width: 100%;
    padding: 0.75rem;
    background-color: #D4A574;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    letter-spacing: 0.5px;
}

.btn-add-cart:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(212, 165, 116, 0.3);
}

.btn-add-cart:disabled {
    background-color: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}

/* 空狀態 */
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

/* 響應式設計 */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }

    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 1rem;
    }

    .page-title {
        font-size: 1.5rem;
    }
}
</style>
</head>

<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">🛍️ 商品列表</h1>

        <div class="sort-container">
            <label class="sort-label">排序：</label>
            <select class="sort-select" onchange="location.href='ProductList?sort=' + this.value">
                <option value="default" <%= "default".equals(request.getAttribute("currentSort")) ? "selected" : "" %>>預設排序</option>
                <option value="price_asc" <%= "price_asc".equals(request.getAttribute("currentSort")) ? "selected" : "" %>>價格：低到高</option>
                <option value="price_desc" <%= "price_desc".equals(request.getAttribute("currentSort")) ? "selected" : "" %>>價格：高到低</option>
                <option value="name_asc" <%= "name_asc".equals(request.getAttribute("currentSort")) ? "selected" : "" %>>名稱：A-Z</option>
                <option value="name_desc" <%= "name_desc".equals(request.getAttribute("currentSort")) ? "selected" : "" %>>名稱：Z-A</option>
            </select>
        </div>
    </div>

    <%
        List<Product> list = (List<Product>) request.getAttribute("productList");

        if (list != null && !list.isEmpty()) {
    %>

    <div class="product-grid">
        <%
            for (Product p : list) {
                boolean isLowStock = p.getStock() < 10;
                boolean isOutOfStock = p.getStock() == 0;
        %>

        <div class="product-card">
            <a href="ProductDetail?id=<%= p.getId() %>" class="product-card-link"></a>

            <div class="product-image">
                <% if (p.getImage() != null && !p.getImage().isEmpty()) { %>
                    <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
                <% } else { %>
                    📦
                <% } %>
            </div>

            <div class="product-info">
                <div class="product-name">
                    <%= p.getName() %>
                </div>

                <span class="product-category"><%= p.getCategory() %></span>

                <div class="product-price">
                    $<%= String.format("%,d", (int)p.getPrice()) %>
                </div>

                <div class="product-stock">
                    庫存：
                    <span class="<%= isOutOfStock ? "stock-low" : (isLowStock ? "stock-low" : "stock-available") %>">
                        <%= p.getStock() %> 件
                        <%= isOutOfStock ? "（已售完）" : (isLowStock ? "（即將售完）" : "") %>
                    </span>
                </div>

                <div class="product-actions">
                    <form action="AddToCart" method="post">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn-add-cart" <%= isOutOfStock ? "disabled" : "" %>>
                            <%= isOutOfStock ? "已售完" : "🛒 加入購物車" %>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%
            }
        %>
    </div>

    <%
        } else {
    %>

    <div class="empty-state">
        <div class="empty-state-icon">📦</div>
        <div class="empty-state-text">目前沒有任何商品資料</div>
    </div>

    <%
        }
    %>
</div>

</body>
</html>
