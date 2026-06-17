TRUNCATE TABLE returns, payments, order_items, orders, inventory, products, customers RESTART IDENTITY CASCADE;

INSERT INTO customers (customer_id, full_name, email, city, created_at) VALUES
  (1, 'Ana Lopez', 'ana.lopez@example.com', 'Monterrey', '2026-05-02 09:00:00'),
  (2, 'Bruno Diaz', 'bruno.diaz@example.com', 'Guadalajara', '2026-05-04 12:00:00'),
  (3, 'Carla Mena', 'carla.mena@example.com', 'Merida', '2026-05-08 15:30:00');

INSERT INTO products (product_id, product_name, category, unit_price, active) VALUES
  (101, 'Laptop Nova 14', 'electronics', 18999.00, TRUE),
  (102, 'Mouse Orbit', 'electronics', 399.00, TRUE),
  (103, 'Desk Lamp Aura', 'home', 799.00, TRUE),
  (104, 'Notebook Pack', 'office', 149.00, TRUE),
  (105, 'USB-C Hub 6-in-1', 'electronics', 999.00, TRUE);

INSERT INTO inventory (product_id, units_available, reorder_level, last_updated) VALUES
  (101, 4, 3, '2026-06-10 08:00:00'),
  (102, 18, 8, '2026-06-10 08:00:00'),
  (103, 7, 5, '2026-06-10 08:00:00'),
  (104, 26, 10, '2026-06-10 08:00:00'),
  (105, 3, 4, '2026-06-10 08:00:00');

INSERT INTO orders (order_id, customer_id, order_status, ordered_at, total_amount) VALUES
  (1001, 1, 'pending', '2026-06-09 10:15:00', 19798.00),
  (1002, 2, 'paid', '2026-06-09 13:25:00', 1148.00),
  (1003, 1, 'completed', '2026-06-10 09:40:00', 798.00),
  (1004, 3, 'cancelled', '2026-06-10 16:20:00', 999.00);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1, 1001, 101, 1, 18999.00),
  (2, 1001, 102, 2, 399.00),
  (3, 1002, 105, 1, 999.00),
  (4, 1002, 104, 1, 149.00),
  (5, 1003, 103, 1, 799.00),
  (6, 1004, 105, 1, 999.00);

INSERT INTO payments (payment_id, order_id, payment_status, amount, paid_at) VALUES
  (501, 1001, 'pending', 19798.00, NULL),
  (502, 1002, 'confirmed', 1148.00, '2026-06-09 13:40:00'),
  (503, 1003, 'confirmed', 798.00, '2026-06-10 09:45:00'),
  (504, 1004, 'failed', 999.00, NULL);

INSERT INTO returns (return_id, order_id, product_id, returned_quantity, return_reason, return_status, created_at) VALUES
  (9001, 1003, 103, 1, 'Pantalla con dano', 'approved', '2026-06-12 11:30:00');
