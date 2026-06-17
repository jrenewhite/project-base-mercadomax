# Proyecto Base - MercadoMax

Starter kit local para el caso **MercadoMax** del proyecto final de **Sistemas Avanzados de Bases de Datos**.

## Empresa

MercadoMax es una tienda que necesita controlar pedidos, pagos, inventario y devoluciones sin perder consistencia operativa ni visibilidad de ventas.

## Qué incluye este starter kit

- entorno reproducible con PostgreSQL, workspace y Adminer
- README y TLDR con flujo operativo claro
- contexto de la empresa y alcance sugerido
- preguntas principales y reglas iniciales del negocio
- schema base útil pero incompleto
- seed pequeño para explorar el caso
- datos CSV de muestra
- plantilla de deliverables y reflexión

## Qué no incluye

Este repo **no** trae:

- solución final cerrada
- modelo completo resuelto
- app completa
- backend productivo
- frontend
- dashboard final
- defensa resuelta

La idea es ayudarte a arrancar, no decidir por ti.

## Quick Start para Windows

La forma recomendada es usar **VS Code + Dev Containers + Docker Desktop**.

### Prerrequisitos

- Docker Desktop abierto
- VS Code
- extensión `Dev Containers`
- Git

### Flujo recomendado

1. Clona este repo.
2. Ábrelo en VS Code.
3. Ejecuta `Dev Containers: Reopen in Container`.
4. Espera a que arranquen `postgres`, `workspace` y `adminer`.
5. Abre una terminal dentro del devcontainer.
6. Si limpiaste la pantalla, corre `connection-info`.
7. Lee primero:
   - `docs/company-context.md`
   - `docs/scope-and-focus.md`
   - `docs/main-questions.md`
   - `docs/business-rules.md`
8. Revisa `schema/initial_schema.sql` y `schema/seed.sql`.
9. Corre `check` para generar un sanity check.

## Cómo cargar schema y seed

El entorno carga automáticamente:

- `schema/initial_schema.sql`
- `schema/seed.sql`

cuando el stack arranca desde cero.

Si necesitas reiniciar todo:

```bash
./scripts/session.sh reset
```

Si solo quieres volver a aplicar el seed:

```bash
./scripts/session.sh seed
```

## Comandos útiles dentro del devcontainer

```bash
connection-info
check
sanity-check
psql postgresql://developer:developer@postgres:5432/advanced_databases
```

## Comandos útiles fuera del devcontainer

Bash:

```bash
./scripts/session.sh up
./scripts/session.sh reset
./scripts/session.sh seed
./scripts/session.sh psql
./scripts/session.sh test
```

PowerShell:

```powershell
.\scripts\session.ps1 up
.\scripts\session.ps1 reset
.\scripts\session.ps1 seed
.\scripts\session.ps1 psql
.\scripts\session.ps1 test
```

## Datos de conexión

Dentro del devcontainer:

- host: `postgres`
- port: `5432`
- database: `advanced_databases`
- user: `developer`
- password: `developer`

Desde Windows o fuera del contenedor:

- host: `localhost`
- port: `5432`
- database: `advanced_databases`
- user: `developer`
- password: `developer`

Cliente web opcional:

- Adminer: `http://localhost:8080`

## Qué debe construir el alumno

Este starter kit deja abiertas decisiones importantes. El alumno todavía debe:

- elegir el alcance final exacto
- ajustar o extender entidades
- definir relaciones faltantes
- completar restricciones útiles
- decidir consultas prioritarias
- justificar una decisión técnica real

## Decisiones que siguen abiertas

Ejemplos de decisiones no resueltas aquí:

- cómo modelar devoluciones con mayor detalle
- si conviene separar inventario por almacén o solo por producto
- qué reglas van en constraints y cuáles en procedimientos futuros
- qué consultas serán más críticas para el caso final

## Archivos clave

- `docs/company-context.md`
- `docs/scope-and-focus.md`
- `docs/main-questions.md`
- `docs/business-rules.md`
- `docs/checkpoint-guide.md`
- `schema/initial_schema.sql`
- `schema/seed.sql`
- `deliverables/README.md`
- `deliverables/REPORT.md`
