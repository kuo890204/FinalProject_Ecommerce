<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增商品</title>
</head>
<body>

<jsp:include page="/header.jsp" />

<h2>新增商品</h2>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>
<%
  String ctx = request.getContextPath();
%>

<form action="<%= ctx %>/admin/products/add" method="post">

    <p>
        名稱：
        <input type="text" name="name"
               value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>">
    </p>

    <p>
        價格：
        <input type="text" name="price"
               value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>">
    </p>

    <p>
        庫存：
        <input type="text" name="stock"
               value="<%= request.getAttribute("stock") != null ? request.getAttribute("stock") : "" %>">
    </p>

    <p>
        分類：
        <input type="text" name="category"
               value="<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>">
    </p>

    <p>
        圖片路徑：
        <input type="text" name="image"
               value="<%= request.getAttribute("image") != null ? request.getAttribute("image") : "" %>">
    </p>

    <p>
         <button type="submit">新增商品</button>
        <a href="<%= ctx %>/admin/products">返回列表</a>
    </p>
</form>

</body>
</html>
