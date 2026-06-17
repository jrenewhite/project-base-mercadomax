#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
actual_dir="$repo_root/actual"
report_file="$actual_dir/sanity-check.txt"
database_url="${DATABASE_URL:-postgresql://developer:developer@postgres:5432/advanced_databases}"

mkdir -p "$actual_dir"

table_count="$(psql "$database_url" -At -c "select count(*) from pg_tables where schemaname = 'public';")"
if [[ "$table_count" -lt 3 ]]; then
  echo "ERROR: se esperaban al menos 3 tablas en public." >&2
  exit 1
fi

{
  echo "Sanity check OK"
  echo "Tables in public: $table_count"
  echo
  echo "Table list:"
  psql "$database_url" -At -F ' | ' -c "select tablename from pg_tables where schemaname = 'public' order by tablename;"
} > "$report_file"

echo "OK: sanity report -> $report_file"
