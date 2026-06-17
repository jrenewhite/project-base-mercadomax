# Scripts

Estos scripts ayudan a levantar el starter kit, recargar datos y comprobar que el entorno mínimo funciona.

## Dentro del devcontainer

Lo más común es usar:

```bash
connection-info
check
sanity-check
```

## Fuera del devcontainer

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

## Qué hace el sanity check

- confirma que la base responde
- confirma que existen varias tablas públicas
- genera `actual/sanity-check.txt`

No valida la solución del proyecto final. Solo comprueba que el starter kit quedó utilizable.
