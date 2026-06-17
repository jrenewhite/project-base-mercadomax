#!/usr/bin/env bash
set -euo pipefail

database_url="${DATABASE_URL:-postgresql://developer:developer@postgres:5432/advanced_databases}"

psql "$database_url" -f /workspace/session/schema/seed.sql
