#!/usr/bin/env pwsh
# Index the knowledge base via md-semantic-search (mdss).
# Run from anywhere:  pwsh knowledge-base/semantic/kb-index.ps1 [extra mdss flags]
# Default model for this base is bge-m3 (best cross-lingual quality).
# Override:  ./kb-index.ps1 --model e5-base   (trailing flag wins over default)
[CmdletBinding()]
param([Parameter(ValueFromRemainingArguments = $true)] [string[]]$Rest)
$ErrorActionPreference = 'Stop'

$KB = Split-Path -Parent $PSScriptRoot          # parent of semantic/ = knowledge-base/ root
$IndexDir = Join-Path $PSScriptRoot '.mdss'     # index stored in semantic/.mdss
$CacheDir = Join-Path $PSScriptRoot '.cache'    # single model cache (self-contained)
$Model = if ($env:MDSS_MODEL) { $env:MDSS_MODEL } else { 'bge-m3' }

function Invoke-Mdss([string[]]$MdssArgs) {
  if (Get-Command mdss -ErrorAction SilentlyContinue) { & mdss @MdssArgs }
  else { & npx -y md-semantic-search @MdssArgs }
}

# Exclude service folders semantic/ and templates/; dot-dirs are skipped by mdss itself.
# $Rest is appended last so a user --model overrides the default (last flag wins).
$mdssArgs = @('index', '--db', $KB, '--index-dir', $IndexDir, '--cache-dir', $CacheDir,
              '--model', $Model, '--ignore', 'semantic/**', '--ignore', 'templates/**') + $Rest
Invoke-Mdss $mdssArgs
