<#
.SYNOPSIS
    WIN-028: Enable Heuristic and Behavior Monitoring
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Zero-Day Malware, Polymorphic Payloads, Obfuscated Threats (T1027)
    MITRE ATT&CK: T1027
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-028] Auditing Behavior Monitoring..." -ForegroundColor Cyan
$bm = (Get-MpPreference -ErrorAction SilentlyContinue).DisableBehaviorMonitoring

if ($bm -eq $false) {
    Write-Host "[PASS] COMPLIANT: Behavior Monitoring is active." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Behavior Monitoring is disabled." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-MpPreference -DisableBehaviorMonitoring $false
    Write-Host "[PASS] REMEDIATED: Behavior monitoring has been re-enabled." -ForegroundColor Green
    exit 0
}
