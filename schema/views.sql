-- ===========================================
-- MercadoMax
-- Vistas
-- ===========================================

-- Pedidos pendientes

CREATE VIEW vw_pending_orders AS
SELECT
    o.order_id,
    c.full_name,
    o.order_status,
    p.payment_status,
    o.total_amount,
    o.ordered_at
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE
    o.order_status = 'pending'
    OR p.payment_status = 'pending';

------------------------------------------------

-- Inventario bajo

CREATE VIEW vw_low_inventory AS
SELECT
    p.product_name,
    i.units_available,
    i.reorder_level
FROM inventory i
JOIN products p
    ON p.product_id = i.product_id
WHERE i.units_available <= i.reorder_level;

------------------------------------------------

-- Ventas por producto

CREATE VIEW vw_product_sales AS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS gross_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;