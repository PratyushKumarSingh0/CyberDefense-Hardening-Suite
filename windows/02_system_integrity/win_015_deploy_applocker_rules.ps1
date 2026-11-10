<#
.SYNOPSIS
    WIN-015: Validate and Start AppLocker Application Identity Service
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Unauthorized Binary Execution, Ransomware Droppers in Temp/AppData (T1204.002)
    MITRE ATT&CK: T1204.002, T1059
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-015] Verifying Application Identity Service (AppIDSvc)..." -ForegroundColor Cyan
$svc = Get-Service -Name "AppIDSvc" -ErrorAction SilentlyContinue

if ($svc -and $svc.Status -eq "Running" -and $svc.StartType -eq "Automatic") {
    Write-Host "[PASS] COMPLIANT: AppIDSvc is configured for automatic startup and running." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: AppIDSvc is not running automatically (Status: $($svc.Status), StartType: $($svc.StartType))." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-Service -Name "AppIDSvc" -StartupType Automatic
    Start-Service -Name "AppIDSvc" -ErrorAction SilentlyContinue
    Write-Host "[PASS] REMEDIATED: Started AppIDSvc and set startup to Automatic." -ForegroundColor Green
    exit 0
}
