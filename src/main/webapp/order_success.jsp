<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem, model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單成立成功 - 電商平台</title>
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
    max-width: 900px;
    margin: 0 auto;
    padding: 2rem;
}

.success-header {
    text-align: center;
    margin-bottom: 2rem;
}

.success-icon {
    font-size: 5rem;
    margin-bottom: 1rem;
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
    margin-bottom: 0.5rem;
}

.success-subtitle {
    color: #8B8B8B;
    font-size: 1rem;
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
    gap: 1.5rem;
    margin-bottom: 1.5rem;
}

.info-item {
    padding: 1.25rem;
    background: #FAF8F3;
    border-radius: 8px;
    border-left: 4px solid #D4A574;
}

.info-label {
    color: #8B8B8B;
    font-size: 0.875rem;
    font-weight: 500;
    margin-bottom: 0.5rem;
}

.info-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: #4A4A4A;
}

.order-total {
    color: #D4A574;
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

.total-row {
    background: #FAF8F3 !important;
    font-weight: 600;
    font-size: 1.125rem;
}

.total-row td {
    border-top: 2px solid #E8E3D8 !important;
}

.btn {
    display: inline-block;
    padding: 0.875rem 2rem;
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

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

.actions {
    text-align: center;
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

@media (max-width: 576px) {
    .container {
        padding: 1rem;
    }

    .success-title {
        font-size: 1.5rem;
    }

    .success-icon {
        font-size: 3.5rem;
    }

    .info-value {
        font-size: 1.25rem;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <%
        Integer orderId = (Integer) request.getAttribute("orderId");
        Double totalAmount = (Double) request.getAttribute("totalAmount");
        List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
    %>

    <% if (orderId != null) { %>
        <div class="success-header">
            <div class="success-icon">✅</div>
            <h1 class="success-title">訂單成立成功！</h1>
            <p class="success-subtitle">感謝您的訂購，我們將盡快為您處理</p>
        </div>

        <div class="order-card">
            <div class="order-info">
                <div class="info-item">
                    <div class="info-label">📝 訂單編號</div>
                    <div class="info-value">#<%= orderId %></div>
                </div>
                <div class="info-item">
                    <div class="info-label">💰 訂單總金額</div>
                    <div class="info-value order-total">$<%= String.format("%,d", totalAmount.intValue()) %></div>
                </div>
            </div>

            <h2 class="section-title">📦 購買明細</h2>

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
                    if (items != null) {
                        for (CartItem item : items) {
                            Product p = item.getProduct();
                            int qty = item.getQuantity();
                            double subTotal = p.getPrice() * qty;
                %>
                    <tr>
                        <td><%= p.getName() %></td>
                        <td>$<%= String.format("%,d", (int)p.getPrice()) %></td>
                        <td><%= qty %></td>
                        <td>$<%= String.format("%,d", (int)subTotal) %></td>
                    </tr>
                <%
                        }
                    }
                %>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">總金額：</td>
                        <td style="color: #D4A574; font-size: 1.25rem;">$<%= String.format("%,d", totalAmount.intValue()) %></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="actions">
            <a href="ProductList" class="btn btn-primary">繼續購物</a>
        </div>

    <% } else { %>

        <div class="empty-state">
            <div class="empty-state-icon">❌</div>
            <div class="empty-state-text">找不到訂單資訊</div>
            <a href="ProductList" class="btn btn-primary">回首頁</a>
        </div>

    <% } %>
</div>

</body>
</html>
