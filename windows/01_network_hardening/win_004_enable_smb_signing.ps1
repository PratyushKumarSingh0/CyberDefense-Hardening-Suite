<#
.SYNOPSIS
    WIN-004: Enforce SMB Server & Client Packet Signing
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: SMB Relay Attacks, Man-in-the-Middle Spoofing (T1557)
    MITRE ATT&CK: T1557
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-004] Checking SMB packet signing requirements..." -ForegroundColor Cyan
$serverConfig = Get-SmbServerConfiguration
$clientConfig = Get-SmbClientConfiguration

$serverCompliant = $serverConfig.RequireSecuritySignature -eq $true
$clientCompliant = $clientConfig.RequireSecuritySignature -eq $true

if ($serverCompliant -and $clientCompliant) {
    Write-Host "[PASS] COMPLIANT: SMB signing is enforced on server and client." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: SMB Signing Server: $serverCompliant, Client: $clientCompliant" -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-SmbServerConfiguration -RequireSecuritySignature $true -Force
    Set-SmbClientConfiguration -RequireSecuritySignature $true -Force
    Write-Host "[PASS] REMEDIATED: Enforced SMB packet signing." -ForegroundColor Green
    exit 0
}
