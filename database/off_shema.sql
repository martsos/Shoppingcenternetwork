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