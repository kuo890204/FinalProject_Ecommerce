<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem, model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
.cart-table {
    width: 100%;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border-collapse: collapse;
    border: 1px solid #E8E3D8;
}
.cart-table th {
    background-color: #FAF8F3;
    color: #4A4A4A;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
}
.cart-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
    color: #4A4A4A;
}
.cart-table tr:hover {
    background-color: #FFFBF7;
}
.cart-table tr:last-child td {
    border-bottom: none;
}
.cart-total-row {
    background: #FAF8F3 !important;
    font-weight: 600;
    font-size: 1.125rem;
}
.quantity-control {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.quantity-btn {
    background: #D4A574;
    color: white;
    border: none;
    border-radius: 6px;
    width: 32px;
    height: 32px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.2s;
    font-size: 1.125rem;
}
.quantity-btn:hover {
    background: #B88A5F;
    transform: translateY(-1px);
}
.quantity-btn:disabled {
    background: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}
.quantity-input {
    width: 60px;
    text-align: center;
    padding: 0.5rem;
    border: 1px solid #E8E3D8;
    border-radius: 6px;
    color: #4A4A4A;
}
.quantity-input:focus {
    outline: none;
    border-color: #D4A574;
}
.action-buttons {
    margin-top: 1.5rem;
    display: flex;
    gap: 1rem;
}
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}
/* 按鈕樣式 */
.btn {
    display: inline-block;
    padding: 0.625rem 1.25rem;
    border: none;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    text-align: center;
    transition: all 0.2s;
    text-decoration: none;
    letter-spacing: 0.5px;
}
.btn-primary {
    background-color: #D4A574;
    color: white;
}
.btn-primary:hover {
    background-color: #B88A5F;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.3);
}
.btn-success {
    background-color: #9CAF88;
    color: white;
}
.btn-success:hover {
    background-color: #87996F;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(156, 175, 136, 0.3);
}
.btn-danger {
    background-color: #E8B4B8;
    color: white;
}
.btn-danger:hover {
    background-color: #D99DA1;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(232, 180, 184, 0.3);
}
.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
}
</style>
</head>

<%
    String ctx = request.getContextPath();
%>

<body>

<jsp:include page="/header.jsp" />

<div id="app" class="container">
    <h1 class="page-title">🛒 購物車</h1>

    <%
        List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
        if (items == null || items.isEmpty()) {
    %>
        <div class="empty-state">
            <div class="empty-state-icon">🛒</div>
            <div class="empty-state-text">目前購物車是空的</div>
            <a href="<%= ctx %>/ProductList" class="btn btn-primary">前往商品列表</a>
        </div>
    <%
        } else {
            double total = 0;
    %>

    <table class="cart-table">
        <thead>
            <tr>
                <th>商品名稱</th>
                <th style="width: 120px;">單價</th>
                <th style="width: 180px;">數量</th>
                <th style="width: 120px;">小計</th>
                <th style="width: 100px;">操作</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (CartItem item : items) {
                Product p = item.getProduct();
                int qty = item.getQuantity();
                double subTotal = p.getPrice() * qty;
                total += subTotal;
        %>
            <tr>
                <td><%= p.getName() %></td>
                <td>$<%= String.format("%,d", (int)p.getPrice()) %></td>
                <td>
                    <div class="quantity-control">
                        <form action="<%= ctx %>/UpdateCartItem" method="post" style="display:inline;">
                            <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                            <input type="hidden" name="quantity" value="<%= qty - 1 %>">
                            <button type="submit" class="quantity-btn" <%= (qty <= 1) ? "disabled" : "" %>>−</button>
                        </form>

                        <input
                            type="number"
                            class="quantity-input"
                            value="<%= qty %>"
                            min="1"
                            max="<%= p.getStock() %>"
                            readonly>

                        <form action="<%= ctx %>/UpdateCartItem" method="post" style="display:inline;">
                            <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                            <input type="hidden" name="quantity" value="<%= qty + 1 %>">
                            <button type="submit" class="quantity-btn" <%= (qty >= p.getStock()) ? "disabled" : "" %>>+</button>
                        </form>
                    </div>
                </td>
                <td>$<%= String.format("%,d", (int)subTotal) %></td>
                <td>
                    <a href="<%= ctx %>/DeleteCartItem?cartItemId=<%= item.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('確定要刪除這個商品嗎？');">
                        刪除
                    </a>
                </td>
            </tr>
        <%
            }
        %>
            <tr class="cart-total-row">
                <td colspan="3" style="text-align: right;">總金額：</td>
                <td colspan="2" style="color: #D4A574; font-size: 1.25rem;">
                    $<%= String.format("%,d", (int)total) %>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="action-buttons">
        <form action="<%= ctx %>/ClearCart" method="post" style="display:inline;">
            <button type="submit" class="btn btn-danger" onclick="return confirm('確定要清空購物車嗎？');">
                清空購物車
            </button>
        </form>
        <form action="<%= ctx %>/Checkout" method="post" style="display:inline;" onsubmit="return confirm('確定要送出訂單嗎？');">
            <button type="submit" class="btn btn-success">
                前往結帳
            </button>
        </form>
        <a href="<%= ctx %>/ProductList" class="btn btn-primary">繼續購物</a>
    </div>

    <%
        }
    %>
</div>

</body>
</html>