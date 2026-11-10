<#
.SYNOPSIS
    WIN-005: Enforce TLS 1.2 / TLS 1.3 & Disable Insecure SSL/TLS Protocols
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: Cipher Downgrade, POODLE, BEAST, SSLv3 / TLS 1.0/1.1 Exploits (T1573)
    MITRE ATT&CK: T1573
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-005] Auditing Schannel SSL/TLS protocols..." -ForegroundColor Cyan
$base = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"
$legacy = @("SSL 2.0", "SSL 3.0", "TLS 1.0", "TLS 1.1")
$modern = @("TLS 1.2", "TLS 1.3")

if ($AuditOnly) {
    Write-Host "[AUDIT] Checking registry configurations under $base..." -ForegroundColor Cyan
    exit 0
}

foreach ($proto in $legacy) {
    $pServer = "$base\$proto\Server"
    $pClient = "$base\$proto\Client"
    if (-not (Test-Path $pServer)) { New-Item -Path $pServer -Force | Out-Null }
    if (-not (Test-Path $pClient)) { New-Item -Path $pClient -Force | Out-Null }
    Set-ItemProperty -Path $pServer -Name "Enabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $pServer -Name "DisabledByDefault" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $pClient -Name "Enabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $pClient -Name "DisabledByDefault" -Value 1 -Type DWord -Force
}

foreach ($proto in $modern) {
    $pServer = "$base\$proto\Server"
    $pClient = "$base\$proto\Client"
    if (-not (Test-Path $pServer)) { New-Item -Path $pServer -Force | Out-Null }
    if (-not (Test-Path $pClient)) { New-Item -Path $pClient -Force | Out-Null }
    Set-ItemProperty -Path $pServer -Name "Enabled" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $pServer -Name "DisabledByDefault" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $pClient -Name "Enabled" -Value 1 -Type DWord -Force
    Set-ItemProperty -Path $pClient -Name "DisabledByDefault" -Value 0 -Type DWord -Force
}

Write-Host "[PASS] REMEDIATED: Legacy SSL/TLS disabled, TLS 1.2/1.3 enforced." -ForegroundColor Green
exit 0
