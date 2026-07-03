-- ===========================================
-- MercadoMax
-- Roles y permisos
-- ===========================================

-- Creación de roles

CREATE ROLE admin;

CREATE ROLE sales_operator;

CREATE ROLE inventory_manager;

-- ===========================================
-- Permisos del administrador
-- ===========================================

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;

-- ===========================================
-- Permisos del operador de ventas
-- ===========================================

GRANT SELECT ON customers TO sales_operator;

GRANT SELECT ON products TO sales_operator;

GRANT SELECT, INSERT ON orders TO sales_operator;

GRANT SELECT, INSERT ON order_items TO sales_operator;

GRANT SELECT, INSERT ON payments TO sales_operator;

-- ===========================================
-- Permisos del encargado de inventario
-- ===========================================

GRANT SELECT ON products TO inventory_manager;

GRANT SELECT, UPDATE ON inventory TO inventory_manager;

GRANT SELECT, INSERT, UPDATE ON returns TO inventory_manager;