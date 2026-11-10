<#
.SYNOPSIS
    WIN-019: Disable Legacy PowerShell Version 2.0
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: AMSI Bypass, Logging Evasion via Version Downgrade Attacks (T1562.001)
    MITRE ATT&CK: T1562.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-019] Checking PowerShell v2 feature state..." -ForegroundColor Cyan
$feat = Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -ErrorAction SilentlyContinue

if ($feat -and $feat.State -eq "Disabled") {
    Write-Host "[PASS] COMPLIANT: PowerShell v2 is disabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: PowerShell v2 is installed/enabled (lacks modern AMSI & logging)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -NoRestart | Out-Null
    Write-Host "[PASS] REMEDIATED: Disabled PowerShell v2." -ForegroundColor Green
    exit 0
}
