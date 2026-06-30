-- MercadoMax starter schema
-- Este schema es intencionalmente incompleto.
-- Sirve como punto de partida, no como solucion final.

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160),
  city VARCHAR(80),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(160) NOT NULL,
  category VARCHAR(80) NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE inventory (
  product_id INTEGER PRIMARY KEY REFERENCES products(product_id),
  units_available INTEGER NOT NULL CHECK (units_available >= 0),
  reorder_level INTEGER NOT NULL DEFAULT 5 CHECK (reorder_level >= 0),
  last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
  order_status VARCHAR(30) NOT NULL CHECK (order_status IN ('pending', 'paid', 'completed', 'cancelled')),
  cancel_reason VARCHAR(200),
  ordered_at TIMESTAMP NOT NULL,
  total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0)
  -- TODO: considerar source_channel, delivery_type o branch_id si el alcance lo necesita.
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(order_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
  -- TODO: decidir si conviene guardar descuentos o subtotal calculado.
);

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(order_id),
  payment_status VARCHAR(30) NOT NULL CHECK (payment_status IN ('pending', 'confirmed', 'failed', 'refunded')),
  amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
  paid_at TIMESTAMP
  -- TODO: agregar payment_method solo si aporta algo real al alcance.
);

CREATE TABLE returns (
  return_id INTEGER PRIMARY KEY,
  order_item_id INTEGER NOT NULL REFERENCES order_items(order_item_id),
  returned_quantity INTEGER NOT NULL CHECK (returned_quantity > 0),
  refunded_amount NUMERIC(10,2) NOT NULL CHECK (refunded_amount >= 0),
  return_reason VARCHAR(200),
  return_status VARCHAR(30) NOT NULL CHECK (return_status IN ('requested', 'approved', 'rejected')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  -- TODO: decidir si una devolucion debe ligarse a order_item en lugar de order + product.
);

-- TODO general:
-- 1. Revisar si inventory deberia modelarse por almacen.
-- 2. Revisar si hacen falta constraints adicionales entre order_status y payment_status.
-- 3. Evaluar si devoluciones requieren mayor detalle monetario.
