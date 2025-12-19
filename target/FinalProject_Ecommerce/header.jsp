<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    String ctx = request.getContextPath();
    User loginUser = (User) session.getAttribute("loginUser");
%>

<header style="padding: 10px; background-color: #f0f0f0; margin-bottom: 20px;">

    <a href="<%= ctx %>/ProductList">首頁</a>
    | <a href="<%= ctx %>/Cart">查看購物車</a>

    <% if (loginUser != null) { %>
        | 嗨，<%= (loginUser.getName() != null && !loginUser.getName().isEmpty())
                 ? loginUser.getName()
                 : loginUser.getUsername() %>！
        | <a href="<%= ctx %>/Logout">登出</a>

        <% if ("admin".equals(loginUser.getRole())) { %>
            | <a href="<%= ctx %>/admin/products">管理後台</a>
            | <a href="<%= ctx %>/admin/orders">訂單管理</a>
        <% } %>

    <% } else { %>
        | <a href="<%= ctx %>/Login">登入</a>
        | <a href="<%= ctx %>/Register">註冊</a>
    <% } %>

</header>
