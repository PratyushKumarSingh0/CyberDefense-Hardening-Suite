<#
.SYNOPSIS
    WIN-016: Enforce RemoteSigned or AllSigned Execution Policy
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Untrusted Script Execution, Obfuscated Phishing Payloads (T1059.001)
    MITRE ATT&CK: T1059.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-016] Auditing LocalMachine PowerShell Execution Policy..." -ForegroundColor Cyan
$policy = Get-ExecutionPolicy -Scope LocalMachine

if ($policy -in @("AllSigned", "RemoteSigned", "Restricted")) {
    Write-Host "[PASS] COMPLIANT: LocalMachine ExecutionPolicy is '$policy'." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: LocalMachine ExecutionPolicy is '$policy' (Allows unsigned remote scripts)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
    Write-Host "[PASS] REMEDIATED: LocalMachine ExecutionPolicy set to RemoteSigned." -ForegroundColor Green
    exit 0
}
