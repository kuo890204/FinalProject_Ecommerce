<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員註冊</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h2>會員註冊</h2>

<%
    // 接收 RegisterServlet 帶過來的錯誤或成功訊息
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>

<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>

<% if (message != null) { %>
    <p style="color:green;"><%= message %></p>
<% } %>

<form action="Register" method="post">

    <p>帳號：<input type="text" name="username" 
          value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"></p>

    <p>密碼：<input type="password" name="password"></p>

    <p>姓名：<input type="text" name="name"
          value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"></p>

    <p>地址：<input type="text" name="address"
          value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>"></p>

    <p>Email：<input type="email" name="email"
          value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"></p>

    <p><input type="submit" value="註冊"></p>
</form>

<p><a href="Login">已經有帳號？去登入</a></p>

</body>
</html>
