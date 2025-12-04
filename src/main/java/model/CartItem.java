package model;

public class CartItem {

    private int id;         // 購物車項目編號（cart_items.id）
    private int userId;     // 所屬會員（users.id）
    private int productId;  // 商品編號（products.id）
    private int quantity;   // 購買數量

    // 為了在畫面上好用，可以直接塞進一個 Product 物件
    private Product product;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }
    public void setProduct(Product product) {
        this.product = product;
    }
}
