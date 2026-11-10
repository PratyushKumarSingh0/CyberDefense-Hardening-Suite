<#
.SYNOPSIS
    WIN-010: Block Anonymous SAM & Share Enumeration
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: Reconnaissance, Unauthenticated Domain/Workgroup User Enumeration (T1087.001)
    MITRE ATT&CK: T1087.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-010] Checking anonymous enumeration restrictions in LSA..." -ForegroundColor Cyan
$lsa = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$rSam = (Get-ItemProperty -Path $lsa -Name "RestrictAnonymousSAM" -ErrorAction SilentlyContinue).RestrictAnonymousSAM
$rAnon = (Get-ItemProperty -Path $lsa -Name "RestrictAnonymous" -ErrorAction SilentlyContinue).RestrictAnonymous

if ($rSam -eq 1 -and $rAnon -eq 1) {
    Write-Host "[PASS] COMPLIANT: Anonymous SAM & account enumeration is blocked." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Anonymous enumeration is permitted." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $lsa -Name "RestrictAnonymousSAM" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $lsa -Name "RestrictAnonymous" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Set RestrictAnonymousSAM=1 and RestrictAnonymous=1." -ForegroundColor Green
    exit 0
}
