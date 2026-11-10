<#
.SYNOPSIS
    WIN-029: Update Defender Signatures & Enforce Signature Freshness
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Known Malware Campaigns, Vulnerability Exploitation (T1204)
    MITRE ATT&CK: T1204
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-029] Checking Defender signature age..." -ForegroundColor Cyan
$status = Get-MpComputerStatus -ErrorAction SilentlyContinue

$age = (New-TimeSpan -Start $status.AntivirusSignatureLastUpdated -End (Get-Date)).TotalHours
Write-Host "[INFO] Antivirus signatures last updated: $($status.AntivirusSignatureLastUpdated) ($([Math]::Round($age, 1)) hours ago)." -ForegroundColor Cyan

if ($age -lt 24) {
    Write-Host "[PASS] COMPLIANT: Signatures are up to date." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Signatures are older than 24 hours." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    Write-Host "[*] Triggering signature update..." -ForegroundColor Yellow
    Update-MpSignature
    Write-Host "[PASS] REMEDIATED: Signature update triggered." -ForegroundColor Green
    exit 0
}
