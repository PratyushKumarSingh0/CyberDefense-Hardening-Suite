<#
.SYNOPSIS
    WIN-031: Enforce Minimum Password Length and History
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Password Spraying, Dictionary Attacks, Weak Credentials (T1110)
    MITRE ATT&CK: T1110
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-031] Auditing Local Password Policy..." -ForegroundColor Cyan
$accounts = net accounts

if ($AuditOnly) {
    Write-Host "$accounts" -ForegroundColor Gray
    exit 0
}

Write-Host "[*] Configuring baseline password policy (Min length 14, history 12)..." -ForegroundColor Yellow
net accounts /minpwlen:14 /uniquepw:12 /maxpwage:90 /minpwage:1 | Out-Null
Write-Host "[PASS] REMEDIATED: Updated local password policy baseline." -ForegroundColor Green
exit 0
