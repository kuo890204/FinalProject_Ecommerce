<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!--
    這兩行是 import：
    - 讓 JSP 能使用 List<Product>
    - 讓 JSP 知道 Product 這個類別是什麼（欄位有哪些）
-->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品列表</title>
</head>
<body>
<jsp:include page="/header.jsp" />
<%@ page import="model.User" %>

<%
    // 從 Session 拿出登入者資料（LoginServlet 已經 setAttribute("loginUser", user)）
    User loginUser = (User) session.getAttribute("loginUser");
%>

<div style="padding: 10px; border-bottom: 1px solid #ccc; margin-bottom: 15px;">
    <%
        if (loginUser != null) {
    %>
        歡迎，<strong><%= loginUser.getName() != null ? loginUser.getName() : loginUser.getUsername() %></strong>！　
       	<a href="Cart">查看購物車</a> |
        <a href="Logout">登出</a>
    <%
        } else {
    %>
        您目前是訪客身分。<a href="Login">登入</a>
    <%
        }
    %>
</div>

<h2>商品列表</h2>

<%
    // 1️⃣ 從 request 中取出由 Servlet 傳來的商品清單
    //    "productList" 是 Servlet setAttribute 時設定的 key
    List<Product> list = (List<Product>) request.getAttribute("productList");

    // 2️⃣ 檢查資料是否有成功傳過來（避免 NullPointer）
    if (list != null && !list.isEmpty()) {

        // 3️⃣ 用 for-each 迴圈，把每一個商品 p 顯示出來
        for (Product p : list) {
%>

            <!-- HTML 區塊，顯示一筆商品資料 -->
            <p>
                ID：<%= p.getId() %> |
                商品名稱：
				<a href="ProductDetail?id=<%= p.getId() %>">
				    <%= p.getName() %>
				</a> |
                價格：<%= p.getPrice() %> 元 |
                庫存：<%= p.getStock() %> |
                分類：<%= p.getCategory() %>
                <!-- 🔥 新增加入購物車按鈕 -->
				<form action="AddToCart" method="post">
    <input type="hidden" name="productId" value="<%= p.getId() %>">
    <button type="submit">加入購物車</button>
</form>

				
            </p>

<%
        }
    } else {
%>

        <!-- 如果沒有資料，顯示提示 -->
        <p>目前沒有任何商品資料。</p>

<%
    }
%>

</body>
</html>
