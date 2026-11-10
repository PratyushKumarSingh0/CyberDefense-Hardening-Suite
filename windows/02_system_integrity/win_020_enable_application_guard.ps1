<#
.SYNOPSIS
    WIN-020: Verify Windows Defender Application Guard Availability
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Browser Zero-Days, Drive-by Downloads (T1189)
    MITRE ATT&CK: T1189
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-020] Checking Windows Defender Application Guard..." -ForegroundColor Cyan
$feat = Get-WindowsOptionalFeature -Online -FeatureName "Windows-Defender-ApplicationGuard" -ErrorAction SilentlyContinue

if ($feat -and $feat.State -eq "Enabled") {
    Write-Host "[PASS] COMPLIANT: Application Guard is installed and enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Application Guard feature state: $($feat.State)." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    Write-Host "[*] Application Guard requires hardware virtualization. Auditing complete." -ForegroundColor Yellow
    exit 0
}
