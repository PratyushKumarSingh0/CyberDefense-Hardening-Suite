<#
.SYNOPSIS
    WIN-017: Block Microsoft Office Macros from Internet Origin
.DESCRIPTION
    Category: 02_system_integrity
    Threat Prevented: Malicious Office Documents, Emotet, Qakbot, Macro Droppers (T1566.001)
    MITRE ATT&CK: T1566.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-017] Auditing Office internet macro execution policy..." -ForegroundColor Cyan
$reg = "HKCU:\Software\Policies\Microsoft\Office\16.0\common\security"
$val = (Get-ItemProperty -Path $reg -Name "blockcontentexecutionfrominternet" -ErrorAction SilentlyContinue).blockcontentexecutionfrominternet

if ($val -eq 1) {
    Write-Host "[PASS] COMPLIANT: Office internet macros are blocked." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[!] VULNERABLE: Untrusted internet macros are not blocked." -ForegroundColor Red
    if ($AuditOnly) { exit 1 }
    if (-not (Test-Path $reg)) { New-Item -Path $reg -Force | Out-Null }
    Set-ItemProperty -Path $reg -Name "blockcontentexecutionfrominternet" -Value 1 -Type DWord -Force
    Write-Host "[PASS] REMEDIATED: Enforced blockcontentexecutionfrominternet=1." -ForegroundColor Green
    exit 0
}
