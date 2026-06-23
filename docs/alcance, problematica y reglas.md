# MercadoMax - Alcance y Principal Problematica

## Problematica resumida

MercadoMax enfrenta dificultades para dar seguimiento eficiente a sus operaciones debido a que la información de pedidos, pagos, inventario y devoluciones se encuentra dispersa y sin una estructura integrada. 
Esto provoca que la empresa no pueda identificar fácilmente los pedidos pendientes, los productos que generan mayores ingresos, el impacto de las devoluciones en las ventas ni los niveles de inventario disponibles. 
Como resultado, la toma de decisiones se vuelve más lenta y menos confiable.

## Alcance elegido

El proyecto se enfocara en diseñar una base de datos que pueda resolver parte de estas problematicas y poder responder las principales preguntas de dicho proyecto y para ello nos centraremos en que se puedan responder estas preguntas:

1. ¿Qué pedidos siguen pendientes de pago o confirmación?
2. ¿Qué productos tienen inventario disponible bajo?
3. ¿Qué pedidos ya pagados todavía no deberían cerrarse por falta de inventario? <--- DUDAS
4. ¿Qué productos concentran más ventas brutas?
5. ¿Qué devoluciones afectan más a los ingresos netos?
6. ¿Qué clientes acumulan más pedidos cancelados o devueltos?

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