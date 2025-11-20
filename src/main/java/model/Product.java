package model;  
// 這個類別放在 model 套件，代表 MVC 裡的 Model（資料層）

public class Product {  
// 宣告一個 Product 類別，用來表示「商品」的資料模型

    private int id;              // 商品編號（通常對應資料庫的主鍵）
    private String name;         // 商品名稱
    private double price;        // 商品價格（用 double 儲存金額）
    private int stock;           // 商品庫存量
    private String category;     // 商品分類
    private String image;        // 商品圖片檔名或圖片 URL
    
    public Product() {}  
    // 空建構子（JavaBean 標準，讓框架/JSP/JDBC 能自動建立物件）
    
    @Override
    public String toString() {  
    // toString：印出物件的所有資料（方便除錯用）
        return "Product [id=" + id + ", name=" + name + ", price=" + price +
               ", stock=" + stock + ", category=" + category + ", image=" + image + "]";
               // 回傳商品資訊的字串格式
    }

    // ========= Getter / Setter 區塊 =========
    // 每個欄位都有對應的 getter/setter（封裝 Encapsulation）

    public int getId() {         // 取得商品 id
        return id;
    }
    public void setId(int id) {  // 設定商品 id
        this.id = id;
    }

    public String getName() {    // 取得商品名稱
        return name;
    }
    public void setName(String name) {  // 設定商品名稱
        this.name = name;
    }

    public double getPrice() {   // 取得商品價格
        return price;
    }
    public void setPrice(double price) {  // 設定商品價格
        this.price = price;
    }

    public int getStock() {      // 取得商品庫存
        return stock;
    }
    public void setStock(int stock) {     // 設定商品庫存
        this.stock = stock;
    }

    public String getCategory() {         // 取得商品分類
        return category;
    }
    public void setCategory(String category) {  // 設定商品分類
        this.category = category;
    }

    public String getImage() {           // 取得商品圖片路徑/名稱
        return image;
    }
    public void setImage(String image) { // 設定商品圖片
        this.image = image;
    }

}
