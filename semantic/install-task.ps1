#!/usr/bin/env pwsh
# Register a Windows Task Scheduler job that auto-reindexes the knowledge base.
# Run once:
#   pwsh knowledge-base/semantic/install-task.ps1                 # every 30 min
#   pwsh knowledge-base/semantic/install-task.ps1 -Minutes 15
# Remove:
#   Unregister-ScheduledTask -TaskName KB-Semantic-Reindex -Confirm:$false
param(
  [int]$Minutes = 30,
  [string]$TaskName = 'KB-Semantic-Reindex'
)
$ErrorActionPreference = 'Stop'

$runner = Join-Path $PSScriptRoot 'kb-reindex-task.ps1'
if (-not (Test-Path $runner)) { throw "Runner not found: $runner" }

# Prefer pwsh (PowerShell 7); fall back to Windows PowerShell.
$shell = (Get-Command pwsh -ErrorAction SilentlyContinue).Source
if (-not $shell) { $shell = (Get-Command powershell).Source }

$action = New-ScheduledTaskAction -Execute $shell `
  -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$runner`""

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) `
  -RepetitionInterval (New-TimeSpan -Minutes $Minutes) `
  -RepetitionDuration (New-TimeSpan -Days 3650)

$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable `
  -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Hours 1)

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger `
  -Settings $settings -Force `
  -Description 'Knowledge base auto-reindex (md-semantic-search, model bge-m3)' | Out-Null

Write-Host "Task '$TaskName' registered: runs every $Minutes min (current user, when logged on)."
Write-Host "Check:        Get-ScheduledTask -TaskName $TaskName"
Write-Host "Run now:      Start-ScheduledTask -TaskName $TaskName"
Write-Host "Log:          knowledge-base/semantic/.logs/reindex.log"
