<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    User loginUser = null;
    if (session != null) {
        loginUser = (User) session.getAttribute("loginUser");
    }
%>

<header style="padding: 10px; background-color: #f0f0f0; margin-bottom: 20px;">

    <a href="ProductList">首頁</a>

    <% if (loginUser != null) { %>
        | 歡迎，<%= loginUser.getName() %>！
        <!-- 🛒 查看購物車：登入後永遠顯示 -->
        | <a href="Cart">查看購物車</a>

        <!-- 🔑 管理者才顯示後台 -->
       

        <% if ("admin".equals(loginUser.getRole())) { %>
            | <a href="AdminProductList">管理後台</a>
        <% } %>
         | <a href="Logout">登出</a>

    <% } else { %>
        | <a href="Login">登入</a>
        | <a href="Register">註冊</a>
    <% } %>

</header>
