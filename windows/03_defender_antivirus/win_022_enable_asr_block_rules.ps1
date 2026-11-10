<#
.SYNOPSIS
    WIN-022: Enforce Attack Surface Reduction (ASR) Rules in Block Mode
.DESCRIPTION
    Category: 03_defender_antivirus
    Threat Prevented: Office Child Process Spawning, LSASS Credential Theft, Ransomware (T1059, T1003)
    MITRE ATT&CK: T1059, T1003.001, T1486
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-022] Auditing Defender Attack Surface Reduction (ASR) rules..." -ForegroundColor Cyan

# Core ASR Rule GUIDs
# D4F940AB-401B-4EFC-AADC-AD5F3C50688A: Block child processes from Office
# 9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2: Block credential stealing from LSASS
# 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84: Block process creation from PSExec/WMI
$asrRules = @(
    "D4F940AB-401B-4EFC-AADC-AD5F3C50688A",
    "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2",
    "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84"
)

if ($AuditOnly) {
    $current = (Get-MpPreference).AttackSurfaceReductionRules_Ids
    Write-Host "[AUDIT] Current configured ASR rule count: $($current.Count)" -ForegroundColor Cyan
    exit 0
}

foreach ($rule in $asrRules) {
    Add-MpPreference -AttackSurfaceReductionRules_Ids $rule -AttackSurfaceReductionRules_Actions Enabled
}
Write-Host "[PASS] REMEDIATED: Configured primary ASR rules in Block (Enabled) mode." -ForegroundColor Green
exit 0
