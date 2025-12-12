package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DatabaseUtil;
import util.PasswordUtil;

public class UserDAO {

    /**
     * 登入處理（BCrypt 版）
     *
     * @param username 使用者輸入的帳號
     * @param password 使用者輸入的「平文密碼」
     * @return 登入成功回傳 User，失敗回傳 null
     */
    public User login(String username, String password) {
        User user = null;

        // ❗這裡只用 username 查，password 不在 SQL 比對
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                	// 從 DB 拿出 HASH 過的密碼
                    String storedHash = rs.getString("password");

                    // 用 BCrypt 比對平文密碼 vs hash
                    boolean ok = PasswordUtil.checkPassword(password, storedHash);
                    if (!ok) {
                        // 密碼不符 → 直接回傳 null
                        return null;
                    }

                 // 密碼正確，把 user 組起來
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    // 密碼通常不用放回 Session，必要的話可以放 hash
                    user.setPassword(storedHash);
                    user.setName(rs.getString("name"));
                    user.setAddress(rs.getString("address"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // 檢查 username 是否存在（這個不用動）
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
            // 保守策略：發生錯誤就當作「存在」，避免重複註冊
            return true;
        }
    }

    /**
     * 註冊處理（INSERT + BCrypt 雜湊）
     */
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, name, address, email, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // 把純文字密碼 → BCrypt 雜湊
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword); // 存 hash 不是平文！ 
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
