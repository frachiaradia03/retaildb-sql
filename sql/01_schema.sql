-- ============================================
-- RetailDB - SQL Order Management System
-- Database schema
-- ============================================

PRAGMA foreign_keys = ON;


-- ============================================
-- CUSTOMERS
-- ============================================

CREATE TABLE IF NOT EXISTS customers (

    customer_id INTEGER PRIMARY KEY,

    full_name TEXT NOT NULL,

    email TEXT NOT NULL UNIQUE,

    country TEXT NOT NULL

);


-- ============================================
-- PRODUCTS
-- ============================================

CREATE TABLE IF NOT EXISTS products (

    product_id INTEGER PRIMARY KEY,

    product_name TEXT NOT NULL,

    category TEXT NOT NULL,

    price_cents INTEGER NOT NULL
        CHECK (price_cents >= 0),

    stock_quantity INTEGER NOT NULL
        CHECK (stock_quantity >= 0)

);


-- ============================================
-- ORDERS
-- ============================================

CREATE TABLE IF NOT EXISTS orders (

    order_id INTEGER PRIMARY KEY,

    customer_id INTEGER NOT NULL,

    order_date TEXT NOT NULL,

    status TEXT NOT NULL
        CHECK (
            status IN (
                'pending',
                'paid',
                'shipped',
                'cancelled'
            )
        ),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE RESTRICT

);


-- ============================================
-- ORDER ITEMS
-- ============================================

CREATE TABLE IF NOT EXISTS order_items (

    order_item_id INTEGER PRIMARY KEY,

    order_id INTEGER NOT NULL,

    product_id INTEGER NOT NULL,

    quantity INTEGER NOT NULL
        CHECK (quantity > 0),

    unit_price_cents INTEGER NOT NULL
        CHECK (unit_price_cents >= 0),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE RESTRICT,

    UNIQUE (order_id, product_id)

);


-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX IF NOT EXISTS idx_orders_customer
ON orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_date
ON orders(order_date);

CREATE INDEX IF NOT EXISTS idx_order_items_product
ON order_items(product_id);