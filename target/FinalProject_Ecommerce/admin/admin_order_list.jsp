<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%
  String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單管理 - 電商平台</title>
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
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0.5rem;
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

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
}

.admin-table {
    width: 100%;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border-collapse: collapse;
    border: 1px solid #E8E3D8;
}

.admin-table th {
    background-color: #FAF8F3;
    color: #4A4A4A;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
}

.admin-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
    color: #4A4A4A;
}

.admin-table tr:hover {
    background-color: #FFFBF7;
}

.admin-table tr:last-child td {
    border-bottom: none;
}

.status-badge {
    display: inline-block;
    padding: 0.375rem 0.875rem;
    border-radius: 20px;
    font-size: 0.875rem;
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
    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
    }

    .admin-table {
        font-size: 0.875rem;
    }

    .admin-table th,
    .admin-table td {
        padding: 0.75rem 0.5rem;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">📋 訂單管理</h1>
        <a href="<%= ctx %>/admin/products" class="btn btn-secondary">📦 商品管理</a>
    </div>

    <%
        List<Order> orderList = (List<Order>) request.getAttribute("orderList");
        if (orderList == null || orderList.isEmpty()) {
    %>
        <div class="empty-state">
            <div class="empty-state-icon">📋</div>
            <div class="empty-state-text">目前沒有任何訂單</div>
        </div>
    <%
        } else {
    %>
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 100px;">訂單編號</th>
                    <th>會員</th>
                    <th style="width: 120px;">總金額</th>
                    <th style="width: 130px;">狀態</th>
                    <th style="width: 160px;">建立時間</th>
                    <th style="width: 120px;">操作</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Order o : orderList) {
                    String statusClass = "status-created";
                    String statusText = "待付款";
                    if ("PAID".equals(o.getStatus())) {
                        statusClass = "status-paid";
                        statusText = "已付款";
                    } else if ("SHIPPED".equals(o.getStatus())) {
                        statusClass = "status-shipped";
                        statusText = "已出貨";
                    } else if ("DONE".equals(o.getStatus())) {
                        statusClass = "status-done";
                        statusText = "已完成";
                    } else if ("CANCEL".equals(o.getStatus())) {
                        statusClass = "status-cancel";
                        statusText = "已取消";
                    }
            %>
                <tr>
                    <td>#<%= o.getId() %></td>
                    <td><%= o.getUserName() %> <span style="color: #8B8B8B;">(ID: <%= o.getUserId() %>)</span></td>
                    <td>$<%= String.format("%,d", (int)o.getTotalAmount()) %></td>
                    <td><span class="status-badge <%= statusClass %>"><%= statusText %></span></td>
                    <td><%= o.getCreatedAt() %></td>
                    <td>
                        <a href="<%= ctx %>/admin/orders/detail?id=<%= o.getId() %>" class="btn btn-primary btn-sm">
                            🔍 查看
                        </a>
                    </td>
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

</body>
</html>
