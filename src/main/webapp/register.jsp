<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員註冊</title>
</head>
<body>

<h2>會員註冊</h2>

<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>

<form action="Register" method="post">
    <p>帳號：<input type="text" name="username"></p>
    <p>密碼：<input type="password" name="password"></p>
    <p>姓名：<input type="text" name="name"></p>
    <p>地址：<input type="text" name="address"></p>
    <p>Email：<input type="email" name="email"></p>
    <p><input type="submit" value="註冊"></p>
</form>

<p><a href="Login">已經有帳號？去登入</a></p>

</body>
</html>
