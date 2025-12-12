<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
  String ctx = request.getContextPath();
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品後台管理</title>
</head>
<body>

<jsp:include page="/header.jsp" />

<h2>商品後台管理</h2>

<p>
    <a href="ProductAdd">＋ 新增商品</a>
    |
    <a href="<%= ctx %>/admin/orders">訂單管理</a>
</p>


<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>名稱</th>
        <th>價格</th>
        <th>庫存</th>
        <th>分類</th>
        <th>操作</th>
    </tr>

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null) {
            for (Product p : products) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getName() %></td>
        <td><%= p.getPrice() %></td>
        <td><%= p.getStock() %></td>
        <td><%= p.getCategory() %></td>	

        <td>
            <a href="ProductEdit?id=<%= p.getId() %>">編輯</a> |
            <a href="ProductDelete?id=<%= p.getId() %>"
               onclick="return confirm('確定要刪除嗎？');">
               刪除
            </a>
        </td>
    </tr>
    <%
            }
        }
    %>

</table>

</body>
</html>
