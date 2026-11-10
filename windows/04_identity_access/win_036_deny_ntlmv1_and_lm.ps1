<#
.SYNOPSIS
    WIN-036: Restrict NTLM Authentication to NTLMv2 Only (LmCompatibilityLevel 5)
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: NTLM Hash Cracking, Rainbow Table Attacks, SMB Relaying (T1557.001)
    MITRE ATT&CK: T1557.001, T1110.002
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-036] Auditing LmCompatibilityLevel..." -ForegroundColor Cyan
$lsa = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$level = (Get-ItemProperty -Path $lsa -Name "LmCompatibilityLevel" -ErrorAction SilentlyContinue).LmCompatibilityLevel

# 5 = Send NTLMv2 response only. Refuse LM & NTLM
if ($level -eq 5) {
    Write-Host "[PASS] COMPLIANT: NTLMv2 is strictly enforced." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: LmCompatibilityLevel is $level (Allows weaker LM/NTLMv1)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $lsa -Name "LmCompatibilityLevel" -Value 5 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Set LmCompatibilityLevel to 5." -ForegroundColor Green
    exit 0
}
