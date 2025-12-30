<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
  String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品後台管理 - 電商平台</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans TC', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background-color: #FAF8F3;
    color: #4A4A4A;
    line-height: 1.6;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.page-title {
    color: #4A4A4A;
    font-size: 2rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.admin-actions {
    display: flex;
    gap: 1rem;
}

.btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none;
    text-align: center;
    font-family: inherit;
    letter-spacing: 0.5px;
}

.btn-success {
    background-color: #9CAF88;
    color: white;
}

.btn-success:hover {
    background-color: #87996F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(156, 175, 136, 0.3);
}

.btn-secondary {
    background-color: #FAF8F3;
    color: #4A4A4A;
    border: 1px solid #E8E3D8;
}

.btn-secondary:hover {
    background-color: #F5F2ED;
    border-color: #D4A574;
    transform: translateY(-1px);
}

.btn-primary {
    background-color: #D4A574;
    color: white;
}

.btn-primary:hover {
    background-color: #B88A5F;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(212, 165, 116, 0.3);
}

.btn-danger {
    background-color: #E8B4B8;
    color: white;
}

.btn-danger:hover {
    background-color: #D99DA1;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(232, 180, 184, 0.3);
}

.btn-sm {
    padding: 0.5rem 0.75rem !important;
    font-size: 0.875rem;
}

.btn-danger:disabled {
    background-color: #E8E3D8;
    cursor: not-allowed;
    transform: none;
}

/* 批量操作工具列 */
.bulk-actions-bar {
    background: white;
    border-radius: 12px;
    padding: 1rem 1.5rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border: 1px solid #E8E3D8;
    display: none;
    align-items: center;
    gap: 1rem;
}

.bulk-actions-bar.active {
    display: flex;
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

.selected-count {
    color: #D4A574;
    font-weight: 600;
    margin-left: auto;
}

.product-checkbox {
    width: 18px;
    height: 18px;
    cursor: pointer;
}

.admin-table {
    width: 100%;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
    border-collapse: collapse;
    border: 1px solid #E8E3D8;
    table-layout: fixed;
}

.admin-table th {
    background-color: #FAF8F3;
    color: #4A4A4A;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    border-bottom: 2px solid #E8E3D8;
}

.admin-table td {
    padding: 1rem;
    border-bottom: 1px solid #F5F2ED;
    color: #4A4A4A;
}

.admin-table tr:hover {
    background-color: #FFFBF7;
}

.admin-table tr:last-child td {
    border-bottom: none;
}

.table-actions {
    display: flex;
    gap: 0.5rem;
    align-items: center;
    justify-content: center;
}

.table-actions .btn {
    padding: 0.5rem 0.75rem !important;
    font-size: 0.875rem;
    white-space: nowrap;
}

.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(212, 165, 116, 0.08);
}

.empty-state-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
}

