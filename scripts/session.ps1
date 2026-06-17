Param(
  [Parameter(Position = 0)]
  [string]$Command
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir '..')
$ComposeFile = Join-Path $RepoRoot 'docker-compose.yml'
$DatabaseUrl = if ($env:DATABASE_URL) {
  $env:DATABASE_URL
} else {
  'postgresql://developer:developer@postgres:5432/advanced_databases'
}

function Invoke-Compose {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Args
  )

  & docker compose -f $ComposeFile @Args
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}

function Show-Usage {
  @"
Uso:
  .\scripts\session.ps1 up
  .\scripts\session.ps1 down
  .\scripts\session.ps1 reset
  .\scripts\session.ps1 seed
  .\scripts\session.ps1 psql
  .\scripts\session.ps1 test
"@ | Write-Host
  exit 1
}

switch ($Command) {
  'up' {
    Invoke-Compose up -d --build
  }
  'down' {
    Invoke-Compose down
  }
  'reset' {
    Invoke-Compose down -v
    Invoke-Compose up -d --build
  }
  'seed' {
    Invoke-Compose exec -T workspace psql $DatabaseUrl -f /workspace/session/schema/seed.sql
  }
  'psql' {
    Invoke-Compose exec -it workspace psql $DatabaseUrl
  }
  'test' {
    Invoke-Compose exec -T workspace pwsh -NoLogo -NoProfile -File /workspace/session/scripts/run-sanity-check.ps1
  }
  default {
    Show-Usage
  }
}
