<#
.SYNOPSIS
    WIN-011: Enable Windows Defender Credential Guard
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: LSASS Memory Dumping, Pass-the-Hash, Mimikatz (T1003.001)
    MITRE ATT&CK: T1003.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-011] Auditing Credential Guard status..." -ForegroundColor Cyan
$dg = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
$lsa = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

$vbs = (Get-ItemProperty -Path $dg -Name "EnableVirtualizationBasedSecurity" -ErrorAction SilentlyContinue).EnableVirtualizationBasedSecurity
$cg = (Get-ItemProperty -Path $lsa -Name "LsaCfgFlags" -ErrorAction SilentlyContinue).LsaCfgFlags

if ($vbs -eq 1 -and $cg -ge 1) {
    Write-Host "[PASS] COMPLIANT: Credential Guard and VBS are configured." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Credential Guard is not enabled (LsaCfgFlags: $cg, VBS: $vbs)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $dg -Name "EnableVirtualizationBasedSecurity" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $dg -Name "RequirePlatformSecurityFeatures" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $lsa -Name "LsaCfgFlags" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Credential Guard enabled. Note: Requires reboot and UEFI virtualization support." -ForegroundColor Green
    exit 0
}
