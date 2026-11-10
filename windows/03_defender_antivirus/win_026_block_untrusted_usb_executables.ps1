<#
.SYNOPSIS
    WIN-026: Block Executable Execution from Removable USB Storage
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: BadUSB, Worms, Malicious Autorun Executables (T1091, T1200)
    MITRE ATT&CK: T1091, T1200
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-026] Auditing Removable Storage Execution Policy..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}"
$val = (Get-ItemProperty -Path $reg -Name "Deny_Execute" -ErrorAction SilentlyContinue).Deny_Execute

if ($val -eq 1) {
    Write-Host "[PASS] COMPLIANT: Execution from removable disk storage is blocked." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Execution from removable storage is currently allowed." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "Deny_Execute" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Removable storage execution denied." -ForegroundColor Green
    exit 0
}
