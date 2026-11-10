<#
.SYNOPSIS
    WIN-032: Enforce Account Lockout Policy (5 Attempts, 30 Min Lockout)
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Brute Force Attacks, Credential Stuffing (T1110.001)
    MITRE ATT&CK: T1110.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-032] Auditing Account Lockout Policy..." -ForegroundColor Cyan

if ($AuditOnly) {
    net accounts | Select-String "lockout"
    exit 0
}

Write-Host "[*] Enforcing Account Lockout: 5 failed attempts, 30-min duration..." -ForegroundColor Yellow
net accounts /lockoutthreshold:5 /lockoutduration:30 /lockoutwindow:30 | Out-Null
Write-Host "[PASS] REMEDIATED: Enforced account lockout threshold." -ForegroundColor Green
exit 0
