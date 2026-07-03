# MercadoMax - Enfoques del proyecto

## Problematica resumida

MercadoMax enfrenta dificultades para dar seguimiento eficiente a sus operaciones debido a que la información de pedidos, pagos, inventario y devoluciones se encuentra dispersa y sin una estructura integrada. 
Esto provoca que la empresa no pueda identificar fácilmente los pedidos pendientes, los productos que generan mayores ingresos, el impacto de las devoluciones en las ventas ni los niveles de inventario disponibles. 
Como resultado, la toma de decisiones se vuelve más lenta y menos confiable.

## Alcance elegido

El proyecto se enfocara en diseñar una base de datos que pueda resolver parte de estas problematicas y poder responder las principales preguntas de dicho proyecto y para ello nos centraremos en que se puedan responder estas preguntas:

1. ¿Qué pedidos siguen pendientes de pago o confirmación?
2. ¿Qué productos tienen inventario disponible bajo?
3. ¿Qué productos concentran más ventas brutas?
4. ¿Qué devoluciones afectan más a los ingresos netos?
5. ¿Qué clientes acumulan más pedidos cancelados o devueltos?

Estas preguntas seran el principal enfoque para que la estructura del proyecto tenga un correcto enfoque en la creacion de diagramas y la base de datos presente una estructura solida y coherente.

## Reglas de negocio

1. Un pedido debe pertenecer a un único cliente.
2. Un pedido debe contener al menos un producto.
3. El inventario disponible no puede ser negativo.
4. Una devolución debe estar asociada a un artículo previamente vendido.
5. Una devolución puede ser total o parcial.

## Explicacion de la regla 

1. Cada pedido registrado en el sistema debe estar asociado a un solo cliente responsable de la compra.
2. No tiene sentido operativo registrar pedidos sin artículos asociados, por lo que todo pedido debe contar con al menos una partida en Order_Items.
3. Ninguna operación de venta, actualización o devolución debe provocar que la cantidad disponible de un producto sea menor a cero.
4. Toda devolución debe referenciar un registro existente en Order_Items para garantizar la trazabilidad de los productos devueltos.
5. Un cliente puede devolver únicamente una parte de la cantidad comprada de un producto, sin necesidad de devolver la totalidad del pedido.

## Consultas estrella

1. ¿Qué pedidos siguen pendientes de pago o confirmación?
2. ¿Qué productos concentran más ventas brutas?
3. ¿Qué devoluciones afectan más a los ingresos netos?

## Entidades principales

- Customers
- Products
- Inventory
- Orders
- Order_Items
- Payments
- Returns
  
## Relaciones entre entidades de MercadoMax

| Entidad 1 | Entidad 2 | Cardinalidad | ¿Por qué? |
|-----------|-----------|--------------|-----------|
| `Customers` | `Orders` | **1 : N** | Un cliente puede realizar muchos pedidos, pero cada pedido pertenece únicamente a un cliente. |
| `Orders` | `Order_Items` | **1 : N** | Un pedido puede contener uno o varios productos. Pero cada registro de `Order_Items` representa un producto específico dentro del pedido. |
| `Products` | `Order_Items` | **1 : N** | Un producto puede venderse en muchos pedidos diferentes, pero cada registro de `Order_Items` hace referencia a un solo producto. |
| `Products` | `Inventory` | **1 : 1** | Cada producto tiene un único registro de inventario donde se controla la existencia disponible. |
| `Orders` | `Payments` | **1 : N** | Un pedido puede tener uno o varios registros de pago (por ejemplo, intentos fallidos, pagos confirmados o reembolsos), mientras que cada pago pertenece a un único pedido. |
| `Order_Items` | `Returns` | **1 : N** | Un artículo vendido puede generar una o varias devoluciones (por ejemplo, devoluciones parciales), pero cada devolución corresponde únicamente a un artículo específico del pedido. |

## Decision tecnica

Se modificó el modelo original para que la entidad `Returns` se relacione con la entidad `Order_Items` en lugar de `Orders`. De esta forma, cada devolución queda asociada a una línea específica del pedido, permitiendo registrar el producto devuelto, la cantidad y el monto reembolsado. Esta decisión mejora la integridad y la trazabilidad de la información, además de facilitar consultas relacionadas con devoluciones e ingresos netos.

## Limitaciones

El proyecto se centra únicamente en el control de pedidos, pagos, inventario y devoluciones, por lo que quedan fuera del alcance aspectos como:

- Registro de métodos de pago y pagos parciales.
- Gestión de envíos y seguimiento de entregas.
- Aplicación de descuentos, promociones e impuestos.
- Perfiles de Usuarios o compradores como gestion de sus cuentas