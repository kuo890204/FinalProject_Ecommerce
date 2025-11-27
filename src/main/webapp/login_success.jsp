<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登入成功</title>
<style>
    body { font-family: Arial; padding: 20px; }
    .box {
        border: 1px solid #ccc;
        padding: 20px;
        width: 350px;
        border-radius: 8px;
    }
</style>
</head>
<body>

<div class="box">
    <h2>登入成功</h2>

    <p>歡迎，<strong><%= session.getAttribute("username") %></strong>！</p>

    <p><a href="ProductList">前往商品列表</a></p>
</div>

</body>
</html>
