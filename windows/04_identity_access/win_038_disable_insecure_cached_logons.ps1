<#
.SYNOPSIS
    WIN-038: Limit Cached Domain Credentials (CachedLogonsCount)
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: DCC2 / mscache2 Offline Password Hash Extraction (T1003.002)
    MITRE ATT&CK: T1003.002
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-038] Checking CachedLogonsCount..." -ForegroundColor Cyan
$winlogon = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$val = (Get-ItemProperty -Path $winlogon -Name "CachedLogonsCount" -ErrorAction SilentlyContinue).CachedLogonsCount

if ($val -ne $null -and [int]$val -le 2) {
    Write-Host "[PASS] COMPLIANT: CachedLogonsCount is restricted ($val)." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: CachedLogonsCount is set to $val (Default is 10)." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $winlogon -Name "CachedLogonsCount" -Value "2" -Type String -Force
    Write-Host "[PASS] REMEDIATED: Reduced CachedLogonsCount to 2." -ForegroundColor Green
    exit 0
}
