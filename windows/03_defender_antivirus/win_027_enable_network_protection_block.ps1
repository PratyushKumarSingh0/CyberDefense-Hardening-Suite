<#
.SYNOPSIS
    WIN-027: Enable Windows Defender Network Protection in Block Mode
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Phishing Domains, Malware Command and Control (C2) Callbacks (T1071, T1566)
    MITRE ATT&CK: T1071, T1566
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-027] Checking Defender Network Protection state..." -ForegroundColor Cyan
$np = (Get-MpPreference -ErrorAction SilentlyContinue).EnableNetworkProtection

if ($np -eq 1) {
    Write-Host "[PASS] COMPLIANT: Network Protection is active in Block mode." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Network Protection is disabled or in audit mode (Value: $np)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-MpPreference -EnableNetworkProtection Enabled
    Write-Host "[PASS] REMEDIATED: Set EnableNetworkProtection to Enabled." -ForegroundColor Green
    exit 0
}
