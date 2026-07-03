-- ===========================================
-- MercadoMax
-- Índices
-- ===========================================

-- Pedidos por cliente

CREATE INDEX idx_orders_customer
ON orders(customer_id);

------------------------------------------------

-- Estado del pedido

CREATE INDEX idx_orders_status
ON orders(order_status);

------------------------------------------------

-- Estado del pago

CREATE INDEX idx_payments_status
ON payments(payment_status);

------------------------------------------------

-- Productos vendidos

CREATE INDEX idx_order_items_product
ON order_items(product_id);

------------------------------------------------

-- Devoluciones

CREATE INDEX idx_returns_order_item
ON returns(order_item_id);

------------------------------------------------

-- Inventario

CREATE INDEX idx_inventory_stock
ON inventory(units_available);