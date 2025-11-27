package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DatabaseUtil;

public class UserDAO {

    /**
     * 登入用：用帳號 + 密碼去資料庫查
     * 找到 → 回傳 User 物件
     * 找不到 → 回傳 null
     */
    public User login(String username, String password) {
        User user = null;

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // 把 ? 換成真實帳號、密碼
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setName(rs.getString("name"));
                    user.setAddress(rs.getString("address"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;  // 沒查到 → null
    }
    
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, name, address, email, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getName());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getRole());   // 一般註冊就給 "user"

            int rows = ps.executeUpdate();     // 受影響的列數（新增幾筆）

            return rows > 0;                   // 成功新增至少一筆 = true

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
