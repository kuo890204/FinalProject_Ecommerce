<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯商品</title>
</head>
<body>

<jsp:include page="/header.jsp" />

<h2>編輯商品</h2>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }

    // 優先順序：
    // 1. 如果是 POST 驗證錯誤回來 → 使用 request 的欄位值
    // 2. 否則使用 GET 進來時給的 product 物件
    Product product = (Product) request.getAttribute("product");

    // 取得欄位的顯示值
    Object idAttr      = request.getAttribute("id");
    Object nameAttr    = request.getAttribute("name");
    Object priceAttr   = request.getAttribute("price");
    Object stockAttr   = request.getAttribute("stock");
    Object categoryAttr= request.getAttribute("category");
    Object imageAttr   = request.getAttribute("image");

    int idVal = 0;
    String nameVal, priceVal, stockVal, categoryVal, imageVal;

    if (product != null) {
        idVal       = product.getId();
        nameVal     = product.getName();
        priceVal    = String.valueOf(product.getPrice());
        stockVal    = String.valueOf(product.getStock());
        categoryVal = product.getCategory();
        imageVal    = product.getImage();
    } else {
        idVal       = idAttr != null ? (Integer) idAttr : 0;
        nameVal     = nameAttr != null ? nameAttr.toString() : "";
        priceVal    = priceAttr != null ? priceAttr.toString() : "";
        stockVal    = stockAttr != null ? stockAttr.toString() : "";
        categoryVal = categoryAttr != null ? categoryAttr.toString() : "";
        imageVal    = imageAttr != null ? imageAttr.toString() : "";
    }
%>

<form action="ProductEdit" method="post">

    <!-- id 用 hidden 帶回去 -->
    <input type="hidden" name="id" value="<%= idVal %>">

    <p>
        名稱：
        <input type="text" name="name" value="<%= nameVal %>">
    </p>

    <p>
        價格：
        <input type="text" name="price" value="<%= priceVal %>">
    </p>

    <p>
        庫存：
        <input type="text" name="stock" value="<%= stockVal %>">
    </p>

    <p>
        分類：
        <input type="text" name="category" value="<%= categoryVal != null ? categoryVal : "" %>">
    </p>

    <p>
        圖片路徑：
        <input type="text" name="image" value="<%= imageVal != null ? imageVal : "" %>">
    </p>

    <p>
        <input type="submit" value="儲存修改">
        <a href="AdminProductList">回列表</a>
    </p>
</form>

</body>
</html>
