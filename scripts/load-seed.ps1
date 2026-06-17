param()

$DatabaseUrl = if ($env:DATABASE_URL) {
  $env:DATABASE_URL
} else {
  'postgresql://developer:developer@postgres:5432/advanced_databases'
}

& psql $DatabaseUrl -f /workspace/session/schema/seed.sql
exit $LASTEXITCODE
