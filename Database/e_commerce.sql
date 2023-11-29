-- Drop database ecommerce;

CREATE DATABASE ecommerce;
USE ecommerce;
-- Drop any existing tables
DROP TABLE IF EXISTS product_review;
DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS shop_order;
DROP TABLE IF EXISTS order_status;
DROP TABLE IF EXISTS shipping_method;
DROP TABLE IF EXISTS shopping_cart_item;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS user_payment_method;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS promotion_category;
DROP TABLE IF EXISTS promotion;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS user_address;
DROP TABLE IF EXISTS site_user;
DROP TABLE IF EXISTS address;

-- Create the tables

CREATE TABLE address (
id INT AUTO_INCREMENT,
address_line1 VARCHAR(500),
address_line2 VARCHAR(500),
city VARCHAR(200),
state VARCHAR(200),
postal_code VARCHAR(20),
country varchar(50),
CONSTRAINT pk_address PRIMARY KEY (id)
);

CREATE TABLE site_user (
id INT AUTO_INCREMENT,
first_name varchar(100),
last_name varchar(100),
email_id VARCHAR(350),
phone_number VARCHAR(20),
user_password VARCHAR(500),
CONSTRAINT pk_user PRIMARY KEY (id)
);


CREATE TABLE user_address (
id int auto_increment,
user_id INT,
address_id INT,
is_default INT,
CONSTRAINT fk_useradd_user FOREIGN KEY (user_id) REFERENCES
site_user (id),
CONSTRAINT fk_useradd_address FOREIGN KEY (address_id) REFERENCES
address (id),
CONSTRAINT pk_useraddress PRIMARY KEY (id)
);

CREATE TABLE product_category (
id INT AUTO_INCREMENT,
category_name VARCHAR(200),
CONSTRAINT pk_category PRIMARY KEY (id)
);

CREATE TABLE promotion (
id INT AUTO_INCREMENT,
promotion_name VARCHAR(200),
promotion_description VARCHAR(2000),
discount_rate INT,
start_date DATETIME,
end_date DATETIME,
CONSTRAINT pk_promo PRIMARY KEY (id)
);

CREATE TABLE promotion_category (
id int auto_increment,
category_id INT,
promotion_id INT,
CONSTRAINT pk_promocat PRIMARY KEY (id),
CONSTRAINT fk_promocat_category FOREIGN KEY (category_id) REFERENCES
product_category (id),
CONSTRAINT fk_promocat_promo FOREIGN KEY (promotion_id) REFERENCES
promotion (id)
);

CREATE TABLE product (
id INT AUTO_INCREMENT,
category_id INT,
product_name VARCHAR(500),
product_description VARCHAR(5000),
product_image VARCHAR(1000),
stock long,
price decimal(10,2),
CONSTRAINT pk_product PRIMARY KEY (id),
CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES
product_category (id)
);

CREATE TABLE user_payment_method (
id INT AUTO_INCREMENT,
user_id INT,
client_name varchar(100),
payment_status varchar(20),
-- This will be given by external payment gateway
transaction_id varchar(100), 
transaction_date datetime,

CONSTRAINT pk_userpm PRIMARY KEY (id),
CONSTRAINT fk_userpm_user FOREIGN KEY (user_id) REFERENCES site_user
(id)
);

CREATE TABLE shopping_cart (
id INT AUTO_INCREMENT,
user_id INT,
CONSTRAINT pk_shopcart PRIMARY KEY (id),
CONSTRAINT fk_shopcart_user FOREIGN KEY (user_id) REFERENCES
site_user (id)
);

CREATE TABLE shopping_cart_item (
id INT AUTO_INCREMENT,
cart_id INT,
product_id INT,
qty INT,
CONSTRAINT pk_shopcartitem PRIMARY KEY (id),
CONSTRAINT fk_shopcartitem_shopcart FOREIGN KEY (cart_id) REFERENCES
shopping_cart (id),
CONSTRAINT fk_shopcartitem_proditem FOREIGN KEY (product_id)
REFERENCES product (id)
);

CREATE TABLE shipping_method (
id INT AUTO_INCREMENT,
shipping_method VARCHAR(100),
price decimal(10,2),
CONSTRAINT pk_shipmethod PRIMARY KEY (id)
);

-- Planning to add more columns so created a separate table for order status
CREATE TABLE order_status (
id INT AUTO_INCREMENT,
order_status VARCHAR(100),
CONSTRAINT pk_orderstatus PRIMARY KEY (id)
);

CREATE TABLE shop_order (
id INT AUTO_INCREMENT,
user_id INT,
order_date DATETIME,
shipping_address INT,
shipping_method INT,
order_total decimal(10,2),
order_status INT,
CONSTRAINT pk_shoporder PRIMARY KEY (id),
CONSTRAINT fk_shoporder_user FOREIGN KEY (user_id) REFERENCES
site_user (id),
CONSTRAINT fk_shoporder_shipaddress FOREIGN KEY (shipping_address)
REFERENCES address (id),
CONSTRAINT fk_shoporder_shipmethod FOREIGN KEY (shipping_method)
REFERENCES shipping_method (id),
CONSTRAINT fk_shoporder_status FOREIGN KEY (order_status) REFERENCES
order_status (id)
);

CREATE TABLE order_line (
id INT AUTO_INCREMENT,
product_id INT,
order_id INT,
qty INT,
price decimal(10,2),
CONSTRAINT pk_orderline PRIMARY KEY (id),
CONSTRAINT fk_orderline_product FOREIGN KEY (product_id)
REFERENCES product (id),
CONSTRAINT fk_orderline_order FOREIGN KEY (order_id) REFERENCES
shop_order (id)
);

CREATE TABLE product_review (
id INT AUTO_INCREMENT,
user_id INT,
ordered_product_id INT,
rating_value INT,
user_comment VARCHAR(2000),
CONSTRAINT pk_review PRIMARY KEY (id),
CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES site_user
(id),
CONSTRAINT fk_review_product FOREIGN KEY (ordered_product_id)
REFERENCES order_line (id)
);
CREATE TABLE order_payment_method (
    id INT AUTO_INCREMENT,
    order_id INT,
    user_payment_method_id INT,
    CONSTRAINT pk_orderpm PRIMARY KEY (id),
    CONSTRAINT fk_orderpm_order FOREIGN KEY (order_id) REFERENCES shop_order (id),
    CONSTRAINT fk_orderpm_userpm FOREIGN KEY (user_payment_method_id) REFERENCES user_payment_method (id)
);

/*
-- execute the below code after running the above script

-- Add the new columns to the shop_order table
-- ALTER TABLE shop_order
--     ADD COLUMN order_payment_method_id INT,
--     ADD CONSTRAINT fk_shoporder_orderpm FOREIGN KEY (order_payment_method_id) REFERENCES order_payment_method (id);



-- Update existing data
UPDATE shop_order
SET order_payment_method_id = (
    SELECT id FROM order_payment_method WHERE order_id = shop_order.id
);

*/