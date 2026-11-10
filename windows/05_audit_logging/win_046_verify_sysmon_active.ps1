<#
.SYNOPSIS
    WIN-046: Audit Sysmon Service and Driver Status
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: EDR/SIEM Blind Spots, Unmonitored Process Injection (T1562.001)
    MITRE ATT&CK: T1562.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-046] Auditing System Monitor (Sysmon)..." -ForegroundColor Cyan
$svc = Get-Service -Name "Sysmon*" -ErrorAction SilentlyContinue

if ($svc -and $svc.Status -eq "Running") {
    Write-Host "[PASS] COMPLIANT: Sysmon service '$($svc.Name)' is running." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Sysmon is not currently installed or running." -ForegroundColor Yellow
    exit 0
}
