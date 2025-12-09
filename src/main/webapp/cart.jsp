<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem, model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
</head>
<body>

<jsp:include page="header.jsp" />

<h2>購物車</h2>

<%
    List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
    if (items == null || items.isEmpty()) {
%>
    <p>目前購物車是空的。</p>
    <p><a href="ProductList">回商品列表</a></p>
<%
    } else {

        double total = 0;
%>

    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>商品名稱</th>
            <th>單價</th>
            <th>數量</th>
            <th>小計</th>
            <th>操作</th>
        </tr>

    <%
        for (CartItem item : items) {
            Product p = item.getProduct();
            int qty = item.getQuantity();
            double subTotal = p.getPrice() * qty;
            total += subTotal;
    %>
        <tr>
            <td><%= p.getName() %></td>
            <td>$<%= p.getPrice() %></td>
            <td>
                <!-- 🔹 修改數量：送到 UpdateCartQuantity -->
                <form action="UpdateCartQuantity" method="post" style="display:inline;">
                    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                    <input type="number" name="quantity" value="<%= qty %>" min="1" style="width:60px;">
                    <button type="submit">更新</button>
                </form>
            </td>
            <td>$<%= subTotal %></td>
            <td>
                <!-- 刪除單一商品 -->
                <a href="DeleteCartItem?cartItemId=<%= item.getId() %>"
                   onclick="return confirm('確定要刪除這個商品嗎？');">
                    刪除
                </a>
            </td>
        </tr>
    <%
        } // end for
    %>

        <tr>
            <td colspan="3" align="right">總金額：</td>
            <td colspan="2">$<%= total %></td>
        </tr>
    </table>

    <p>
        <!-- 🔹 清空購物車：用 POST 呼叫 ClearCart（只包按鈕） -->
        <form action="ClearCart" method="post" style="display:inline;">
            <button type="submit" onclick="return confirm('確定要清空購物車嗎？');">
                清空購物車
            </button>
        </form>
        <!-- 🔹 新增：前往結帳 -->
        <form action="Checkout" method="post" style="display:inline; margin-left:10px;">
            <button type="submit">
                前往結帳
            </button>
        </form>
    </p>
    </p>

    <p><a href="ProductList">繼續購物</a></p>

<%
    } // end else
%>

</body>
</html>
