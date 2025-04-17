
-- init.sql

CREATE DATABASE IF NOT EXISTS mobileecommerce;
USE mobileecommerce;

CREATE TABLE Brand (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  brand_name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

CREATE TABLE USER (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20),
  address TEXT,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'customer') NOT NULL
);

CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL,
  description TEXT,
  image_url VARCHAR(255),
  brand_id INT NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES Brand(brand_id) ON DELETE CASCADE
);

CREATE TABLE Cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE
);

CREATE TABLE CartItem (
  cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
  cart_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT DEFAULT 1,
  FOREIGN KEY (cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE `Order` (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  order_date DATE DEFAULT CURDATE(),
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(50) DEFAULT 'Pending',
  FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE
);

CREATE TABLE OrderItem (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT DEFAULT 1,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);
