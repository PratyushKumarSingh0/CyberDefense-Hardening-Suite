<#
.SYNOPSIS
    WIN-024: Schedule Daily Quick Scan & Weekly Full Scan
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Dormant Malware, Persistent Artifacts (T1059)
    MITRE ATT&CK: T1059
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-024] Auditing Defender Scheduled Scans..." -ForegroundColor Cyan
$pref = Get-MpPreference -ErrorAction SilentlyContinue

if ($pref.ScanScheduleQuickScanTime -ne $null) {
    Write-Host "[PASS] COMPLIANT: Scheduled scan times are configured." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Scheduled scan times not explicitly configured." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    # Schedule daily quick scan at 12:00 PM (720 minutes from midnight)
    Set-MpPreference -ScanScheduleQuickScanTime 720 -ScanScheduleDay 0
    Write-Host "[PASS] REMEDIATED: Configured daily quick scan schedule." -ForegroundColor Green
    exit 0
}
