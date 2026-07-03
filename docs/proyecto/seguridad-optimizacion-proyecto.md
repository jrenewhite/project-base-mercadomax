# MercadoMax - Seguridad y Optimización

## Roles y permisos

Con el objetivo de mejorar la seguridad de la base de datos y aplicar el principio de **mínimo privilegio**, se definieron tres roles principales. Cada uno cuenta únicamente con los permisos necesarios para desempeñar sus funciones.

### Administrador (`admin`)

Es el responsable de administrar completamente la base de datos.

**Permisos:**

- Consultar toda la información.
- Insertar, actualizar y eliminar registros.
- Administrar usuarios y permisos.
- Gestionar inventario, pedidos, pagos y devoluciones.

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
```

---

### Operador de ventas (`sales_operator`)

Es el encargado de registrar las ventas y dar seguimiento a los pedidos.

**Permisos:**

- Consultar clientes.
- Consultar productos.
- Registrar pedidos.
- Registrar productos del pedido.
- Registrar pagos.

**No puede:**

- Modificar inventario.
- Eliminar información.
- Aprobar devoluciones.

```sql
GRANT SELECT ON customers TO sales_operator;

GRANT SELECT ON products TO sales_operator;

GRANT SELECT, INSERT ON orders TO sales_operator;

GRANT SELECT, INSERT ON order_items TO sales_operator;

GRANT SELECT, INSERT ON payments TO sales_operator;
```

---

### Encargado de inventario (`inventory_manager`)

Es responsable del control de existencias y las devoluciones.

**Permisos:**

- Consultar productos.
- Consultar inventario.
- Actualizar inventario.
- Registrar devoluciones.

**No puede:**

- Registrar pagos.
- Eliminar pedidos.
- Administrar clientes.

```sql
GRANT SELECT ON products TO inventory_manager;

GRANT SELECT, UPDATE ON inventory TO inventory_manager;

GRANT SELECT, INSERT, UPDATE ON returns TO inventory_manager;
```

---

## Vistas (Views)

Las vistas permiten simplificar consultas frecuentes y facilitar el acceso a la información sin necesidad de consultar directamente todas las tablas.

### Vista 1. Pedidos pendientes

Permite conocer rápidamente los pedidos que aún requieren seguimiento.

```sql
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
```

---

### Vista 2. Inventario bajo

Permite identificar los productos que requieren reabastecimiento.

```sql
CREATE VIEW vw_low_inventory AS
SELECT
    p.product_name,
    i.units_available,
    i.reorder_level
FROM inventory i
JOIN products p
    ON p.product_id = i.product_id
WHERE i.units_available <= i.reorder_level;
```

---

### Vista 3. Ventas por producto

Resume las ventas de cada producto.

```sql
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
```

---

## Índices

Con el objetivo de mejorar el rendimiento de las consultas más utilizadas, se implementaron índices sobre las columnas empleadas en filtros, búsquedas y relaciones entre tablas.

### Índice para clientes y pedidos

Permite localizar rápidamente los pedidos pertenecientes a un cliente.

```sql
CREATE INDEX idx_orders_customer
ON orders(customer_id);
```

---

### Índice para estado de los pedidos

Optimiza la búsqueda de pedidos pendientes, pagados, completados o cancelados.

```sql
CREATE INDEX idx_orders_status
ON orders(order_status);
```

---

### Índice para estado de los pagos

Mejora el rendimiento de las consultas relacionadas con pagos pendientes, confirmados o fallidos.

```sql
CREATE INDEX idx_payments_status
ON payments(payment_status);
```

---

### Índice para productos vendidos

Optimiza los reportes de ventas por producto.

```sql
CREATE INDEX idx_order_items_product
ON order_items(product_id);
```

---

### Índice para devoluciones

Permite localizar rápidamente el artículo del pedido asociado a una devolución.

```sql
CREATE INDEX idx_returns_order_item
ON returns(order_item_id);
```

---

### Índice para inventario

Optimiza las consultas que buscan productos con bajo inventario.

```sql
CREATE INDEX idx_inventory_stock
ON inventory(units_available);
```

---

## Justificación técnica

Las mejoras implementadas buscan complementar el diseño de la base de datos sin modificar el alcance original del proyecto.

- **Los roles** permiten controlar el acceso a la información y reducir el riesgo de modificaciones no autorizadas, siguiendo el principio de mínimo privilegio.
- **Las vistas** simplifican consultas frecuentes y ofrecen una forma más sencilla de acceder a la información relevante para el negocio.
- **Los índices** mejoran el rendimiento de las consultas más importantes del sistema, especialmente aquellas relacionadas con pedidos, pagos, inventario, ventas y devoluciones.

Estas decisiones permiten que la base de datos no solo almacene información correctamente, sino que también sea más segura, eficiente y preparada para soportar el crecimiento futuro del sistema.