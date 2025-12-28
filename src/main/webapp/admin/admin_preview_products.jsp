<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>預覽商品列表 - 電商平台</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

/* 商品卡片網格 */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1.5rem;
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
    text-decoration: none;
    margin-bottom: 0.5rem;
    display: block;
    transition: color 0.2s;
}

.product-name:hover {
    color: #D4A574;
}

.product-category {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    background-color: #FAF8F3;
    color: #9CAF88;
    border-radius: 4px;
    font-size: 0.875rem;
    font-weight: 500;
    margin-bottom: 0.75rem;
}

.product-price {
    font-size: 1.5rem;
    font-weight: 700;
    color: #D4A574;
    margin-bottom: 0.75rem;
}

.product-stock {
    font-size: 0.9rem;
    color: #8B8B8B;
    margin-bottom: 1rem;
}

.stock-available {
    color: #9CAF88;
    font-weight: 600;
}

.stock-low {
    color: #E8B4B8;
    font-weight: 600;
}

/* 按鈕容器 */
.product-actions {
    margin-top: auto;
    display: flex;
    gap: 0.5rem;
    position: relative;
    z-index: 2;
}

/* 管理員編輯按鈕 */
.btn-edit {
    flex: 1;
    padding: 0.75rem;
    background-color: #D4A574;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
    text-align: center;
    display: inline-block;
}

.btn-edit:hover {
    background-color: #B88A5F;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

/* 管理員刪除按鈕 */
.btn-delete {
    flex: 1;
    padding: 0.75rem;
    background-color: #E8B4B8;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
    text-align: center;
    display: inline-block;
}

.btn-delete:hover {
    background-color: #D89FA3;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(232, 180, 184, 0.3);
}

/* 管理員提示標籤 */
.admin-badge {
    display: inline-block;
    padding: 0.5rem 1rem;
    background: linear-gradient(135deg, #9CAF88 0%, #8A9B7A 100%);
    color: white;
    border-radius: 8px;
    font-weight: 600;
    margin-bottom: 1rem;
    box-shadow: 0 2px 8px rgba(156, 175, 136, 0.2);
}

/* 響應式設計 */
@media (max-width: 992px) {
    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 1rem;
    }
}

@media (max-width: 576px) {
    .product-grid {
        grid-template-columns: 1fr;
    }

    .container {
        padding: 1rem;
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
    <h1 class="page-title">👁️ 預覽商品列表</h1>

    <div class="admin-badge">
        🔧 管理員預覽模式 - 這是一般用戶看到的商品展示,但您可以直接編輯商品
    </div>

    <%
        List<Product> list = (List<Product>) request.getAttribute("productList");
        String ctx = request.getContextPath();

        if (list != null && !list.isEmpty()) {
    %>

    <div class="product-grid">
        <%
            for (Product p : list) {
                boolean isLowStock = p.getStock() < 10;
                boolean isOutOfStock = p.getStock() == 0;
        %>

        <div class="product-card">
            <a href="<%= ctx %>/ProductDetail?id=<%= p.getId() %>" class="product-card-link"></a>

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

                <!-- 管理員操作按鈕 -->
                <div class="product-actions">
                    <a href="<%= ctx %>/admin/products/edit?id=<%= p.getId() %>" class="btn-edit">
                        ✏️ 編輯
                    </a>
                    <a href="<%= ctx %>/admin/products/delete?id=<%= p.getId() %>"
                       class="btn-delete"
                       onclick="return confirm('確定要刪除「<%= p.getName() %>」嗎？');">
                        🗑️ 刪除
                    </a>
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
        <div class="empty-state-text">目前沒有商品</div>
        <a href="<%= ctx %>/admin/products/add" class="btn btn-primary">新增第一個商品</a>
    </div>

    <%
        }
    %>
</div>

</body>
</html>
