<#
.SYNOPSIS
    WIN-039: Audit SmartCard / Windows Hello MFA Policy
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Credential Replay, Stolen Password Authentication (T1078)
    MITRE ATT&CK: T1078
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-039] Checking Windows Hello / SmartCard configuration..." -ForegroundColor Cyan
$ngcPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"
$enabled = (Get-ItemProperty -Path $ngcPath -Name "Enabled" -ErrorAction SilentlyContinue).Enabled

if ($enabled -eq 1) {
    Write-Host "[PASS] COMPLIANT: Windows Hello for Business policy is enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Enterprise Windows Hello policy not explicitly configured." -ForegroundColor Yellow
    exit 0
}
