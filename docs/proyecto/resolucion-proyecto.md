# RESOLUCIÓN DE LA PROBLEMÁTICA

La problemática principal de MercadoMax consiste en la falta de información integrada para dar seguimiento a las operaciones de ventas.

La base de datos diseñada permite centralizar la información de clientes, pedidos, productos, pagos, inventario y devoluciones, haciendo posible responder consultas que apoyan la toma de decisiones.

Las principales consultas desarrolladas permiten:

- Identificar pedidos pendientes de pago o confirmación.
- Detectar productos con bajo inventario.
- Analizar qué productos generan mayores ventas.
- Medir el impacto económico de las devoluciones.
- Detectar clientes con mayor número de pedidos cancelados o devoluciones.


## Consulta 1 

¿Qué pedidos siguen pendientes de pago o confirmación?

Esta consulta permite al personal identificar rápidamente los pedidos que aún requieren seguimiento antes de poder completarse.

```sql
SELECT
    o.order_id,
    c.full_name,
    o.order_status,
    p.payment_status,
    o.total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
WHERE
    o.order_status = 'pending'
    OR p.payment_status = 'pending';
```
## Consulta 2

¿Qué productos tienen inventario disponible bajo?

Permite detectar productos que requieren reabastecimiento antes de quedarse sin existencias.

```sql
SELECT
    p.product_name,
    i.units_available,
    i.reorder_level
FROM products p
JOIN inventory i
    ON p.product_id = i.product_id
WHERE i.units_available <= i.reorder_level;
```

## Consulta 3

¿Qué productos generan mayores ventas brutas?

Permite identificar los productos que generan mayores ventas brutas, facilitando el análisis del desempeño comercial de cada producto.

```sql
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS gross_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_name
ORDER BY gross_sales DESC;
```

## Consulta 4

¿Qué devoluciones afectan más los ingresos netos?

Permite identificar qué productos generan un mayor monto de devoluciones y, por lo tanto, tienen un mayor impacto sobre los ingresos netos de la empresa.

```sql
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
```

## Consulta 5

¿Qué clientes acumulan más pedidos cancelados o devoluciones?

Permite identificar clientes con un mayor historial de pedidos cancelados o devoluciones, información útil para el seguimiento comercial y el análisis del comportamiento de compra.

```sql
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
WHERE o.order_status = 'cancelled'
   OR r.return_id IS NOT NULL
GROUP BY c.full_name
ORDER BY cancelled_orders DESC, total_returns DESC;
```
