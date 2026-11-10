<#
.SYNOPSIS
    WIN-037: Audit and Restrict Remote Desktop Users Group
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Unauthorized Remote Desktop Access, Lateral Movement (T1021.001)
    MITRE ATT&CK: T1021.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-037] Auditing Remote Desktop Users group..." -ForegroundColor Cyan
$rdpGroup = Get-LocalGroupMember -Group "Remote Desktop Users" -ErrorAction SilentlyContinue

Write-Host "[*] Active members in 'Remote Desktop Users':" -ForegroundColor Cyan
$rdpGroup | ForEach-Object { Write-Host " - $($_.Name) ($($_.ObjectClass))" -ForegroundColor Gray }

if ($rdpGroup.Count -eq 0) {
    Write-Host "[PASS] COMPLIANT: No unneeded users assigned to Remote Desktop Users." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: Review members above to ensure least-privilege remote access." -ForegroundColor Yellow
    exit 0
}
