<#
.SYNOPSIS
    WIN-023: Enable Potentially Unwanted Application (PUA) Protection
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Adware, Cryptominers, Bundled Toolbars, Spyware (T1496)
    MITRE ATT&CK: T1496
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-023] Auditing PUA/PUP protection state..." -ForegroundColor Cyan
$pua = (Get-MpPreference -ErrorAction SilentlyContinue).PUAProtection

# 1 = Enabled, 2 = AuditMode
if ($pua -eq 1) {
    Write-Host "[PASS] COMPLIANT: PUA Protection is active in Block mode." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: PUA Protection is not enforced (State: $pua)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-MpPreference -PUAProtection Enabled
    Write-Host "[PASS] REMEDIATED: Set PUAProtection to Enabled." -ForegroundColor Green
    exit 0
}