.empty-state-text {
    font-size: 1.125rem;
    color: #8B8B8B;
    margin-bottom: 1.5rem;
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
    }

    .admin-actions {
        width: 100%;
        flex-direction: column;
    }

    .btn {
        width: 100%;
    }

    .admin-table {
        font-size: 0.875rem;
    }

    .admin-table th,
    .admin-table td {
        padding: 0.75rem 0.5rem;
    }

    .table-actions {
        flex-direction: column;
    }
}
</style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">📦 商品後台管理</h1>
        <div class="admin-actions">
            <a href="<%= ctx %>/admin/products/add" class="btn btn-success">➕ 新增商品</a>
            <a href="<%= ctx %>/admin/orders" class="btn btn-secondary">📋 訂單管理</a>
        </div>
    </div>

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null && !products.isEmpty()) {
    %>

    <!-- 批量操作工具列 -->
    <div class="bulk-actions-bar" id="bulkActionsBar">
        <label>
            <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
            全選/取消全選
        </label>
        <button type="button" class="btn btn-danger btn-sm" onclick="deleteSelected()" id="bulkDeleteBtn" disabled>
            🗑️ 批量刪除 (<span id="selectedCount">0</span>)
        </button>
        <span class="selected-count" id="selectedInfo">請勾選要刪除的商品</span>
    </div>

    <form id="bulkDeleteForm" action="<%= ctx %>/admin/products/bulkDelete" method="post">
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 60px;">
                        <input type="checkbox" class="product-checkbox" id="headerCheckbox" onchange="toggleSelectAll()">
                    </th>
                    <th style="width: 80px;">ID</th>
                <th>名稱</th>
                <th style="width: 120px;">價格</th>
                <th style="width: 100px;">庫存</th>
                <th style="width: 100px;">分類</th>
                <th style="width: 180px;">操作</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (Product p : products) {
        %>
            <tr>
                <td>
                    <input type="checkbox" class="product-checkbox" name="productIds" value="<%= p.getId() %>" onchange="updateBulkActions()">
                </td>
                <td><%= p.getId() %></td>
                <td><%= p.getName() %></td>
                <td>$<%= String.format("%,d", (int)p.getPrice()) %></td>
                <td><%= p.getStock() %></td>
                <td><%= p.getCategory() %></td>
                <td>
                    <div class="table-actions">
                        <a href="<%= ctx %>/admin/products/edit?id=<%= p.getId() %>" class="btn btn-primary btn-sm">✏️ 編輯</a>
                        <a href="<%= ctx %>/admin/products/delete?id=<%= p.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('確定要刪除「<%= p.getName() %>」嗎？');">🗑️ 刪除</a>
                    </div>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    </form>

    <%
        } else {
    %>

    <div class="empty-state">
        <div class="empty-state-icon">📦</div>
        <div class="empty-state-text">目前沒有商品資料</div>
        <a href="<%= ctx %>/admin/products/add" class="btn btn-success">新增第一個商品</a>
    </div>

    <%
        }
    %>
</div>

<script>
function toggleSelectAll() {
    const headerCheckbox = document.getElementById('headerCheckbox');
    const selectAllCheckbox = document.getElementById('selectAll');
    const checkboxes = document.getElementsByName('productIds');

    // 同步兩個全選框
    if (headerCheckbox) {
        selectAllCheckbox.checked = headerCheckbox.checked;
    }

    const isChecked = selectAllCheckbox.checked;

    checkboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
    });

    updateBulkActions();
}

function updateBulkActions() {
    const checkboxes = document.getElementsByName('productIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    const bulkActionsBar = document.getElementById('bulkActionsBar');
    const bulkDeleteBtn = document.getElementById('bulkDeleteBtn');
    const selectedCount = document.getElementById('selectedCount');
    const selectedInfo = document.getElementById('selectedInfo');
    const headerCheckbox = document.getElementById('headerCheckbox');
    const selectAllCheckbox = document.getElementById('selectAll');

    // 更新計數
    selectedCount.textContent = count;

    // 顯示/隱藏批量操作欄
    if (count > 0) {
        bulkActionsBar.classList.add('active');
        bulkDeleteBtn.disabled = false;
        selectedInfo.textContent = '已選擇 ' + count + ' 項商品';
    } else {
        bulkActionsBar.classList.remove('active');
        bulkDeleteBtn.disabled = true;
        selectedInfo.textContent = '請勾選要刪除的商品';
    }

    // 更新全選框狀態
    if (count === checkboxes.length) {
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

function deleteSelected() {
    const checkboxes = document.getElementsByName('productIds');
    const checkedBoxes = Array.from(checkboxes).filter(cb => cb.checked);
    const count = checkedBoxes.length;

    if (count === 0) {
        alert('請至少選擇一項商品');
        return;
    }

    if (confirm('確定要刪除選中的 ' + count + ' 項商品嗎？此操作無法復原！')) {
        document.getElementById('bulkDeleteForm').submit();
    }
}
</script>

</body>
</html>
