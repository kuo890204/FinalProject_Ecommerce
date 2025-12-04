package model;

public class User {

    private int id;             // 使用者ID
    private String username;    // 帳號
    private String password;    // 密碼
    private String name;        // 姓名
    private String address;     // 地址
    private String email;       // 信箱
    private String role;        // 角色：user / admin

    // ---- Getter / Setter ----
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
