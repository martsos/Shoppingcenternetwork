CREATE TABLE payment_events (
    transaction_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    purchase_id INT UNSIGNED NOT NULL,
    transaction_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10, 2) NOT NULL,
    discounts_applied DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    loyalty_points_earned INT UNSIGNED NOT NULL DEFAULT 0,
    paid_amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('cash', 'card', 'online') NOT NULL,

    CONSTRAINT pk_payment_events PRIMARY KEY (transaction_id),
    CONSTRAINT fk_payment_events_purchase
        FOREIGN KEY (purchase_id)
        REFERENCES purchases (purchase_id)
);

CREATE TABLE warehouses (
    warehouse_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    warehouse_name VARCHAR(100) NOT NULL,
    store_id INT UNSIGNED NULL,

    CONSTRAINT pk_warehouses PRIMARY KEY (warehouse_id),
    CONSTRAINT fk_warehouses_store
        FOREIGN KEY (store_id)
        REFERENCES stores (store_id)
);

CREATE TABLE warehouse_inventory (
    warehouse_inventory_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    warehouse_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    supplier_id INT UNSIGNED NULL,
    quantity INT UNSIGNED NOT NULL CHECK (quantity >= 0),
    last_restocked DATE NOT NULL,

    CONSTRAINT pk_warehouse_inventory PRIMARY KEY (warehouse_inventory_id),

    CONSTRAINT fk_warehouse_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses (warehouse_id),

    CONSTRAINT fk_warehouse_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products (product_id),

    CONSTRAINT fk_warehouse_inventory_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id),

    CONSTRAINT uq_warehouse_product
        UNIQUE (warehouse_id, product_id)
);

