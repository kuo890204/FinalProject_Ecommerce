package dao;  
// 此類別放在 dao 套件 → DAO = Data Access Object，負責資料庫操作

import java.sql.*;                // 匯入所有 JDBC 相關類別 (Connection, PreparedStatement, ResultSet)
import java.util.ArrayList;
import java.util.List;

import model.Product;             // 匯入 Product Model，用來裝每一筆商品資料
import util.DatabaseUtil;         // 匯入你剛寫的 DatabaseUtil，用來取得DB連線

public class ProductDAO {         // 定義 ProductDAO 類別，專門處理「產品資料表」的DB操作

    public List<Product> getAllProducts() {  
    	//集合的一種 方法：取得所有商品的清單，回傳 List<Product> 

        List<Product> list = new ArrayList<>();  
        // 建立一個空的 List，用來存查詢結果轉成的 Product 物件

        String sql = "SELECT * FROM products";  
        // SQL 指令：查詢 products 資料表所有資料

        try (Connection conn = DatabaseUtil.getConnection();  
        							// 取得資料庫連線（使用 try-with-resources 自動關閉連線）

             PreparedStatement ps = conn.prepareStatement(sql);  
        							//SQL 執行通道（不關掉 = 記憶體浪費）
             ResultSet rs = ps.executeQuery()) {  
             						// 執行查詢，結果放進 ResultSet
        							//ResultSet 是「資料庫的結果」，不是「商品物件」。

            while (rs.next()) {             // 逐行讀取查詢結果
                Product p = new Product();  // 建立 Product 物件來裝一筆資料

                // 以下從 ResultSet 取出每一欄資料 → 填入 Product 物件
                p.setId(rs.getInt("id"));               
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setCategory(rs.getString("category"));
                p.setImage(rs.getString("image"));

                list.add(p);                // 將這筆商品加入清單
            }

        } catch (Exception e) {             // 捕捉錯誤（資料庫連線或 SQL 問題）
            e.printStackTrace();           // 印出錯誤訊息（方便 debug）
        }

        return list;                       // 回傳裝滿所有商品的 List
    }
    
    
    public Product getProductById(int id) {
        Product p = null;

        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);              // 把 ? 換成傳進來的 id

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {           // 如果有找到資料
                    p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setImage(rs.getString("image"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p; // 找不到就回傳 null
    }
    
 // 新增商品（INSERT）
    public boolean addProduct(Product product) {

        String sql = "INSERT INTO products (name, price, stock, category, image) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getCategory());
            ps.setString(5, product.getImage());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

 // 修改商品（UPDATE）
    public boolean updateProduct(Product product) {

        String sql = "UPDATE products "
                   + "SET name = ?, price = ?, stock = ?, category = ?, image = ? "
                   + "WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setInt(3, product.getStock());
            ps.setString(4, product.getCategory());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
 // 刪除商品（DELETE）
    public boolean deleteProduct(int id) {

        String sql = "DELETE FROM products WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
 
    // 結帳用：扣庫存（stock = stock - quantity）
    public void decreaseStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 搜尋商品（根據名稱或分類）
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE name LIKE ? OR category LIKE ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setImage(rs.getString("image"));
                    list.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 根據分類取得商品
    public List<Product> getProductsByCategory(String category) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE category = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock(rs.getInt("stock"));
                    p.setCategory(rs.getString("category"));
                    p.setImage(rs.getString("image"));
                    list.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 取得所有分類清單
    public List<String> getAllCategories() {
        List<String> list = new ArrayList<>();

        String sql = "SELECT DISTINCT category FROM products ORDER BY category";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getString("category"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


}
