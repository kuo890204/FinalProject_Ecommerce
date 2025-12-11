<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    User loginUser = null;
    if (session != null) {
        loginUser = (User) session.getAttribute("loginUser");
    }

    String ctx = request.getContextPath();  // ← 專案根路徑，例如 /FinalProject_Ecommerce
%>

<header style="padding: 10px; background-color: #f0f0f0; margin-bottom: 20px;">

    <a href="<%= ctx %>/ProductList">首頁</a>
    | <a href="<%= ctx %>/Cart">查看購物車</a>

    <% if (loginUser != null) { %>
        | 嗨，<%= loginUser.getName() %>！
        | <a href="<%= ctx %>/Logout">登出</a>

        <% if ("admin".equals(loginUser.getRole())) { %>
            | <a href="<%= ctx %>/AdminProductList">管理後台</a>
        <% } %>

    <% } else { %>
        | <a href="<%= ctx %>/Login">登入</a>
        | <a href="<%= ctx %>/Register">註冊</a>
    <% } %>

</header>
