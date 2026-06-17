param()

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir '..')
$ComposeFile = Join-Path $RepoRoot 'docker-compose.yml'

& docker compose -f $ComposeFile down -v
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

& docker compose -f $ComposeFile up -d --build
exit $LASTEXITCODE
