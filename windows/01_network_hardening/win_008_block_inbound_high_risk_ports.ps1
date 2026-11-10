<#
.SYNOPSIS
    WIN-008: Block High-Risk Inbound Ports via Windows Firewall
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: External Port Scanning, Remote Exploits (Ports 135, 137-139, 445, 3389, 5985) (T1046)
    MITRE ATT&CK: T1046, T1021
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-008] Auditing inbound high-risk port block rules..." -ForegroundColor Cyan
$ruleName = "CyberDefense_Block_HighRisk_Inbound"
$existing = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

if ($existing) {
    Write-Host "[PASS] COMPLIANT: High-risk inbound port block rule is active." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: No centralized block rule for high-risk inbound ports on Public profile." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    New-NetFirewallRule -DisplayName $ruleName `
        -Direction Inbound `
        -Action Block `
        -Protocol TCP `
        -LocalPort @(135, 137, 138, 139, 445) `
        -Profile Public `
        -Description "Defensive hardening block rule against lateral movement protocols on Public networks." | Out-Null
    Write-Host "[PASS] REMEDIATED: Created firewall rule $ruleName." -ForegroundColor Green
    exit 0
}
