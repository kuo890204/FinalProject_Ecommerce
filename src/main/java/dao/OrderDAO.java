package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Order;
import model.OrderItem;
import model.Product;
import util.DatabaseUtil;

public class OrderDAO {

    // 建立訂單，回傳新建立的訂單 id
    public int createOrder(int userId, double totalAmount) {
        String sql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'CREATED')";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);   // 回傳自動編號的 id
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // 建立失敗
    }

    // 新增一筆訂單明細
    public void addOrderItem(int orderId, int productId, int quantity, double unitPrice) {

        String sql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, sub_total) " +
                     "VALUES (?, ?, ?, ?, ?)";

        double subTotal = unitPrice * quantity;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setDouble(4, unitPrice);
            ps.setDouble(5, subTotal);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 之後如果要查詢訂單可以用這兩個（暫時不一定用到，但先放著）

    public Order getOrderById(int orderId) {
    	String sql =
    	        "SELECT o.id, o.user_id, o.total_amount, o.status, o.created_at, " +
    	        "       u.name AS user_name, u.username " +
    	        "FROM orders o " +
    	        "JOIN users u ON o.user_id = u.id " +
    	        "WHERE o.id = ?";

    	    try (Connection conn = DatabaseUtil.getConnection();
    	         PreparedStatement ps = conn.prepareStatement(sql)) {

    	        ps.setInt(1, orderId);

    	        try (ResultSet rs = ps.executeQuery()) {
    	            if (rs.next()) {
    	                Order o = new Order();
    	                o.setId(rs.getInt("id"));
    	                o.setUserId(rs.getInt("user_id"));
    	                o.setTotalAmount(rs.getDouble("total_amount"));
    	                o.setStatus(rs.getString("status"));
    	                o.setCreatedAt(rs.getTimestamp("created_at"));

    	                String name = rs.getString("user_name");
    	                if (name == null || name.trim().isEmpty()) {
    	                    name = rs.getString("username");
    	                }
    	                o.setUserName(name);

    	                return o;
    	            }
    	        }

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }
    	    return null;
    	}

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();

        String sql = "SELECT id, product_id, quantity, unit_price, sub_total " +
                     "FROM order_items WHERE order_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(orderId);
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setSubTotal(rs.getDouble("sub_total"));
                    list.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // 🔹 1. 後台用：查全部訂單（帶會員名稱）
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();

        String sql =
            "SELECT o.id, o.user_id, o.total_amount, o.status, o.created_at, " +
            "       u.name AS user_name, u.username " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.id " +
            "ORDER BY o.created_at DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));

                // 如果 name 為空，就退而用 username
                String name = rs.getString("user_name");
                if (name == null || name.trim().isEmpty()) {
                    name = rs.getString("username");
                }
                o.setUserName(name);

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔹 2. 後台用：查某訂單的所有明細，附上商品資訊
    public List<OrderItem> getOrderItemsWithProduct(int orderId) {
        List<OrderItem> list = new ArrayList<>();

        String sql =
            "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.unit_price, oi.sub_total, " +
            "       p.name, p.price, p.stock, p.category, p.image " +
            "FROM order_items oi " +
            "JOIN products p ON oi.product_id = p.id " +
            "WHERE oi.order_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setSubTotal(rs.getDouble("sub_total"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setImage(rs.getString("image"));

                    item.setProduct(p);

                    list.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔹 3. 後台用：更新訂單狀態
    public void updateStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    
}
