-- Basic views

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

    CREATE VIEW vw_promotion_product_details AS
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
    ON pr.product_id = p.product_id;

    CREATE VIEW vw_purchase_details AS
SELECT
    pu.purchase_id,
    pu.purchase_time,
    pu.total_amount,
    pu.overall_promotion_value,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    c.email AS customer_email,
    st.store_id,
    st.store_name,
    e.employee_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    e.position AS employee_position
FROM purchases pu
JOIN customers c
    ON pu.customer_id = c.customer_id
JOIN stores st
    ON pu.store_id = st.store_id
JOIN employees e
    ON pu.employee_id = e.employee_id;

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

-- Optional computed detail view

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

-- vw_store_employee_details

    CREATE VIEW vw_store_employee_details AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    e.store_id,
    st.store_name,
    st.city,
    st.region
FROM employees e
JOIN stores st
    ON e.store_id = st.store_id;

