<#
.SYNOPSIS
    WIN-021: Enforce Windows Defender Real-Time Protection & Script Scanning
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Malware Execution, AV Evasion (T1562.001, T1204)
    MITRE ATT&CK: T1562.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-021] Auditing Defender Real-Time Protection..." -ForegroundColor Cyan
$pref = Get-MpPreference -ErrorAction SilentlyContinue

if ($pref.DisableRealtimeMonitoring -eq $false -and $pref.DisableScriptScanning -eq $false) {
    Write-Host "[PASS] COMPLIANT: Real-Time Protection and Script Scanning are active." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Real-Time Monitoring or Script Scanning is disabled." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-MpPreference -DisableRealtimeMonitoring $false -DisableScriptScanning $false -DisableIOAVProtection $false
    Write-Host "[PASS] REMEDIATED: Re-enabled Real-Time Monitoring, Script Scanning, and IOAV." -ForegroundColor Green
    exit 0
}
