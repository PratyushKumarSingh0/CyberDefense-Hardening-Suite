<#
.SYNOPSIS
    WIN-043: Enable Centralized PowerShell Session Transcription
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Interactive Attacker Shell Actions, Non-Repudiation (T1059.001)
    MITRE ATT&CK: T1059.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-043] Checking PowerShell Transcription logging..." -ForegroundColor Cyan
$reg = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$val = (Get-ItemProperty -Path $reg -Name "EnableTranscripting" -ErrorAction SilentlyContinue).EnableTranscripting

if ($val -eq 1) {
    Write-Host "[PASS] COMPLIANT: PowerShell Transcription is active." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] NOTICE: PowerShell Transcription is inactive." -ForegroundColor Yellow
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    $outDir = "C:\ProgramData\PSTranscripts"
    if (-not (Test-Path $outDir)) { New-Item -Path $outDir -ItemType Directory -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "EnableTranscripting" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $reg -Name "OutputDirectory" -Value $outDir -Type String -Force
    Set-ItemProperty -Path $reg -Name "EnableInvocationHeader" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Transcription logging enabled to $outDir." -ForegroundColor Green
    exit 0
}
