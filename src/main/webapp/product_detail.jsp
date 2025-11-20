<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>

<%
    // 從 request 中拿 Servlet 傳來的商品資料
    Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品詳細資料</title>
</head>
<body>

<h2>商品詳細資料</h2>

<% if (p != null) { %>
    <p>ID：<%= p.getId() %></p>
    <p>商品名稱：<%= p.getName() %></p>
    <p>價格：<%= p.getPrice() %> 元</p>
    <p>庫存：<%= p.getStock() %></p>
    <p>分類：<%= p.getCategory() %></p>

    <!-- 之後可以用 <img> 顯示圖片，現在先文字就好 -->
    <p>圖片檔名：<%= p.getImage() %></p>

    <hr>

    <!-- 之後要做加入購物車按鈕就在這裡加 -->
    <p>
        <a href="ProductList">回商品列表</a>
    </p>

<% } else { %>
    <p>沒有取得商品資料。</p>
    <p><a href="ProductList">回商品列表</a></p>
<% } %>

</body>
</html>
