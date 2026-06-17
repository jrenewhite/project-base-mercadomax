param()

$RepoRoot = Resolve-Path (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) '..')
$ActualDir = Join-Path $RepoRoot 'actual'
$ReportFile = Join-Path $ActualDir 'sanity-check.txt'
$DatabaseUrl = if ($env:DATABASE_URL) {
  $env:DATABASE_URL
} else {
  'postgresql://developer:developer@postgres:5432/advanced_databases'
}

New-Item -ItemType Directory -Force -Path $ActualDir | Out-Null

$TableCount = (& psql $DatabaseUrl -At -c "select count(*) from pg_tables where schemaname = 'public';").Trim()
if ([int]$TableCount -lt 3) {
  Write-Host "ERROR: se esperaban al menos 3 tablas en public." -ForegroundColor Red
  exit 1
}

$TableList = & psql $DatabaseUrl -At -F " | " -c "select tablename from pg_tables where schemaname = 'public' order by tablename;"
@(
  "Sanity check OK"
  "Tables in public: $TableCount"
  ""
  "Table list:"
  $TableList
) | Set-Content -Encoding UTF8 $ReportFile

Write-Host "OK: sanity report -> $ReportFile"
