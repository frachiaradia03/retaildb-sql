-- ============================================
-- RetailDB - Validation Checks
-- ============================================


-- 1. Database integrity

PRAGMA integrity_check;


-- 2. Foreign key integrity
-- Expected result: no rows

PRAGMA foreign_key_check;


-- 3. Verify expected row counts

SELECT

    'Expected records' AS test_name,

    CASE
        WHEN
            (SELECT COUNT(*) FROM customers) = 6
            AND
            (SELECT COUNT(*) FROM products) = 8
            AND
            (SELECT COUNT(*) FROM orders) = 10
            AND
            (SELECT COUNT(*) FROM order_items) = 18

        THEN 'PASS'

        ELSE 'FAIL'

    END AS result;


-- 4. Verify total revenue in cents

SELECT

    'Revenue calculation' AS test_name,

    CASE

        WHEN (

            SELECT SUM(
                oi.quantity * oi.unit_price_cents
            )

            FROM orders o

            JOIN order_items oi
                ON o.order_id = oi.order_id

            WHERE o.status IN ('paid', 'shipped')

        ) = 92847

        THEN 'PASS'

        ELSE 'FAIL'

    END AS result;