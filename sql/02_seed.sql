-- ============================================
-- RetailDB - Sample Data
-- All customers and transactions are fictional
-- ============================================

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;


-- ============================================
-- CUSTOMERS
-- ============================================

INSERT INTO customers VALUES

(1, 'Emma Rossi', 'emma.rossi@example.com', 'Italy'),

(2, 'Luca Bianchi', 'luca.bianchi@example.com', 'Italy'),

(3, 'Sofia Martins', 'sofia.martins@example.com', 'Portugal'),

(4, 'Noah Meyer', 'noah.meyer@example.com', 'Germany'),

(5, 'Ava Johnson', 'ava.johnson@example.com', 'United Kingdom'),

(6, 'Mia Laurent', 'mia.laurent@example.com', 'France');


-- ============================================
-- PRODUCTS
-- ============================================

INSERT INTO products VALUES

(1, 'Wireless Mouse', 'Accessories', 2599, 20),

(2, 'Mechanical Keyboard', 'Accessories', 7990, 15),

(3, 'USB-C Hub', 'Accessories', 3990, 18),

(4, 'Laptop Stand', 'Office', 3490, 22),

(5, 'Webcam HD', 'Electronics', 5990, 10),

(6, 'Notebook A5', 'Stationery', 890, 50),

(7, 'Desk Lamp', 'Office', 4590, 12),

(8, 'Bluetooth Speaker', 'Electronics', 6990, 8);


-- ============================================
-- ORDERS
-- ============================================

INSERT INTO orders VALUES

(1, 1, '2026-09-03', 'paid'),

(2, 2, '2026-09-05', 'shipped'),

(3, 3, '2026-09-08', 'paid'),

(4, 1, '2026-09-12', 'cancelled'),

(5, 4, '2026-09-18', 'shipped'),

(6, 5, '2026-09-21', 'paid'),

(7, 2, '2026-09-24', 'paid'),

(8, 6, '2026-10-02', 'pending'),

(9, 3, '2026-10-08', 'shipped'),

(10, 4, '2026-10-12', 'paid');


-- ============================================
-- ORDER ITEMS
-- ============================================

INSERT INTO order_items VALUES

(1, 1, 1, 2, 2599),

(2, 1, 3, 1, 3990),

(3, 2, 2, 1, 7990),

(4, 2, 6, 3, 890),

(5, 3, 4, 2, 3490),

(6, 3, 6, 2, 890),

(7, 4, 5, 1, 5990),

(8, 5, 3, 2, 3990),

(9, 5, 7, 1, 4590),

(10, 6, 5, 1, 5990),

(11, 6, 6, 5, 890),

(12, 7, 1, 1, 2599),

(13, 7, 2, 1, 7990),

(14, 8, 8, 1, 6990),

(15, 9, 8, 2, 6990),

(16, 9, 3, 1, 3990),

(17, 10, 7, 2, 4590),

(18, 10, 4, 1, 3490);


COMMIT;