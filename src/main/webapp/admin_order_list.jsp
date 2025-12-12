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
<title>訂單管理 - 後台</title>
</head>
<body>

<jsp:include page="header.jsp" />

<h2>訂單管理</h2>

<%
    List<Order> orderList = (List<Order>) request.getAttribute("orderList");
    if (orderList == null || orderList.isEmpty()) {
%>
    <p>目前沒有任何訂單。</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>訂單編號</th>
            <th>會員</th>
            <th>總金額</th>
            <th>狀態</th>
            <th>建立時間</th>
            <th>操作</th>
        </tr>

    <%
        for (Order o : orderList) {
    %>
        <tr>
            <td><%= o.getId() %></td>
            <td><%= o.getUserName() %> (ID: <%= o.getUserId() %>)</td>
            <td>$<%= o.getTotalAmount() %></td>
            <td><%= o.getStatus() %></td>
            <td><%= o.getCreatedAt() %></td>
            <td>
                <a href="<%= ctx %>/admin/orders/detail?id=<%= o.getId() %>">
    查看明細
</a>
            </td>
        </tr>
    <%
        }
    %>
    </table>
<%
    }
%>

<a href="<%= ctx %>/AdminProductList">回商品管理</a>


</body>
</html>
