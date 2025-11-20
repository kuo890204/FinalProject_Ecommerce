package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	private static final String URL =
		    "jdbc:mysql://localhost:3306/ecommerce?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String USER = "root";
    private static final String PASSWORD = "abc123";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC Driver
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
