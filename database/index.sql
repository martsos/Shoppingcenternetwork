CREATE INDEX idx_stores_manager_employee_id
    ON stores (manager_employee_id);

CREATE INDEX idx_employees_store_id
    ON employees (store_id);

CREATE INDEX idx_products_category_id
    ON products (category_id);

CREATE INDEX idx_products_supplier_id
    ON products (supplier_id);

CREATE INDEX idx_purchases_store_time
    ON purchases (store_id, purchase_time);

CREATE INDEX idx_purchases_customer_time
    ON purchases (customer_id, purchase_time);

CREATE INDEX idx_purchases_employee_time
    ON purchases (employee_id, purchase_time);

CREATE INDEX idx_purchase_items_purchase_id
    ON purchase_items (purchase_id);

CREATE INDEX idx_purchase_items_product_id
    ON purchase_items (product_id);

CREATE INDEX idx_employee_actions_employee_id
    ON employee_actions (employee_id);

CREATE INDEX idx_employee_actions_action_type_id
    ON employee_actions (action_type_id);

CREATE INDEX idx_employee_actions_target
    ON employee_actions (target_table, target_id);

CREATE INDEX idx_promotions_product_dates
    ON promotions (product_id, start_date, end_date);

CREATE INDEX idx_purchases_time
    ON purchases (purchase_time);