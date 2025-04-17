
-- seed.sql

USE mobileecommerce;

-- Brands
INSERT INTO Brand (brand_name, description) VALUES
('Apple', 'Made in California. Premium smartphones and electronics.'),
('Samsung', 'Leading Korean brand known for Galaxy phones.'),
('Xiaomi', 'Affordable smart devices with powerful features.'),
('OnePlus', 'Performance-focused smartphones with OxygenOS.');

-- Users
INSERT INTO USER (name, email, phone, address, password, role) VALUES
('Muskan Aryal', 'aryalmuskan17@gmail.com', '9856024240', 'Airport, Pokhara', 'Mra17@ecommerce', 'admin'),
('Suyog Subedi', 'suyogsubedi@gmail.com', '9812345678', 'New Road, Pokhara', 'pass123', 'customer'),
('Anish Sharma', 'anishsharma@gmail.com', '9841012345', 'Lakeside, Pokhara', 'pass456', 'customer'),
('Rita Thapa', 'rita.thapa@gmail.com', '9801122334', 'Bagar, Pokhara', 'pass789', 'customer');

-- Products
INSERT INTO Product (product_name, price, stock_quantity, description, image_url, brand_id) VALUES
('iPhone 15 Pro Max', 165000.00, 5, 'Natural Titanium, 256 GB', 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-15-pro-max-1.jpg', 1),
('Samsung Galaxy S23 Ultra', 154000.00, 8, 'Phantom Black, 256 GB', 'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s23-ultra-1.jpg', 2),
('Xiaomi 13 Pro', 90000.00, 10, 'Leica Camera, 256 GB', 'https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-13-pro-1.jpg', 3),
('OnePlus 11', 95000.00, 12, 'Green, 256 GB, 16GB RAM', 'https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-11-1.jpg', 4),
('iPhone 14', 125000.00, 7, 'Midnight Black, 128 GB', 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-14-1.jpg', 1);

-- Carts
INSERT INTO Cart (user_id) VALUES
(2), (3), (4);

-- Cart Items
INSERT INTO CartItem (cart_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(3, 4, 2);

-- Orders
INSERT INTO `Order` (user_id, order_date, total_amount, status) VALUES
(2, '2025-04-10', 255000.00, 'Delivered'),
(3, '2025-04-11', 154000.00, 'Pending'),
(4, '2025-04-12', 190000.00, 'Processing');

-- Order Items
INSERT INTO OrderItem (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 165000.00),
(1, 3, 1, 90000.00),
(2, 2, 1, 154000.00),
(3, 4, 2, 95000.00);
