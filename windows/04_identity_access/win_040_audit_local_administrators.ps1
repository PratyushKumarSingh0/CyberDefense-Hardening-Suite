<#
.SYNOPSIS
    WIN-040: Audit Local Administrators Group for Rogue Accounts
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Local Privilege Persistence, Rogue Admin Accounts (T1098, T1078.003)
    MITRE ATT&CK: T1098, T1078.003
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-040] Auditing members of local Administrators group..." -ForegroundColor Cyan
$admins = Get-LocalGroupMember -Group "Administrators"

Write-Host "[*] Current Local Administrators:" -ForegroundColor Cyan
foreach ($a in $admins) {
    Write-Host " -> $($a.Name) (Principal: $($a.PrincipalSource), Class: $($a.ObjectClass))" -ForegroundColor Yellow
}

if ($admins.Count -gt 2) {
    Write-Host "[!] NOTICE: More than 2 local administrators detected. Verify authorization." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
} else {
    Write-Host "[PASS] Local Administrator count is within baseline." -ForegroundColor Green
    exit 0
}
