-- ============================================
-- RetailDB - Business Queries
-- ============================================


-- ============================================
-- QUERY 1
-- Orders with customer name and total value
-- ============================================

SELECT
    o.order_id,
    c.full_name AS customer,
    o.order_date,
    o.status,

    ROUND(
        SUM(oi.quantity * oi.unit_price_cents) / 100.0,
        2
    ) AS total_eur

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    o.order_id,
    c.full_name,
    o.order_date,
    o.status

ORDER BY o.order_date DESC;



-- ============================================
-- QUERY 2
-- Monthly revenue from paid and shipped orders
-- ============================================

SELECT

    substr(o.order_date, 1, 7) AS month,

    COUNT(DISTINCT o.order_id) AS completed_orders,

    ROUND(
        SUM(oi.quantity * oi.unit_price_cents) / 100.0,
        2
    ) AS revenue_eur

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.status IN ('paid', 'shipped')

GROUP BY substr(o.order_date, 1, 7)

ORDER BY month;



-- ============================================
-- QUERY 3
-- Top 5 best-selling products
-- ============================================

SELECT

    p.product_name,

    SUM(oi.quantity) AS units_sold,

    ROUND(
        SUM(oi.quantity * oi.unit_price_cents) / 100.0,
        2
    ) AS revenue_eur

FROM products p

JOIN order_items oi
    ON p.product_id = oi.product_id

JOIN orders o
    ON o.order_id = oi.order_id

WHERE o.status IN ('paid', 'shipped')

GROUP BY
    p.product_id,
    p.product_name

ORDER BY
    units_sold DESC,
    revenue_eur DESC

LIMIT 5;



-- ============================================
-- QUERY 4
-- Customers ranked by total spending
-- ============================================

SELECT

    c.full_name,

    COUNT(DISTINCT o.order_id) AS completed_orders,

    ROUND(
        COALESCE(
            SUM(oi.quantity * oi.unit_price_cents),
            0
        ) / 100.0,
        2
    ) AS total_spent_eur

FROM customers c

LEFT JOIN orders o
    ON o.customer_id = c.customer_id
    AND o.status IN ('paid', 'shipped')

LEFT JOIN order_items oi
    ON oi.order_id = o.order_id

GROUP BY
    c.customer_id,
    c.full_name

ORDER BY total_spent_eur DESC;



-- ============================================
-- QUERY 5
-- Products with low stock
-- ============================================

SELECT

    product_name,
    stock_quantity

FROM products

WHERE stock_quantity < 15

ORDER BY stock_quantity ASC;



-- ============================================
-- QUERY 6
-- Detailed items of order number 9
-- ============================================

SELECT

    o.order_id,

    c.full_name,

    p.product_name,

    oi.quantity,

    ROUND(
        oi.unit_price_cents / 100.0,
        2
    ) AS unit_price_eur,

    ROUND(
        oi.quantity * oi.unit_price_cents / 100.0,
        2
    ) AS line_total_eur

FROM orders o

JOIN customers c
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON oi.order_id = o.order_id

JOIN products p
    ON p.product_id = oi.product_id

WHERE o.order_id = 9

ORDER BY p.product_name;