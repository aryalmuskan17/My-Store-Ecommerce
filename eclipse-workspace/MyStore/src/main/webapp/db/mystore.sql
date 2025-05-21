-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 21, 2025 at 08:06 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mystore`
--

-- --------------------------------------------------------

--
-- Table structure for table `Brand`
--

CREATE TABLE `Brand` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Brand`
--

INSERT INTO `Brand` (`brand_id`, `brand_name`, `description`) VALUES
(1, 'Apple', 'Made in California \r\nPremium Brand'),
(2, 'Samsung', 'Leading smartphone brand known for Galaxy series'),
(3, 'OnePlus', 'Innovative smartphone brand known for performance and OxygenOS'),
(4, 'Xiaomi', 'Popular smartphone brand known for value-for-money devices and MIUI');

-- --------------------------------------------------------

--
-- Table structure for table `Cart`
--

CREATE TABLE `Cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Cart`
--

INSERT INTO `Cart` (`cart_id`, `user_id`) VALUES
(11, 1),
(10, 8);

-- --------------------------------------------------------

--
-- Table structure for table `CartItem`
--

CREATE TABLE `CartItem` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CartItem`
--

INSERT INTO `CartItem` (`cart_item_id`, `cart_id`, `product_id`, `quantity`) VALUES
(44, 10, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Order`
--

CREATE TABLE `Order` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` date DEFAULT curdate(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Order`
--

