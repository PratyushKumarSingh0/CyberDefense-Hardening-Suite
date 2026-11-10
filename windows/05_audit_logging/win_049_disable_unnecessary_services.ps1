<#
.SYNOPSIS
    WIN-049: Disable High-Risk and Unnecessary Legacy Services
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: Unauthenticated Remote Registry, Legacy Protocol Exploitation (T1021)
    MITRE ATT&CK: T1021
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-049] Auditing high-risk services..." -ForegroundColor Cyan
$legacy = @("RemoteRegistry", "SessionEnv", "SSDPSRV", "upnphost")

foreach ($s in $legacy) {
    $svc = Get-Service -Name $s -ErrorAction SilentlyContinue
    if ($svc) {
        Write-Host "[*] Service '$s': Status=$($svc.Status), StartType=$($svc.StartType)" -ForegroundColor Gray
        if (-not $AuditOnly -and $svc.StartType -ne "Disabled") {
            Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
            Write-Host "[+] Disabled service '$s'." -ForegroundColor Green
        }
    }
}

Write-Host "[PASS] Service attack surface review complete." -ForegroundColor Green
exit 0
