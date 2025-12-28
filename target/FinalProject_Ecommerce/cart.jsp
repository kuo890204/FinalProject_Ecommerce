<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem, model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
.cart-table {
    width: 100%;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border-collapse: collapse;
    border: 1px solid #E8E3D8;
}
.cart-table th {
    background-color: #FAF8F3;
    color: #4A4A4A;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
}
.cart-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
    color: #4A4A4A;
}

.cart-table td a:hover {
    color: #B88A5F !important;
    text-decoration: underline !important;
}
.cart-table tr:hover {
    background-color: #FFFBF7;
}
.cart-table tr:last-child td {
    border-bottom: none;
}
.cart-total-row {
    background: #FAF8F3 !important;
    font-weight: 600;
    font-size: 1.125rem;
}
.quantity-control {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.quantity-btn {
    background: #D4A574;
    color: white;
    border: none;
    border-radius: 6px;
    width: 32px;
    height: 32px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.2s;
    font-size: 1.125rem;
}
.quantity-btn:hover {
    background: #B88A5F;
    transform: translateY(-1px);
}
.quantity-btn:disabled {
    background: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}
.quantity-input {
    width: 60px;
    text-align: center;
    padding: 0.5rem;
    border: 1px solid #E8E3D8;
    border-radius: 6px;
    color: #4A4A4A;
}
.quantity-input:focus {
    outline: none;
    border-color: #D4A574;
}
.action-buttons {
    margin-top: 1.5rem;
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}
/* 按鈕樣式 */
.btn {
    display: inline-block;
    padding: 0.625rem 1.25rem;
    border: none;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    text-align: center;
    transition: all 0.2s;
    text-decoration: none;
    letter-spacing: 0.5px;
}
.btn-primary {
    background-color: #D4A574;
    color: white;
}
.btn-primary:hover {
    background-color: #B88A5F;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.3);
}
.btn-success {
    background-color: #9CAF88;
    color: white;
}
.btn-success:hover {
    background-color: #87996F;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(156, 175, 136, 0.3);
}
.btn-success:disabled {
    background-color: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}
.btn-danger {
    background-color: #E8B4B8;
    color: white;
}
.btn-danger:hover {
    background-color: #D99DA1;
    text-decoration: none;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(232, 180, 184, 0.3);
}
.btn-danger:disabled {
    background-color: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}
.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
}

/* 批量操作工具列 */
.bulk-actions-bar {
    background: white;
    border-radius: 12px;
    padding: 1rem 1.5rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    display: flex;
    align-items: center;
    gap: 1rem;
    flex-wrap: wrap;
}

.bulk-actions-bar label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    font-weight: 500;
}

.bulk-actions-bar input[type="checkbox"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
}

.selected-info {
    color: #D4A574;
    font-weight: 600;
    margin-left: auto;
}

.cart-checkbox {
    width: 18px;
    height: 18px;
    cursor: pointer;
}
</style>

<script>
// 定義全局函數，避免 onchange 調用時找不到函數
function toggleSelectAll(event) {
    const headerCheckbox = document.getElementById('headerCheckbox');
    const selectAllCheckbox = document.getElementById('selectAll');
    const checkboxes = document.getElementsByName('cartItemIds');

    // 同步兩個全選框
    if (headerCheckbox && selectAllCheckbox) {
        // 判斷是哪個checkbox被點擊,然後同步另一個
        if (event && event.target) {
            if (event.target.id === 'selectAll') {
                headerCheckbox.checked = selectAllCheckbox.checked;
            } else if (event.target.id === 'headerCheckbox') {
                selectAllCheckbox.checked = headerCheckbox.checked;
            }
        }
    }

    const isChecked = selectAllCheckbox ? selectAllCheckbox.checked : headerCheckbox.checked;

    checkboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
    });

    updateBulkActions();
}

