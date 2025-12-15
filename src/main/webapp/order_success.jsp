<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem, model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單成立</title>
</head>
<body>

<jsp:include page="/header.jsp" />

<h2>訂單成立</h2>

<%
    Integer orderId = (Integer) request.getAttribute("orderId");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
%>

<% if (orderId != null) { %>
    <p>您的訂單編號：<strong><%= orderId %></strong></p>
    <p>訂單總金額：<strong>$<%= totalAmount %></strong></p>

    <h3>購買明細</h3>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>商品名稱</th>
            <th>單價</th>
            <th>數量</th>
            <th>小計</th>
        </tr>

    <%
        if (items != null) {
            for (CartItem item : items) {
                Product p = item.getProduct();
                int qty = item.getQuantity();
                double subTotal = p.getPrice() * qty;
    %>
        <tr>
            <td><%= p.getName() %></td>
            <td>$<%= p.getPrice() %></td>
            <td><%= qty %></td>
            <td>$<%= subTotal %></td>
        </tr>
    <%
            }
        }
    %>

        <tr>
            <td colspan="3" align="right">總金額：</td>
            <td>$<%= totalAmount %></td>
        </tr>
    </table>

    <p><a href="ProductList">回商品列表</a></p>

<% } else { %>
    <p>找不到訂單資訊。</p>
    <p><a href="ProductList">回首頁</a></p>
<% } %>

</body>
</html>
