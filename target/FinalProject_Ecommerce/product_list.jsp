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
.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 2rem;
    padding-bottom: 0.75rem;
    border-bottom: 3px solid #D4A574;
    display: inline-block;
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
}

.product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 16px rgba(212, 165, 116, 0.15);
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
    <h1 class="page-title">🛍️ 商品列表</h1>

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
            <div class="product-image">
                📦
            </div>

            <div class="product-info">
                <a href="ProductDetail?id=<%= p.getId() %>" class="product-name">
                    <%= p.getName() %>
                </a>

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
