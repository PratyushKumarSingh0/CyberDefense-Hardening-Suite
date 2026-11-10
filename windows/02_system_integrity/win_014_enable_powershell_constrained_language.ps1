<#
.SYNOPSIS
    WIN-014: Enforce PowerShell Constrained Language Mode
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Fileless Malware, Reflective Assembly Loading, Malicious .NET Calls (T1059.001)
    MITRE ATT&CK: T1059.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-014] Checking PowerShell Language Mode..." -ForegroundColor Cyan

$currentMode = $ExecutionContext.SessionState.LanguageMode
if ($currentMode -eq "ConstrainedLanguage") {
    Write-Host "[PASS] COMPLIANT: Running in ConstrainedLanguage mode." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: System language mode is currently '$currentMode'." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    [Environment]::SetEnvironmentVariable("__PSLockdownPolicy", "4", "Machine")
    Write-Host "[PASS] REMEDIATED: Set __PSLockdownPolicy=4 to enforce Constrained Language Mode for unprivileged sessions." -ForegroundColor Green
    exit 0
}