function updateBulkActions() {
    const checkboxes = document.getElementsByName('cartItemIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    const bulkActionsBar = document.getElementById('bulkActionsBar');
    const bulkCheckoutBtn = document.getElementById('bulkCheckoutBtn');
    const bulkRemoveBtn = document.getElementById('bulkRemoveBtn');
    const selectedCount = document.getElementById('selectedCount');
    const selectedInfo = document.getElementById('selectedInfo');
    const headerCheckbox = document.getElementById('headerCheckbox');
    const selectAllCheckbox = document.getElementById('selectAll');

    if (!bulkCheckoutBtn || !bulkRemoveBtn) return;

    // 計算選中商品的總金額
    let selectedTotal = 0;
    checkedBoxes.forEach(cb => {
        selectedTotal += parseFloat(cb.dataset.subtotal || 0);
    });

    // 更新計數
    if (selectedCount) selectedCount.textContent = count;

    // 更新批量操作欄狀態
    if (count > 0) {
        bulkCheckoutBtn.disabled = false;
        bulkRemoveBtn.disabled = false;
        if (selectedInfo) selectedInfo.textContent = '已選擇 ' + count + ' 項，小計：$' + Math.round(selectedTotal).toLocaleString();
    } else {
        bulkCheckoutBtn.disabled = true;
        bulkRemoveBtn.disabled = true;
        if (selectedInfo) selectedInfo.textContent = '請勾選商品';
    }

    // 更新底部按鈕文字和功能
    const removeBtnText = document.getElementById('removeBtnText');
    const checkoutBtnText = document.getElementById('checkoutBtnText');

    if (removeBtnText && checkoutBtnText) {
        if (count > 0) {
            removeBtnText.textContent = '移除選中商品 (' + count + ')';
            checkoutBtnText.textContent = '結帳選中商品 (' + count + ')';
        } else {
            removeBtnText.textContent = '清空購物車';
            checkoutBtnText.textContent = '全部結帳';
        }
    }

    // 更新全選框狀態
    if (headerCheckbox && selectAllCheckbox) {
        if (count === checkboxes.length && checkboxes.length > 0) {
            headerCheckbox.checked = true;
            selectAllCheckbox.checked = true;
            headerCheckbox.indeterminate = false;
        } else if (count > 0) {
            headerCheckbox.checked = false;
            selectAllCheckbox.checked = false;
            headerCheckbox.indeterminate = true;
        } else {
            headerCheckbox.checked = false;
            selectAllCheckbox.checked = false;
            headerCheckbox.indeterminate = false;
        }
    }
}

function checkoutSelected() {
    const checkboxes = document.getElementsByName('cartItemIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    if (count === 0) {
        alert('請至少選擇一項商品');
        return;
    }

    if (confirm('確定要結帳選中的 ' + count + ' 項商品嗎？')) {
        const form = document.getElementById('bulkCheckoutForm');
        checkedBoxes.forEach(cb => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'cartItemIds';
            input.value = cb.value;
            form.appendChild(input);
        });
        form.submit();
    }
}

function removeSelected() {
    const checkboxes = document.getElementsByName('cartItemIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    if (count === 0) {
        alert('請至少選擇一項商品');
        return;
    }

    if (confirm('確定要移除選中的 ' + count + ' 項商品嗎？')) {
        const form = document.getElementById('bulkRemoveForm');
        checkedBoxes.forEach(cb => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'cartItemIds';
            input.value = cb.value;
            form.appendChild(input);
        });
        form.submit();
    }
}

function handleRemove() {
    const checkboxes = document.getElementsByName('cartItemIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    if (count > 0) {
        removeSelected();
    } else {
        if (confirm('確定要清空購物車嗎？')) {
            document.getElementById('clearCartForm').submit();
        }
    }
}

function handleCheckout() {
    const checkboxes = document.getElementsByName('cartItemIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    if (count > 0) {
        checkoutSelected();
    } else {
        if (confirm('確定要送出訂單嗎？')) {
            document.getElementById('checkoutAllForm').submit();
        }
    }
}
</script>

</head>

<%
    String ctx = request.getContextPath();
%>

<body>

<jsp:include page="/header.jsp" />

