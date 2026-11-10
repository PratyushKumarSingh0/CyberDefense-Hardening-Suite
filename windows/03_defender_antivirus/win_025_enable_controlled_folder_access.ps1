<#
.SYNOPSIS
    WIN-025: Enable Controlled Folder Access (Ransomware Guard)
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Ransomware Data Encryption, Unauthorized File Modifications (T1486)
    MITRE ATT&CK: T1486
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-025] Checking Controlled Folder Access (Anti-Ransomware)..." -ForegroundColor Cyan
$cfa = (Get-MpPreference -ErrorAction SilentlyContinue).EnableControlledFolderAccess

if ($cfa -eq 1) {
    Write-Host "[PASS] COMPLIANT: Controlled Folder Access is Enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Controlled Folder Access is inactive (State: $cfa)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-MpPreference -EnableControlledFolderAccess Enabled
    Write-Host "[PASS] REMEDIATED: Controlled Folder Access enabled." -ForegroundColor Green
    exit 0
}
