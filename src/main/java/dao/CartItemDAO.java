package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.CartItem;
import model.Product;
import util.DatabaseUtil;

public class CartItemDAO {

    // 1️⃣ 加入購物車（如果已經有同商品，就 quantity += addQty）
    public void addOrUpdateItem(int userId, int productId, int addQty) {
    	//查詢購物車是否已存在該商品
        String selectSql = "SELECT id, quantity FROM cart_items " +
                           "WHERE user_id = ? AND product_id = ?";
        //新增一筆購物車資料
        String insertSql = "INSERT INTO cart_items (user_id, product_id, quantity) " +
                           "VALUES (?, ?, ?)";
        //更新已有的購物車數量
        String updateSql = "UPDATE cart_items SET quantity = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection()) {

            // 先看看有沒有這筆
            try (PreparedStatement ps = conn.prepareStatement(selectSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // 已存在 → update quantity
                        int cartItemId = rs.getInt("id");
                        int oldQty = rs.getInt("quantity");
                        int newQty = oldQty + addQty;  // 庫存檢查之後放在 Servlet 做

                        try (PreparedStatement ups = conn.prepareStatement(updateSql)) {
                            ups.setInt(1, newQty);
                            ups.setInt(2, cartItemId);
                            ups.executeUpdate();
                        }

                    } else {
                        // 不存在 → insert 一筆新資料
                        try (PreparedStatement ins = conn.prepareStatement(insertSql)) {
                            ins.setInt(1, userId);
                            ins.setInt(2, productId);
                            ins.setInt(3, addQty);
                            ins.executeUpdate();
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2️⃣ 取得某會員的購物車清單（JOIN products，一次把商品資料也查出來）
    public List<CartItem> getCartItemsByUser(int userId) {

        List<CartItem> list = new ArrayList<>();

        String sql = "SELECT c.id AS cart_id, c.user_id, c.product_id, c.quantity, " +
                     "       p.id AS p_id, p.name, p.price, p.stock, p.category, p.image " +
                     "FROM cart_items c " +
                     "JOIN products p ON c.product_id = p.id " +
                     "WHERE c.user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    CartItem item = new CartItem();
                    item.setId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    Product p = new Product();
                    p.setId(rs.getInt("p_id"));
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

    // 3️⃣ 修改購物車某一筆的數量
    public void updateQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 4️⃣ 刪除單一購物車項目
    public void deleteItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5️⃣ 清空某使用者的購物車
    public void clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 // 取得單一購物車項目（用 id 查，包含商品資訊）
    public CartItem getCartItemById(int cartItemId) {
        String sql = "SELECT c.id AS cart_id, c.user_id, c.product_id, c.quantity, " +
                     "       p.id AS p_id, p.name, p.price, p.stock, p.category, p.image " +
                     "FROM cart_items c " +
                     "JOIN products p ON c.product_id = p.id " +
                     "WHERE c.id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    Product p = new Product();
                    p.setId(rs.getInt("p_id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setImage(rs.getString("image"));

                    item.setProduct(p);
                    return item;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }




}
