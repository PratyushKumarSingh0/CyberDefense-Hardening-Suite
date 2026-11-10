<#
.SYNOPSIS
    WIN-044: Configure Security and System Event Log Maximum Capacity
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Log Clearing, Log Wrapping & Tampering (T1070.001)
    MITRE ATT&CK: T1070.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-044] Auditing Windows Event Log capacities..." -ForegroundColor Cyan
$secLog = Get-WinEvent -ListLog Security

# Enforce minimum 1GB (1073741824 bytes)
if ($secLog.MaximumSizeInBytes -ge 1073741824) {
    Write-Host "[PASS] COMPLIANT: Security log capacity is $([Math]::Round($secLog.MaximumSizeInBytes / 1MB)) MB." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Security log size is $([Math]::Round($secLog.MaximumSizeInBytes / 1MB)) MB (Risk of early overwrite)." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    Limit-EventLog -LogName Security -MaximumSize 1024MB -OverflowAction OverwriteAsNeeded
    Limit-EventLog -LogName System -MaximumSize 512MB -OverflowAction OverwriteAsNeeded
    Write-Host "[PASS] REMEDIATED: Increased Security (1024MB) and System (512MB) log capacities." -ForegroundColor Green
    exit 0
}
