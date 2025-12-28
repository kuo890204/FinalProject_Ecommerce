<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>

<%
    String ctx = request.getContextPath();
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單詳情 - 電商平台</title>
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
    max-width: 1000px;
    margin: 0 auto;
    padding: 2rem;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
}

.btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
    text-align: center;
    font-family: inherit;
    letter-spacing: 0.5px;
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

.btn-danger {
    background-color: rgba(232, 180, 184, 0.3);
    color: #B8686E;
    border: 1px solid #E8B4B8;
}

.btn-danger:hover {
    background-color: rgba(232, 180, 184, 0.5);
    transform: translateY(-1px);
}

.order-card {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    margin-bottom: 1.5rem;
}

.section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #4A4A4A;
    margin-bottom: 1.5rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid #E8E3D8;
}

.order-info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    margin-bottom: 1.5rem;
}

.info-item {
    display: flex;
    flex-direction: column;
    padding: 1rem;
    background: #FAF8F3;
    border-radius: 8px;
}

.info-label {
    font-weight: 500;
    color: #8B8B8B;
    font-size: 0.875rem;
    margin-bottom: 0.5rem;
}

.info-value {
    font-weight: 600;
    color: #4A4A4A;
    font-size: 1.125rem;
}

.status-badge {
    display: inline-block;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.95rem;
    font-weight: 500;
}

.status-created {
    background-color: rgba(212, 165, 116, 0.15);
    color: #B88A5F;
}

.status-paid {
    background-color: rgba(156, 175, 136, 0.15);
    color: #6B7A5C;
}

.status-shipped {
    background-color: rgba(135, 206, 235, 0.15);
    color: #4682B4;
}

.status-done {
    background-color: rgba(156, 175, 136, 0.25);
    color: #4A6F3F;
    font-weight: 600;
}

.status-cancel {
    background-color: rgba(232, 180, 184, 0.15);
    color: #B8686E;
}

.items-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 1.5rem;
}

.items-table thead {
    background-color: #FAF8F3;
}

.items-table th {
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
    color: #4A4A4A;
}

.items-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
}

.items-table td a {
    color: #D4A574;
    text-decoration: none;
    font-weight: 600;
    transition: color 0.2s;
}

.items-table td a:hover {
    color: #B88A5F;
    text-decoration: underline;
}

.items-table tbody tr:hover {
    background-color: #FFFBF7;
}

.total-row {
    background-color: #FAF8F3;
    font-weight: 600;
}

.total-amount {
    color: #D4A574;
    font-size: 1.5rem;
}

.action-buttons {
    display: flex;
    gap: 1rem;
    margin-top: 1.5rem;
}

.status-description {
    background-color: rgba(212, 165, 116, 0.08);
    border-left: 4px solid #D4A574;
    padding: 1rem 1.5rem;
    border-radius: 6px;
    margin-bottom: 1.5rem;
}

