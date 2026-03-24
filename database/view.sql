--Basic views

CREATE VIEW vw_product_catalog AS
SELECT
    p.product_id,
    p.sku,
    p.product_name,
    p.brand,
    p.unit_price,
    c.category_id,
    c.category_name,
    s.supplier_id,
    s.supplier_name
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN suppliers s
    ON p.supplier_id = s.supplier_id;

    CREATE VIEW vw_purchase_item_details AS
SELECT
    pi.purchase_item_id,
    pi.purchase_id,
    pi.product_id,
    p.sku,
    p.product_name,
    p.brand,
    c.category_name,
    pi.quantity,
    pi.unit_price,
    pi.promotion_value,
    (pi.quantity * pi.unit_price) AS line_gross_amount,
    (pi.quantity * pi.unit_price) - pi.promotion_value AS line_net_amount
FROM purchase_items pi
JOIN products p
    ON pi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id;

    CREATE VIEW vw_inventory_status AS
SELECT
    i.inventory_id,
    i.store_id,
    st.store_name,
    i.product_id,
    p.sku,
    p.product_name,
    p.brand,
    c.category_name,
    i.quantity,
    i.last_restocked
FROM inventory i
JOIN stores st
    ON i.store_id = st.store_id
JOIN products p
    ON i.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id;

-- Optional view (With aggregation)

CREATE VIEW vw_purchase_item_details AS
SELECT
    pi.purchase_item_id,
    pi.purchase_id,
    pi.product_id,
    p.sku,
    p.product_name,
    p.brand,
    c.category_name,
    pi.quantity,
    pi.unit_price,
    pi.promotion_value,
    (pi.quantity * pi.unit_price) AS line_gross_amount,
    (pi.quantity * pi.unit_price) - pi.promotion_value AS line_net_amount
FROM purchase_items pi
JOIN products p
    ON pi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id;

-- Reporting view (Time-dependent)

CREATE VIEW vw_active_promotions AS
SELECT
    pr.promotion_id,
    pr.promotion_name,
    pr.product_id,
    p.product_name,
    p.sku,
    pr.discount_percentage,
    pr.start_date,
    pr.end_date
FROM promotions pr
JOIN products p
    ON pr.product_id = p.product_id
WHERE CURRENT_DATE BETWEEN pr.start_date AND pr.end_date;

-- 

  CREATE VIEW vw_employee_purchase_summary AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    e.store_id,
    COUNT(p.purchase_id) AS total_purchases_handled,
    COALESCE(SUM(p.total_amount), 0) AS total_sales_amount,
    MAX(p.purchase_time) AS last_purchase_time
FROM employees e
LEFT JOIN purchases p
    ON e.employee_id = p.employee_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    e.store_id;