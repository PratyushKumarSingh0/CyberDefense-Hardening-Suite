<#
.SYNOPSIS
    WIN-006: Enforce Network Level Authentication (NLA) for RDP
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: BlueKeep (CVE-2019-0708), Pre-Auth RDP Exploitation, Brute Force (T1021.001)
    MITRE ATT&CK: T1021.001, T1190
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-006] Checking RDP Network Level Authentication (NLA)..." -ForegroundColor Cyan
$reg = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
$nla = (Get-ItemProperty -Path $reg -Name "UserAuthentication" -ErrorAction SilentlyContinue).UserAuthentication

if ($nla -eq 1) {
    Write-Host "[PASS] COMPLIANT: RDP Network Level Authentication is enforced." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: RDP accepts pre-authentication connections without NLA." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $reg -Name "UserAuthentication" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: NLA for RDP is now enforced." -ForegroundColor Green
    exit 0
}
