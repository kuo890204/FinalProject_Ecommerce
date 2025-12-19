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
<title>訂單明細 - 後台</title>
</head>
<body>

<jsp:include page="/header.jsp" />

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
%>

<% if (order == null) { %>
    <p>找不到這筆訂單。</p>
    <p>
        <a href="<%= ctx %>/admin/orders">回訂單列表</a>
    </p>
<% } else { %>


<h2>訂單明細：<%= order.getId() %></h2>

<p>會員：<%= order.getUserName() %> (ID: <%= order.getUserId() %>)</p>
<p>總金額：$<%= order.getTotalAmount() %></p>
<p>狀態：<strong><%= order.getStatus() %></strong></p>
<p>建立時間：<%= order.getCreatedAt() %></p>

<!-- 狀態修改 -->
<form action="<%= ctx %>/admin/orders/status" method="post" style="margin:10px 0;">
    <input type="hidden" name="orderId" value="<%= order.getId() %>">
    <label>變更訂單狀態：
        <select name="status">
            <option value="CREATED" <%= "CREATED".equals(order.getStatus()) ? "selected" : "" %>>CREATED</option>
            <option value="PAID"    <%= "PAID".equals(order.getStatus())    ? "selected" : "" %>>PAID</option>
            <option value="SHIPPED" <%= "SHIPPED".equals(order.getStatus()) ? "selected" : "" %>>SHIPPED</option>
            <option value="DONE"    <%= "DONE".equals(order.getStatus())    ? "selected" : "" %>>DONE</option>
            <option value="CANCEL"  <%= "CANCEL".equals(order.getStatus())  ? "selected" : "" %>>CANCEL</option>
        </select>
    </label>
    <button type="submit">儲存</button>
</form>

<h3>商品列表</h3>

<%
    if (items == null || items.isEmpty()) {
%>
    <p>這筆訂單目前沒有明細。</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>商品名稱</th>
            <th>單價</th>
            <th>數量</th>
            <th>小計</th>
        </tr>

    <%
        for (OrderItem item : items) {
            Product p = item.getProduct();
    %>
        <tr>
            <td><%= p.getName() %></td>
            <td>$<%= item.getUnitPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td>$<%= item.getSubTotal() %></td>
        </tr>
    <%
        }
    %>
    </table>
<%
    }
%>

<p style="margin-top:15px;">
	<a href="<%= ctx %>/admin/orders">回訂單列表</a>

</p>

<% } %>

</body>
</html>
