<#
.SYNOPSIS
    WIN-035: Enforce User Account Control (UAC) at Maximum Security Level
.DESCRIPTION
    Category: 04_identity_access
    Threat Prevented: Silent Privilege Escalation, UAC Bypass Techniques (T1548.002)
    MITRE ATT&CK: T1548.002
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-035] Checking UAC settings..." -ForegroundColor Cyan
$sys = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$promptAdmin = (Get-ItemProperty -Path $sys -Name "ConsentPromptBehaviorAdmin" -ErrorAction SilentlyContinue).ConsentPromptBehaviorAdmin
$secureDesk = (Get-ItemProperty -Path $sys -Name "PromptOnSecureDesktop" -ErrorAction SilentlyContinue).PromptOnSecureDesktop

# 2 = Prompt for credentials on secure desktop
if ($promptAdmin -eq 2 -and $secureDesk -eq 1) {
    Write-Host "[PASS] COMPLIANT: UAC is set to highest security level." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: UAC is not at maximum level (Consent: $promptAdmin, SecureDesktop: $secureDesk)." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    Set-ItemProperty -Path $sys -Name "ConsentPromptBehaviorAdmin" -Value 2 -Type DWord -Force
    Set-ItemProperty -Path $sys -Name "PromptOnSecureDesktop" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $sys -Name "EnableLUA" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Enforced maximum UAC on secure desktop." -ForegroundColor Green
    exit 0
}
