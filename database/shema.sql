-- In this project, I am attempting to visualize and implement the database schema of a small Hungarian supermarket chain.
-- First step: create the database.

CREATE DATABASE IF NOT EXISTS shoppingcenternetwork;
USE shoppingcenternetwork;

CREATE TABLE customers (
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NULL,
    last_name VARCHAR(50) NULL,
    email VARCHAR(50) NULL,
    phone VARCHAR(15) NULL,
    loyalty_card VARCHAR(15) NOT NULL,
    loyalty_points INT NOT NULL CHECK (loyalty_points >= 0),
    registration_date DATE NOT NULL,

    CONSTRAINT pk_customers PRIMARY KEY (customer_id),

    CONSTRAINT uq_customers_email UNIQUE (email),

    CONSTRAINT uq_customers_loyalty_card UNIQUE (loyalty_card)
);

CREATE TABLE stores (
    store_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    manager_employee_id INT UNSIGNED NULL,
    opening_date DATE NOT NULL CHECK (opening_date <= CURRENT_DATE),
    CONSTRAINT pk_stores PRIMARY KEY (store_id)
);

CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    store_id INT UNSIGNED NOT NULL,

    CONSTRAINT pk_employees PRIMARY KEY (employee_id),

    CONSTRAINT fk_employees_store
        FOREIGN KEY (store_id)
        REFERENCES stores (store_id)
);

CREATE TABLE suppliers (
    supplier_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    phone VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,

    CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id),

    CONSTRAINT uq_suppliers_email UNIQUE (email)
);

CREATE TABLE categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NULL,

    CONSTRAINT pk_categories PRIMARY KEY (category_id),
    CONSTRAINT uq_categories_name UNIQUE (category_name)
);

CREATE TABLE products (
    product_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    sku VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    brand VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    supplier_id INT UNSIGNED NOT NULL,
    loyalty_point_value INT UNSIGNED NOT NULL DEFAULT 0,

    CONSTRAINT pk_products PRIMARY KEY (product_id),

    CONSTRAINT uq_products_sku UNIQUE (sku),

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories (category_id),

    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id)
);

CREATE TABLE purchases (
    purchase_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    store_id INT UNSIGNED NOT NULL,
    purchase_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    employee_id INT UNSIGNED NOT NULL,
    CONSTRAINT pk_purchases PRIMARY KEY (purchase_id),

    CONSTRAINT fk_purchases_customer 
        FOREIGN KEY (customer_id) 
        REFERENCES customers (customer_id),

    CONSTRAINT fk_purchases_store 
        FOREIGN KEY (store_id) 
        REFERENCES stores (store_id),

    CONSTRAINT fk_purchases_employee 
        FOREIGN KEY (employee_id) 
        REFERENCES employees (employee_id)
);

CREATE TABLE purchase_items (
    purchase_item_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    purchase_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    loyalty_point_value INT UNSIGNED NOT NULL DEFAULT 0,

    CONSTRAINT pk_purchase_items PRIMARY KEY (purchase_item_id),

    CONSTRAINT fk_purchase_items_purchase
        FOREIGN KEY (purchase_id)
        REFERENCES purchases (purchase_id),

    CONSTRAINT fk_purchase_items_product
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

CREATE TABLE inventory (
    inventory_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    store_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    last_restocked DATE NOT NULL,

    CONSTRAINT pk_inventory PRIMARY KEY (inventory_id),

    CONSTRAINT fk_inventory_store
        FOREIGN KEY (store_id)
        REFERENCES stores (store_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products (product_id),

    CONSTRAINT uq_inventory_store_product UNIQUE (store_id, product_id)
);

CREATE TABLE employee_actions (
    action_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    employee_id INT UNSIGNED NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    target_table VARCHAR(50) NOT NULL,
    target_id INT UNSIGNED NOT NULL,

    CONSTRAINT pk_employee_actions PRIMARY KEY (action_id),

    CONSTRAINT fk_employee_actions_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id)
);

CREATE TABLE promotions (
    promotion_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    promotion_name VARCHAR(50) NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    discount_percentage DECIMAL(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    CONSTRAINT pk_promotions PRIMARY KEY (promotion_id),

    CONSTRAINT fk_promotions_product
        FOREIGN KEY (product_id)
        REFERENCES products (product_id),

    CONSTRAINT chk_promotions_dates
        CHECK (end_date >= start_date),

    CONSTRAINT chk_promotions_discount
        CHECK (discount_percentage >= 0 AND discount_percentage <= 100)
);

ALTER TABLE stores
ADD CONSTRAINT fk_stores_manager_employee
FOREIGN KEY (manager_employee_id)
REFERENCES employees (employee_id);