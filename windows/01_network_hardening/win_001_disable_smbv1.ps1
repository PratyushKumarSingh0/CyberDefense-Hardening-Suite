<#
.SYNOPSIS
    WIN-001: Disable SMBv1 Protocol
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: WannaCry, EternalBlue, Lateral Movement (T1021.002)
    MITRE ATT&CK: T1021.002, T1210
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param (
    [switch]$AuditOnly
)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-001] Checking SMBv1 status..." -ForegroundColor Cyan

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$smb1Reg = Get-ItemProperty -Path $regPath -Name "SMB1" -ErrorAction SilentlyContinue

$isVulnerable = $true
if ($smb1Reg -and $smb1Reg.SMB1 -eq 0) {
    $isVulnerable = $false
}

if ($isVulnerable) {
    Write-Host "[!] VULNERABLE: SMBv1 protocol is enabled or not explicitly disabled." -ForegroundColor Red
    if ($AuditOnly) {
        Write-Host "[AUDIT] Recommendation: Run without -AuditOnly to disable SMBv1." -ForegroundColor Yellow
        exit 1
    } else {
        Write-Host "[*] Remediating: Disabling SMBv1 via Registry and Feature..." -ForegroundColor Yellow
        Set-ItemProperty -Path $regPath -Name "SMB1" -Value 0 -Type DWord -Force
        Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart -ErrorAction SilentlyContinue | Out-Null
        Write-Host "[PASS] SUCCESS: SMBv1 has been disabled." -ForegroundColor Green
        exit 0
    }
} else {
    Write-Host "[PASS] COMPLIANT: SMBv1 is already disabled." -ForegroundColor Green
    exit 0
}
