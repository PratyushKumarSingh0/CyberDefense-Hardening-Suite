<#
.SYNOPSIS
    WIN-012: Enable Hypervisor-Enforced Code Integrity (HVCI)
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Kernel Rootkits, Unsigned Malicious Driver Loading (T1068, T1542.003)
    MITRE ATT&CK: T1068, T1542.003
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-012] Checking HVCI Memory Integrity..." -ForegroundColor Cyan
$hvciPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
$enabled = (Get-ItemProperty -Path $hvciPath -Name "Enabled" -ErrorAction SilentlyContinue).Enabled

if ($enabled -eq 1) {
    Write-Host "[PASS] COMPLIANT: HVCI Memory Integrity is enabled." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: HVCI Memory Integrity is disabled." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $hvciPath)) { New-Item -Path $hvciPath -Force | Out-Null }
    Set-ItemProperty -Path $hvciPath -Name "Enabled" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Enabled HVCI Memory Integrity (Reboot required)." -ForegroundColor Green
    exit 0
}
