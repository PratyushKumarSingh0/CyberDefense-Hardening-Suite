<#
.SYNOPSIS
    WIN-030: Emergency Endpoint Network Isolation Script
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Active Incident Response, Lateral Movement Containment, Exfiltration (T1021, T1041)
    MITRE ATT&CK: T1021, T1041
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param (
    [switch]$Isolate,
    [switch]$Restore
)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-030] Emergency Network Isolation Utility" -ForegroundColor Cyan
$ruleName = "EMERGENCY_INCIDENT_NETWORK_ISOLATION"

if ($Restore) {
    Remove-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    Write-Host "[PASS] Endpoint network isolation rule removed. Normal connectivity restored." -ForegroundColor Green
    exit 0
}

if ($Isolate) {
    Write-Host "[!] ISOLATING ENDPOINT: Severing inbound and outbound connections..." -ForegroundColor Red
    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Action Block -Profile Any -Description "Emergency containment isolation" | Out-Null
    New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Action Block -Profile Any -Description "Emergency containment isolation" | Out-Null
    Write-Host "[PASS] Endpoint isolated from network. Use -Restore to revert." -ForegroundColor Yellow
    exit 0
}

Write-Host "Usage: .\win_030_isolate_compromised_endpoint.ps1 -Isolate | -Restore" -ForegroundColor Yellow
