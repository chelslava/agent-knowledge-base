#!/usr/bin/env pwsh
# Auto-reindex runner for Windows Task Scheduler.
# Calls kb-index.ps1, appends a timestamped line to .logs/reindex.log. Quiet + idempotent.
# Registered by install-task.ps1; manual run: pwsh kb-reindex-task.ps1
$ErrorActionPreference = 'Stop'
$Here = $PSScriptRoot
$LogDir = Join-Path $Here '.logs'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$Log = Join-Path $LogDir 'reindex.log'
$ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

# UTF-8 without BOM, deterministic across PowerShell 5.1 and 7 (Add-Content uses
# the ANSI codepage on 5.1, which mangles non-ASCII like the "->" arrow in output).
$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Write-Log([string]$Text) {
  [System.IO.File]::AppendAllText($Log, $Text + "`r`n", $Utf8)
}

# Decode native-command (node/mdss) output as UTF-8 so non-ASCII (e.g. the "->"
# arrow) is captured correctly; otherwise PowerShell uses the OEM codepage and
# mangles it in memory before we ever write the file. Guarded for headless runs.
try { [Console]::OutputEncoding = $Utf8 } catch {}

# In the scheduler environment PATH may miss the npm global prefix; add it so
# kb-index.ps1 finds the global mdss instead of falling back to a heavy npx.
try {
  $npmPrefix = (& npm config get prefix 2>$null)
  if ($npmPrefix -and (Test-Path $npmPrefix)) { $env:PATH = "$npmPrefix;$env:PATH" }
} catch {}

try {
  $out = & (Join-Path $Here 'kb-index.ps1') 2>&1 | Out-String
  $line = ($out -split "`n" | Where-Object { $_ -match 'Indexed' } | Select-Object -Last 1)
  if ($line) { $line = $line.Trim() } else { $line = ($out.Trim() -replace '\s+', ' ') }
  Write-Log "[$ts] OK  $line"
} catch {
  Write-Log "[$ts] ERR $($_.Exception.Message)"
  exit 1
}

# Log rotation: keep the last 500 lines (rewrite as UTF-8 without BOM).
$all = @(Get-Content $Log -Encoding UTF8 -ErrorAction SilentlyContinue)
if ($all.Count -gt 500) {
  [System.IO.File]::WriteAllLines($Log, ($all | Select-Object -Last 500), $Utf8)
}
