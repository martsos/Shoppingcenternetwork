-- Employee summary 

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

-- Store summary 

SELECT
    p.store_id,
    st.store_name,
    DATE(p.purchase_time) AS sales_date,
    COUNT(p.purchase_id) AS total_purchases,
    COALESCE(SUM(p.total_amount), 0) AS total_sales_amount,
    COALESCE(SUM(p.overall_promotion_value), 0) AS total_discount_amount,
    MAX(p.purchase_time) AS last_purchase_time
FROM purchases p
JOIN stores st
    ON p.store_id = st.store_id
GROUP BY
    p.store_id,
    st.store_name,
    DATE(p.purchase_time);