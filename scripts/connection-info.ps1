param()

@"
==================================================
Project Base - MercadoMax connection info
==================================================
Inside the devcontainer or from another container:
  host: postgres
  port: 5432
  database: advanced_databases
  user: developer
  password: developer
  url: postgresql://developer:developer@postgres:5432/advanced_databases

From Windows or your host machine:
  host: localhost
  port: 5432
  database: advanced_databases
  user: developer
  password: developer
  url: postgresql://developer:developer@localhost:5432/advanced_databases

Web client fallback:
  Adminer: http://localhost:8080
  system: PostgreSQL
  server: postgres
  user: developer
  password: developer
  database: advanced_databases
"@ | Write-Host
