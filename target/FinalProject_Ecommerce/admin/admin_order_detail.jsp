<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order, model.OrderItem, model.Product" %>

<%
  String ctx = request.getContextPath();
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

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 2rem;
    padding-bottom: 0.75rem;
    border-bottom: 3px solid #D4A574;
    display: inline-block;
}

.order-card {
    background: white;
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    margin-bottom: 1.5rem;
}

.order-info {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
    margin-bottom: 2rem;
}

.info-item {
    display: flex;
    padding: 0.75rem;
    background: #FAF8F3;
    border-radius: 8px;
}

.info-label {
    font-weight: 500;
    color: #8B8B8B;
    min-width: 100px;
}

.info-value {
    font-weight: 600;
    color: #4A4A4A;
}

.status-form {
    padding: 1.25rem;
    background: #FFFBF7;
    border-radius: 8px;
    border-left: 4px solid #D4A574;
    margin-bottom: 2rem;
}

.status-form label {
    display: block;
    margin-bottom: 0.75rem;
    font-weight: 500;
    color: #4A4A4A;
}

.status-select {
    padding: 0.75rem 1rem;
    border: 1px solid #E8E3D8;
    border-radius: 8px;
    font-size: 1rem;
    font-family: inherit;
    margin-right: 1rem;
    transition: all 0.2s;
}

.status-select:focus {
    outline: none;
    border-color: #D4A574;
    box-shadow: 0 0 0 3px rgba(212, 165, 116, 0.1);
}

.section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #4A4A4A;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #E8E3D8;
}

.order-table {
    width: 100%;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border-collapse: collapse;
    border: 1px solid #E8E3D8;
}

.order-table th {
    background-color: #FAF8F3;
    color: #4A4A4A;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
}

.order-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
    color: #4A4A4A;
}

.order-table tr:last-child td {
    border-bottom: none;
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

.btn-primary {
    background-color: #D4A574;
    color: white;
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
    transform: translateY(-1px);
}

.actions {
    margin-top: 2rem;
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

@media (max-width: 768px) {
    .order-info {
        grid-template-columns: 1fr;
    }

    .order-table {
        font-size: 0.875rem;
    }

    .order-table th,
    .order-table td {
        padding: 0.75rem 0.5rem;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<div class="container">
    <% if (order == null) { %>
        <div class="empty-state">
            <div class="empty-state-icon">❌</div>
            <div class="empty-state-text">找不到這筆訂單</div>
            <a href="<%= ctx %>/admin/orders" class="btn btn-primary">回訂單列表</a>
        </div>
    <% } else { %>

        <h1 class="page-title">📋 訂單詳情 #<%= order.getId() %></h1>

        <div class="order-card">
            <h2 class="section-title">訂單資訊</h2>
            <div class="order-info">
                <div class="info-item">
                    <span class="info-label">訂單編號：</span>
                    <span class="info-value">#<%= order.getId() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">會員：</span>
                    <span class="info-value"><%= order.getUserName() %> (ID: <%= order.getUserId() %>)</span>
                </div>
                <div class="info-item">
                    <span class="info-label">總金額：</span>
                    <span class="info-value" style="color: #D4A574; font-size: 1.25rem;">$<%= String.format("%,d", (int)order.getTotalAmount()) %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">狀態：</span>
                    <span class="info-value">
                        <%
                            String currentStatusText = "待付款";
                            if ("PAID".equals(order.getStatus())) currentStatusText = "已付款";
                            else if ("SHIPPED".equals(order.getStatus())) currentStatusText = "已出貨";
                            else if ("DONE".equals(order.getStatus())) currentStatusText = "已完成";
                            else if ("CANCEL".equals(order.getStatus())) currentStatusText = "已取消";
                        %>
                        <%= currentStatusText %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">建立時間：</span>
                    <span class="info-value"><%= order.getCreatedAt() %></span>
                </div>
            </div>

            <form action="<%= ctx %>/admin/orders/status" method="post" class="status-form">
                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                <label>
                    🔄 變更訂單狀態：
                    <select name="status" class="status-select">
                        <option value="CREATED" <%= "CREATED".equals(order.getStatus()) ? "selected" : "" %>>待付款</option>
                        <option value="PAID"    <%= "PAID".equals(order.getStatus())    ? "selected" : "" %>>已付款</option>
                        <option value="SHIPPED" <%= "SHIPPED".equals(order.getStatus()) ? "selected" : "" %>>已出貨</option>
                        <option value="DONE"    <%= "DONE".equals(order.getStatus())    ? "selected" : "" %>>已完成</option>
                        <option value="CANCEL"  <%= "CANCEL".equals(order.getStatus())  ? "selected" : "" %>>已取消</option>
                    </select>
                    <button type="submit" class="btn btn-primary">儲存變更</button>
                </label>
            </form>

            <h2 class="section-title">📦 商品列表</h2>

            <%
                if (items == null || items.isEmpty()) {
            %>
                <p style="color: #8B8B8B; padding: 1rem;">這筆訂單目前沒有明細。</p>
            <%
                } else {
            %>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>商品名稱</th>
                            <th style="width: 120px;">單價</th>
                            <th style="width: 80px;">數量</th>
                            <th style="width: 120px;">小計</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (OrderItem item : items) {
                            Product p = item.getProduct();
                    %>
                        <tr>
                            <td><%= p.getName() %></td>
                            <td>$<%= String.format("%,d", (int)item.getUnitPrice()) %></td>
                            <td><%= item.getQuantity() %></td>
                            <td>$<%= String.format("%,d", (int)item.getSubTotal()) %></td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            <%
                }
            %>
        </div>

        <div class="actions">
            <a href="<%= ctx %>/admin/orders" class="btn btn-secondary">返回訂單列表</a>
        </div>

    <% } %>
</div>

</body>
</html>
