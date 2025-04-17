package com.mystore.model;

import java.sql.Timestamp;

public class Products {
    private int productId;      // product_id in the database
    private String name;        // product_name in the database
    private String description;
    private double price;
    private int stock;          // stock_quantity in the database
    private int brandId;        // brand_id in the database
    private String imageUrl;
    private Timestamp createdAt;

    // Default constructor
    public Products() {
    }

    // Constructor for adding a product (without product ID and createdAt)
    public Products(String name, String description, double price, int stock, int brandId, String imageUrl) {
        this.name = name;         // corresponds to product_name
        this.description = description;
        this.price = price;
        this.stock = stock;       // corresponds to stock_quantity
        this.brandId = brandId;
        this.imageUrl = imageUrl;
    }

    // Constructor with product ID and creation date (used when fetching from DB)
    public Products(int productId, String name, String description, double price, int stock, int brandId, String imageUrl, Timestamp createdAt) {
        this.productId = productId;  // corresponds to product_id
        this.name = name;            // corresponds to product_name
        this.description = description;
        this.price = price;
        this.stock = stock;          // corresponds to stock_quantity
        this.brandId = brandId;      // corresponds to brand_id
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;   // product_name
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;  // stock_quantity
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;  // brand_id
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
