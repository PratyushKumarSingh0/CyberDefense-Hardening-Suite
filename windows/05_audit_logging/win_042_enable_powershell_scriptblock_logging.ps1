<#
.SYNOPSIS
    WIN-042: Enable Deep PowerShell Script Block Logging (Event 4104)
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Obfuscated PowerShell, In-Memory Attack Scripting (T1059.001, T1027)
    MITRE ATT&CK: T1059.001, T1027
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-042] Checking PowerShell Script Block Logging..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$val = (Get-ItemProperty -Path $reg -Name "EnableScriptBlockLogging" -ErrorAction SilentlyContinue).EnableScriptBlockLogging

if ($val -eq 1) {
    Write-Host "[PASS] COMPLIANT: Script Block Logging is enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Script Block Logging is disabled (blind to in-memory scripts)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "EnableScriptBlockLogging" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Enabled ScriptBlockLogging." -ForegroundColor Green
    exit 0
}