<div id="app" class="container">
    <h1 class="page-title">🛒 購物車</h1>

    <%
        List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
        if (items == null || items.isEmpty()) {
    %>
        <div class="empty-state">
            <div class="empty-state-icon">🛒</div>
            <div class="empty-state-text">目前購物車是空的</div>
            <a href="<%= ctx %>/ProductList" class="btn btn-primary">前往商品列表</a>
        </div>
    <%
        } else {
            double total = 0;
    %>

    <!-- 批量操作工具列 -->
    <div class="bulk-actions-bar" id="bulkActionsBar">
        <label>
            <input type="checkbox" id="selectAll" onchange="toggleSelectAll(event)">
            全選/取消全選
        </label>
        <button type="button" class="btn btn-success btn-sm" onclick="checkoutSelected()" id="bulkCheckoutBtn" disabled>
            💳 結帳選中商品 (<span id="selectedCount">0</span>)
        </button>
        <button type="button" class="btn btn-danger btn-sm" onclick="removeSelected()" id="bulkRemoveBtn" disabled>
            🗑️ 移除選中商品
        </button>
        <span class="selected-info" id="selectedInfo">請勾選商品</span>
    </div>

    <table class="cart-table">
        <thead>
            <tr>
                <th style="width: 60px;">
                    <input type="checkbox" class="cart-checkbox" id="headerCheckbox" onchange="toggleSelectAll(event)">
                </th>
                <th>商品名稱</th>
                <th style="width: 120px;">單價</th>
                <th style="width: 180px;">數量</th>
                <th style="width: 120px;">小計</th>
                <th style="width: 100px;">操作</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (CartItem item : items) {
                Product p = item.getProduct();
                int qty = item.getQuantity();
                double subTotal = p.getPrice() * qty;
                total += subTotal;
        %>
            <tr>
                <td>
                    <input type="checkbox" class="cart-checkbox" name="cartItemIds" value="<%= item.getId() %>"
                           data-subtotal="<%= subTotal %>" onchange="updateBulkActions()">
                </td>
                <td>
                    <a href="<%= ctx %>/ProductDetail?id=<%= p.getId() %>" style="color: #D4A574; text-decoration: none; font-weight: 500; transition: color 0.2s;">
                        <%= p.getName() %>
                    </a>
                </td>
                <td>$<%= String.format("%,d", (int)p.getPrice()) %></td>
                <td>
                    <div class="quantity-control">
                        <form action="<%= ctx %>/UpdateCartItem" method="post" style="display:inline;">
                            <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                            <input type="hidden" name="quantity" value="<%= qty - 1 %>">
                            <button type="submit" class="quantity-btn" <%= (qty <= 1) ? "disabled" : "" %>>−</button>
                        </form>

                        <input
                            type="number"
                            class="quantity-input"
                            value="<%= qty %>"
                            min="1"
                            max="<%= p.getStock() %>"
                            readonly>

                        <form action="<%= ctx %>/UpdateCartItem" method="post" style="display:inline;">
                            <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                            <input type="hidden" name="quantity" value="<%= qty + 1 %>">
                            <button type="submit" class="quantity-btn" <%= (qty >= p.getStock()) ? "disabled" : "" %>>+</button>
                        </form>
                    </div>
                </td>
                <td>$<%= String.format("%,d", (int)subTotal) %></td>
                <td>
                    <a href="<%= ctx %>/DeleteCartItem?cartItemId=<%= item.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('確定要刪除這個商品嗎？');">
                        刪除
                    </a>
                </td>
            </tr>
        <%
            }
        %>
            <tr class="cart-total-row">
                <td colspan="4" style="text-align: right;">總金額：</td>
                <td colspan="2" style="color: #D4A574; font-size: 1.25rem;">
                    $<%= String.format("%,d", (int)total) %>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="action-buttons">
        <!-- 移除按鈕：根據是否有選取切換功能 -->
        <button type="button" class="btn btn-danger" id="removeBtn" onclick="handleRemove()">
            <span id="removeBtnText">清空購物車</span>
        </button>

        <!-- 結帳按鈕：根據是否有選取切換功能 -->
        <button type="button" class="btn btn-success" id="checkoutBtn" onclick="handleCheckout()">
            <span id="checkoutBtnText">全部結帳</span>
        </button>

        <a href="<%= ctx %>/ProductList" class="btn btn-primary">繼續購物</a>
    </div>

    <!-- 隱藏表單 -->
    <form id="clearCartForm" action="<%= ctx %>/ClearCart" method="post" style="display:none;"></form>
    <form id="checkoutAllForm" action="<%= ctx %>/Checkout" method="post" style="display:none;"></form>
    <form id="bulkCheckoutForm" action="<%= ctx %>/CheckoutSelected" method="post" style="display:none;"></form>
    <form id="bulkRemoveForm" action="<%= ctx %>/RemoveSelectedCartItems" method="post" style="display:none;"></form>

    <%
        }
    %>
</div>

</body>
</html>
