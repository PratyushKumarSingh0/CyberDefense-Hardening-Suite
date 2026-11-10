<#
.SYNOPSIS
    WIN-033: Disable Built-in Guest Account
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Unauthenticated Local Access, Privilege Escalation (T1078.001)
    MITRE ATT&CK: T1078.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-033] Checking built-in Guest account status..." -ForegroundColor Cyan
$guest = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue

if ($guest -and $guest.Enabled -eq $false) {
    Write-Host "[PASS] COMPLIANT: Guest account is disabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Guest account is enabled or active." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Disable-LocalUser -Name "Guest"
    Write-Host "[PASS] REMEDIATED: Guest account has been disabled." -ForegroundColor Green
    exit 0
}
