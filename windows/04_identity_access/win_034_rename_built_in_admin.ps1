<#
.SYNOPSIS
    WIN-034: Audit Built-in Administrator Account Name
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Automated Admin Brute Force & Credential Spraying (T1110)
    MITRE ATT&CK: T1110
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-034] Checking default Administrator account..." -ForegroundColor Cyan
$admin = Get-LocalUser | Where-Object { $_.SID.Value -like "*-500" }

if ($admin.Name -eq "Administrator") {
    Write-Host "[!] NOTICE: Built-in Administrator is still using default name 'Administrator'." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    Write-Host "[*] Recommendation: Use secpol.msc or group policy to rename built-in Administrator." -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "[PASS] COMPLIANT: Built-in Administrator account renamed to '$($admin.Name)'." -ForegroundColor Green
    exit 0
}
