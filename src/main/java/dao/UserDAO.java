package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DatabaseUtil;

public class UserDAO {

    // 登入（SELECT）
    public User login(String username, String password) {
        User user = null;

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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

        return user;  // 查不到就回傳 null
    }

 // 檢查 username 是否存在
    public boolean isUsernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ? LIMIT 1";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();  // 查到 → 帳號存在
            }

        } catch (Exception e) {
            e.printStackTrace();
            return true; // 保守策略：出現 Exception 就當作存在（避免註冊重複帳號）
        }
    }

    // 註冊（INSERT）
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
            ps.setString(6, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
