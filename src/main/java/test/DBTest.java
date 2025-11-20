package test;

import java.sql.Connection;
import util.DatabaseUtil;

public class DBTest {
    public static void main(String[] args) {
        try {
            Connection conn = DatabaseUtil.getConnection();
            System.out.println("成功連線到 MySQL!");
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
