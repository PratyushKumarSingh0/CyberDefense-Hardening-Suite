<#
.SYNOPSIS
    WIN-045: Enable DNS Client Query Logging for C2 Domain Detection
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: DNS Tunneling, Fast-Flux, Malicious C2 Lookups (T1071.004)
    MITRE ATT&CK: T1071.004
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-045] Auditing DNS Client Operational Log..." -ForegroundColor Cyan
$log = Get-WinEvent -ListLog "Microsoft-Windows-DNS-Client/Operational" -ErrorAction SilentlyContinue

if ($log -and $log.IsEnabled -eq $true) {
    Write-Host "[PASS] COMPLIANT: DNS Client Operational query logging is active." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: DNS Client query logging is disabled." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    wevtutil sl "Microsoft-Windows-DNS-Client/Operational" /e:true | Out-Null
    Write-Host "[PASS] REMEDIATED: Enabled Microsoft-Windows-DNS-Client/Operational log." -ForegroundColor Green
    exit 0
}
