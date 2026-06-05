#!/usr/bin/env pwsh
# Semantic search over the knowledge base via md-semantic-search (mdss).
# Run:  pwsh knowledge-base/semantic/kb-search.ps1 "query" [extra mdss flags]
# Examples:
#   ./kb-search.ps1 "how to roll back a failed migration"
#   ./kb-search.ps1 "rollback failed migration" --k 8 --json
#   ./kb-search.ps1 "topic" --semantic       # vector-only ranking
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)] [string]$Query,
  [Parameter(ValueFromRemainingArguments = $true)] [string[]]$Rest
)
$ErrorActionPreference = 'Stop'

$KB = Split-Path -Parent $PSScriptRoot
$IndexDir = Join-Path $PSScriptRoot '.mdss'
$CacheDir = Join-Path $PSScriptRoot '.cache'

function Invoke-Mdss([string[]]$MdssArgs) {
  if (Get-Command mdss -ErrorAction SilentlyContinue) { & mdss @MdssArgs }
  else { & npx -y md-semantic-search @MdssArgs }
}

$mdssArgs = @('search', '--db', $KB, '--index-dir', $IndexDir, '--cache-dir', $CacheDir, $Query) + $Rest
Invoke-Mdss $mdssArgs