.status-description p {
    margin: 0;
    color: #6B6B6B;
    line-height: 1.8;
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
    }

    .order-info-grid {
        grid-template-columns: 1fr;
    }

    .items-table {
        font-size: 0.875rem;
    }

    .items-table th,
    .items-table td {
        padding: 0.75rem 0.5rem;
    }

    .action-buttons {
        flex-direction: column;
    }

    .btn {
        width: 100%;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">📦 訂單詳情</h1>
        <a href="<%= ctx %>/user/orders" class="btn btn-secondary">← 返回訂單列表</a>
    </div>

    <% if (order != null) {
        String statusClass = "status-created";
        String statusText = "待付款";
        if ("PAID".equals(order.getStatus())) {
            statusClass = "status-paid";
            statusText = "已付款";
        } else if ("SHIPPED".equals(order.getStatus())) {
            statusClass = "status-shipped";
            statusText = "已出貨";
        } else if ("DONE".equals(order.getStatus())) {
            statusClass = "status-done";
            statusText = "已完成";
        } else if ("CANCEL".equals(order.getStatus())) {
            statusClass = "status-cancel";
            statusText = "已取消";
        }
    %>

        <!-- 訂單資訊 -->
        <div class="order-card">
            <h2 class="section-title">訂單資訊</h2>

            <div class="order-info-grid">
                <div class="info-item">
                    <span class="info-label">訂單編號</span>
                    <span class="info-value">#<%= order.getId() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">訂單狀態</span>
                    <span class="info-value">
                        <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">訂單總額</span>
                    <span class="info-value" style="color: #D4A574;">
                        $<%= String.format("%,d", (int)order.getTotalAmount()) %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">訂單時間</span>
                    <span class="info-value"><%= order.getCreatedAt() %></span>
                </div>
            </div>

            <!-- 訂單狀態說明 -->
            <div class="status-description">
                <p>
                    <% if ("CREATED".equals(order.getStatus())) { %>
                        ⏳ 訂單已建立，請盡快完成付款
                    <% } else if ("PAID".equals(order.getStatus())) { %>
                        ✅ 已收到您的付款，我們正在準備出貨
                    <% } else if ("SHIPPED".equals(order.getStatus())) { %>
                        🚚 訂單已出貨，商品配送中
                    <% } else if ("DONE".equals(order.getStatus())) { %>
                        🎉 訂單已完成，感謝您的購買
                    <% } else if ("CANCEL".equals(order.getStatus())) { %>
                        ❌ 此訂單已取消
                    <% } %>
                </p>
            </div>
        </div>

        <!-- 商品明細 -->
        <div class="order-card">
            <h2 class="section-title">商品明細</h2>

            <table class="items-table">
                <thead>
                    <tr>
                        <th>商品名稱</th>
                        <th style="width: 100px; text-align: center;">數量</th>
                        <th style="width: 120px; text-align: right;">單價</th>
                        <th style="width: 120px; text-align: right;">小計</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (orderItems != null && !orderItems.isEmpty()) {
                            for (OrderItem item : orderItems) {
                    %>
                        <tr>
                            <td>
                                <a href="<%= ctx %>/ProductDetail?id=<%= item.getProduct().getId() %>">
                                    <%= item.getProduct().getName() %>
                                </a>
                                <br>
                                <small style="color: #8B8B8B;">分類：<%= item.getProduct().getCategory() %></small>
                            </td>
                            <td style="text-align: center;"><%= item.getQuantity() %></td>
                            <td style="text-align: right;">$<%= String.format("%,d", (int)item.getUnitPrice()) %></td>
                            <td style="text-align: right; font-weight: 600;">
                                $<%= String.format("%,d", (int)item.getSubTotal()) %>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right; padding: 1.5rem 1rem;">訂單總額</td>
                        <td style="text-align: right; padding: 1.5rem 1rem;">
                            <span class="total-amount">$<%= String.format("%,d", (int)order.getTotalAmount()) %></span>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- 操作按鈕 -->
            <div class="action-buttons">
                <a href="<%= ctx %>/ProductList" class="btn btn-secondary">繼續購物</a>
                <% if ("CREATED".equals(order.getStatus())) { %>
                    <form action="<%= ctx %>/user/order/cancel" method="post" style="flex: 1;"
                          onsubmit="return confirm('確定要取消此訂單嗎？');">
                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                        <button type="submit" class="btn btn-danger" style="width: 100%;">取消訂單</button>
                    </form>
                <% } %>
            </div>
        </div>

    <% } else { %>
        <div class="order-card" style="text-align: center; padding: 3rem;">
            <p style="color: #8B8B8B; font-size: 1.125rem;">訂單不存在</p>
            <a href="<%= ctx %>/user/orders" class="btn btn-secondary" style="margin-top: 1.5rem;">返回訂單列表</a>
        </div>
    <% } %>
</div>

</body>
</html>
