<#
.SYNOPSIS
    WIN-050: Collect Autoruns and Persistence Triage Baseline Snapshot
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Persistence via Registry Run Keys, Startup Folders (T1547.001)
    MITRE ATT&CK: T1547.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param (
    [string]$OutputPath = "C:\ProgramData\CyberDefense_Autoruns_Snapshot.json"
)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-050] Collecting autorun persistence snapshot..." -ForegroundColor Cyan

$regRun = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)

$snapshot = @()
foreach ($r in $regRun) {
    if (Test-Path $r) {
        $props = Get-ItemProperty -Path $r
        $props.PSObject.Properties | Where-Object { $_.Name -notmatch "^PS" } | ForEach-Object {
            $snapshot += [PSCustomObject]@{
                Type = "RegistryRun"
                Location = $r
                Name = $_.Name
                Value = $_.Value
            }
        }
    }
}

$snapshot | ConvertTo-Json -Depth 3 | Set-Content -Path $OutputPath -Force
Write-Host "[PASS] Baseline snapshot saved to $OutputPath ($($snapshot.Count) persistence entries captured)." -ForegroundColor Green
exit 0
