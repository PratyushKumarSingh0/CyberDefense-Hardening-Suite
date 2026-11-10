<#
.SYNOPSIS
    WIN-007: Disable Web Proxy Auto-Discovery (WPAD)
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: WPAD Poisoning & MITM Web Traffic Interception (T1557)
    MITRE ATT&CK: T1557
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-007] Checking WPAD registry setting..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp"
$wpad = (Get-ItemProperty -Path $reg -Name "DisableWpad" -ErrorAction SilentlyContinue).DisableWpad

if ($wpad -eq 1) {
    Write-Host "[PASS] COMPLIANT: WPAD is disabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: WPAD is enabled or not explicitly blocked." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "DisableWpad" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: WPAD disabled in WinHttp." -ForegroundColor Green
    exit 0
}
