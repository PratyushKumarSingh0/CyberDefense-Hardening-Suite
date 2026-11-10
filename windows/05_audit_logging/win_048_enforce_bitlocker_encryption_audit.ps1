<#
.SYNOPSIS
    WIN-048: Audit BitLocker Full-Disk Encryption Status
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Physical Theft, Offline Data Extraction, Unencrypted Drives (T1200)
    MITRE ATT&CK: T1200
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-048] Checking BitLocker status on OS drive..." -ForegroundColor Cyan
$vol = Get-BitLockerVolume -MountPoint $env:SystemDrive -ErrorAction SilentlyContinue

if ($vol -and $vol.ProtectionStatus -eq "On") {
    Write-Host "[PASS] COMPLIANT: BitLocker protection is ON for $env:SystemDrive (Method: $($vol.EncryptionMethod))." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: BitLocker is NOT enabled or fully protected on $env:SystemDrive." -ForegroundColor Red
    exit 1
}
