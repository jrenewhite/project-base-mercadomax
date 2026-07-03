-- ===========================================
-- MercadoMax
-- Consultas principales
-- ===========================================

------------------------------------------------
-- Consulta 1
-- Pedidos pendientes de pago o confirmación
------------------------------------------------

SELECT *
FROM vw_pending_orders;

------------------------------------------------
-- Consulta 2
-- Productos con inventario bajo
------------------------------------------------

SELECT *
FROM vw_low_inventory;

------------------------------------------------
-- Consulta 3
-- Productos con mayores ventas brutas
------------------------------------------------

SELECT *
FROM vw_product_sales
ORDER BY gross_sales DESC;

------------------------------------------------
-- Consulta 4
-- Devoluciones con mayor impacto económico
------------------------------------------------

SELECT
    p.product_name,
    SUM(r.refunded_amount) AS total_refunded
FROM returns r
JOIN order_items oi
    ON r.order_item_id = oi.order_item_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY total_refunded DESC;

------------------------------------------------
-- Consulta 5
-- Clientes con más cancelaciones o devoluciones
------------------------------------------------

SELECT
    c.full_name,
    COUNT(DISTINCT o.order_id) AS cancelled_orders,
    COUNT(r.return_id) AS total_returns
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN returns r
    ON oi.order_item_id = r.order_item_id
WHERE
    o.order_status = 'cancelled'
    OR r.return_id IS NOT NULL
GROUP BY
    c.full_name
ORDER BY
    cancelled_orders DESC,
    total_returns DESC;