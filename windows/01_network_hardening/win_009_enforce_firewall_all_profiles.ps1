<#
.SYNOPSIS
    WIN-009: Enforce Windows Defender Firewall on All Profiles
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: Unauthorized Network Probing & Malware C2 Ingress (T1046, T1562.004)
    MITRE ATT&CK: T1562.004
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-009] Verifying Windows Firewall on Domain, Private, Public profiles..." -ForegroundColor Cyan
$profiles = Get-NetFirewallProfile
$disabled = $profiles | Where-Object { $_.Enabled -ne $true }

if ($disabled.Count -gt 0) {
    Write-Host "[!] VULNERABLE: The following firewall profiles are disabled: $($disabled.Name -join ', ')" -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow
    Write-Host "[PASS] REMEDIATED: All firewall profiles enabled with default inbound block." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[PASS] COMPLIANT: All firewall profiles are enabled." -ForegroundColor Green
    exit 0
}
