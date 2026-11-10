<#
.SYNOPSIS
    WIN-041: Enable Process Creation Auditing with Command Line Logging (Event 4688)
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Living-off-the-Land Binaries (LOLBins), Stealth Execution (T1059, T1204)
    MITRE ATT&CK: T1059
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-041] Checking Process Creation Command Line auditing..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
$cmdLine = (Get-ItemProperty -Path $reg -Name "ProcessCreationIncludeCmdLine_Enabled" -ErrorAction SilentlyContinue).ProcessCreationIncludeCmdLine_Enabled

if ($cmdLine -eq 1) {
    Write-Host "[PASS] COMPLIANT: Command line inclusion in Event 4688 is enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Process command lines are not recorded in audit logs." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -Type DWord -Force
    auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable | Out-Null
    Write-Host "[PASS] REMEDIATED: Command line process auditing enabled." -ForegroundColor Green
    exit 0
}
