<#
.SYNOPSIS
    WIN-018: Disable Windows Script Host (WSH)
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: VBScript, JScript, WSF Malware Droppers (T1059.005, T1059.007)
    MITRE ATT&CK: T1059.005, T1059.007
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-018] Checking Windows Script Host (WSH) status..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings"
$val = (Get-ItemProperty -Path $reg -Name "Enabled" -ErrorAction SilentlyContinue).Enabled

if ($val -eq 0) {
    Write-Host "[PASS] COMPLIANT: Windows Script Host is disabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Windows Script Host is enabled (executes .vbs/.js directly)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "Enabled" -Value 0 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Windows Script Host has been disabled." -ForegroundColor Green
    exit 0
}
