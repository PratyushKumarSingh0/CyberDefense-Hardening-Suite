<#
.SYNOPSIS
    WIN-003: Disable NetBIOS over TCP/IP
.DESCRIPTION
    Category: 01_network_hardening
    Threat Prevented: NetBIOS Name Service Spoofing & NTLM Relay (T1557.001)
    MITRE ATT&CK: T1557.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-003] Auditing NetBIOS over TCP/IP on network adapters..." -ForegroundColor Cyan
$adapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

$nonCompliant = $false
foreach ($nic in $adapters) {
    # 0 = Default, 1 = Enabled, 2 = Disabled
    if ($nic.TcpipNetbiosOptions -ne 2) {
        $nonCompliant = $true
        Write-Host "[!] Adapter '$($nic.Description)' has NetBIOS enabled (Mode: $($nic.TcpipNetbiosOptions))." -ForegroundColor Yellow
        if (-not $AuditOnly) {
            Invoke-CimMethod -InputObject $nic -MethodName SetTcpipNetbios -Arguments @{ TcpipNetbiosOptions = [uint32]2 } | Out-Null
            Write-Host "[+] Disabled NetBIOS on '$($nic.Description)'." -ForegroundColor Green
        }
    }
}

if ($nonCompliant -and $AuditOnly) {
    Write-Host "[FAIL] One or more adapters have NetBIOS active." -ForegroundColor Red
    exit 1
} else {
    Write-Host "[PASS] NetBIOS over TCP/IP is disabled on active adapters." -ForegroundColor Green
    exit 0
}