INSERT INTO `Order` (`order_id`, `user_id`, `order_date`, `total_amount`, `status`) VALUES
(11, 8, '2025-05-03', 350000.00, 'Approved'),
(12, 8, '2025-05-03', 180000.00, 'Pending'),
(13, 8, '2025-05-03', 165000.00, 'Rejected'),
(14, 8, '2025-05-04', 330000.00, 'Pending'),
(15, 8, '2025-05-04', 45000.00, 'Pending'),
(16, 8, '2025-05-04', 120000.00, 'Pending'),
(17, 8, '2025-05-05', 350000.00, 'Pending'),
(18, 8, '2025-05-08', 535000.00, 'Pending'),
(19, 8, '2025-05-08', 175000.00, 'Pending'),
(20, 8, '2025-05-08', 990000.00, 'Pending'),
(21, 8, '2025-05-17', 200000.00, 'Pending'),
(22, 8, '2025-05-17', 259999.00, 'Pending'),
(23, 8, '2025-05-17', 495000.00, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `OrderItem`
--

CREATE TABLE `OrderItem` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OrderItem`
--

INSERT INTO `OrderItem` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(11, 11, 3, 2, 175000.00),
(12, 12, 8, 1, 180000.00),
(13, 13, 1, 1, 165000.00),
(14, 14, 13, 1, 210000.00),
(15, 14, 4, 1, 120000.00),
(16, 15, 12, 1, 45000.00),
(17, 16, 4, 1, 120000.00),
(18, 17, 3, 2, 175000.00),
(19, 18, 4, 3, 120000.00),
(20, 18, 3, 1, 175000.00),
(21, 19, 3, 1, 175000.00),
(22, 20, 1, 6, 165000.00),
(23, 21, 9, 1, 200000.00),
(24, 22, 11, 1, 259999.00),
(25, 23, 1, 3, 165000.00);

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `brand_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`product_id`, `product_name`, `price`, `stock_quantity`, `description`, `image_url`, `brand_id`) VALUES
(1, 'iPhone 15 Pro Max', 165000.00, 5, 'Titanium frame, 6.7\" ProMotion display, A17 Pro chip, 5x telephoto camera', 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-15-pro-max-1.jpg', 1),
(3, 'iPhone 16 Pro Max', 175000.00, 3, 'Titanium frame, 6.7\" ProMotion display, A18 Pro chip, 5x telephoto camera', 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-16-pro-max-1.jpg', 1),
(4, 'iPhone 15', 120000.00, 8, '6.1\" Super Retina XDR display, A16 Bionic chip, Dynamic Island, USB-C port', 'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-15-1.jpg', 1),
(7, 'Samsung Galaxy S24 Ultra', 155000.00, 6, '6.8\" QHD+ AMOLED, Snapdragon 8 Gen 3, 200MP camera, S Pen', 'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s24-ultra-5g-sm-s928-0.jpg', 2),
(8, 'Galaxy S25 Ultra', 180000.00, 5, '6.8\" display, Snapdragon 8 Elite chip, 200MP main camera, AI features', 'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-s25-ultra-sm-s938-1.jpg', 2),
(9, 'Galaxy Z Fold 6', 200000.00, 3, 'foldable display, Snapdragon 8 Elite chip, 200MP main camera', 'https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-z-fold6-3.jpg', 2),
(10, 'OnePlus 13R', 64999.00, 15, '6.3\" AMOLED display, Snapdragon 8 Gen 3, 8GB RAM, 128GB storage, 6000mAh battery, Gorilla Glass 7i front and back.', 'https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-13r-1.jpg', 3),
(11, 'OnePlus Open', 259999.00, 5, '7.82\" foldable AMOLED display, Snapdragon 8 Gen 2, 16GB RAM, 512GB storage, 48MP main camera, 67W SUPERVOOC charging, IPX4 splash resistance, OxygenOS 13.2 based on Android 13.', 'https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-open-5.jpg', 3),
(12, 'OnePlus Ace 5', 45000.00, 10, '6.78\" 1.5K AMOLED display, Snapdragon 8 Gen 3, 12GB/16GB RAM, 256GB/512GB storage, 50MP + 8MP + 2MP triple rear cameras, 16MP front camera, 6415mAh battery with 80W fast charging, ColorOS 15 based on Android 15.', 'https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-ace5-1.jpg', 3),
(13, 'Xiaomi 15 Ultra', 210000.00, 5, '6.73\" AMOLED display, Snapdragon 8 Elite chip, 16GB RAM, 512GB storage, Quad rear cameras (50MP wide, 50MP ultra-wide, 50MP telephoto 3x, 200MP telephoto 4.3x), 32MP front camera, 5,410mAh battery, HyperOS 2 (Android 15)', 'https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-15-ultra-5.jpg', 4),
(14, 'Xiaomi Mix Fold 4', 165999.00, 3, '7.98\" Foldable LTPO AMOLED display, Snapdragon 8 Gen 3 chipset, 16GB RAM, 512GB storage, Quad rear cameras (50MP wide, 50MP telephoto 2x, 10MP periscope 5x, 12MP ultrawide), 16MP front camera, 5100mAh battery, HyperOS (Android 14)', 'https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-mix-fold4-1.jpg', 4),
(15, 'Xiaomi Redmi Note 13 4G', 27999.00, 10, '6.67\" AMOLED display, Snapdragon 685 chipset, 8GB RAM, 256GB storage, 108MP main camera, 5000mAh battery, MIUI 14 (Android 13)', 'https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-redmi-note-13-4g-1.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE `USER` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`user_id`, `name`, `email`, `phone`, `address`, `password`, `role`) VALUES
(1, 'Muskan Aryal', 'aryalmuskan17@gmail.com', '9856024240', 'Airport', '1717', 'admin'),
(2, 'Suyog Subedi', 'suyogsubedi@gmail.com', '9812345678', 'Pokhara', 'Mra17@ecommerce', 'customer'),
(6, 'Muskan Aryal', 'koho@gmail.com', '9856024240', 'Airport', '1717', 'customer'),
(8, 'User1', 'user1@gmail.com', '9856024240', 'Airport', '123', 'customer'),
(16, 'Prashant GC', 'gcprashant1@gmail.com', '9807654321', 'Budibazar', '123', 'customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Brand`
--
ALTER TABLE `Brand`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indexes for table `Cart`
--
ALTER TABLE `Cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `CartItem`
--
ALTER TABLE `CartItem`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `Order`
--
ALTER TABLE `Order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Brand`
--
ALTER TABLE `Brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Cart`
--
ALTER TABLE `Cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `CartItem`
--
ALTER TABLE `CartItem`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `Order`
--
ALTER TABLE `Order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `OrderItem`
--
ALTER TABLE `OrderItem`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `USER`
--
ALTER TABLE `USER`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Cart`
--
ALTER TABLE `Cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `CartItem`
--
ALTER TABLE `CartItem`
  ADD CONSTRAINT `cartitem_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `Cart` (`cart_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cartitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `Order`
--
ALTER TABLE `Order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `OrderItem`
--
ALTER TABLE `OrderItem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `Product`
--
ALTER TABLE `Product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `Brand` (`brand_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
