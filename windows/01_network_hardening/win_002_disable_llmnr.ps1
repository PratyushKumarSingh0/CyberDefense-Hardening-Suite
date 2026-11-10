<#
.SYNOPSIS
    WIN-002: Disable Link-Local Multicast Name Resolution (LLMNR)
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: LLMNR / NBT-NS Poisoning, Responder Credential Interception (T1557.001)
    MITRE ATT&CK: T1557.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-002] Checking LLMNR status..." -ForegroundColor Cyan
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"
$val = (Get-ItemProperty -Path $regPath -Name "EnableMulticast" -ErrorAction SilentlyContinue).EnableMulticast

if ($val -eq 0) {
    Write-Host "[PASS] COMPLIANT: LLMNR is disabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: LLMNR is active (allows hash capturing via Responder)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
    Set-ItemProperty -Path $regPath -Name "EnableMulticast" -Value 0 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: LLMNR has been disabled." -ForegroundColor Green
    exit 0
}
