package com.mystore.model;

public class CartItem {
    private int cartItemId;
    private String productName;
    private double price;
    private int quantity;

    // Getters and Setters
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotal() {
        return price * quantity;
    }
    private int productId; 

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

}
