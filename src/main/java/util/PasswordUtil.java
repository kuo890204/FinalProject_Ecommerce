package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // 工作因子（越大越安全但越慢，10~12 間都 OK）
    private static final int WORKLOAD = 12;

    // 將明碼轉成雜湊
    public static String hashPassword(String plainTextPassword) {
        String salt = BCrypt.gensalt(WORKLOAD);
        return BCrypt.hashpw(plainTextPassword, salt);
    }

    // 驗證登入密碼
    public static boolean checkPassword(String plainTextPassword, String storedHash) {
        if (storedHash == null || storedHash.isEmpty()) {
            return false;
        }
        return BCrypt.checkpw(plainTextPassword, storedHash);
    }
    
    public static void main(String[] args) {
        System.out.println(PasswordUtil.hashPassword("1234"));
    }

}
