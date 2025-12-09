<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員登入</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h2>會員登入</h2>

<!-- 顯示錯誤訊息（如果有的話） -->
<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>

<form action="Login" method="post">
    <p>
        帳號：<input type="text" name="username" />
    </p>
    <p>
        密碼：<input type="password" name="password" />
    </p>
    <p>
        <input type="submit" value="登入">
    </p>
    <p><a href="Register">還沒有帳號？點這裡註冊</a></p>
    	
</form>

<!-- 之後可以放「註冊」連結 -->
<p><a href="ProductList">先去逛逛商品（未登入）</a></p>

</body>
</html>
