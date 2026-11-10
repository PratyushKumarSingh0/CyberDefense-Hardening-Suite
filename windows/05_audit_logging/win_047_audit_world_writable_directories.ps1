<#
.SYNOPSIS
    WIN-047: Scan System Paths for Insecure World-Writable Permissions
.DESCRIPTION
    Category: 05_audit_logging
    Threat Prevented: DLL Search Order Hijacking, Privilege Escalation (T1574.001)
    MITRE ATT&CK: T1574.001
    Part of the CyberDefense-Hardening-Suite for Windows and Android.
#>

[CmdletBinding(SupportsShouldProcess)]
param ([switch]$AuditOnly)

Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] [WIN-047] Auditing PATH directories for write permissions..." -ForegroundColor Cyan
$envPaths = ($env:PATH -split ';') | Where-Object { [string]::IsNullOrWhiteSpace($_) -eq $false -and (Test-Path $_) }

$writable = @()
foreach ($p in $envPaths) {
    try {
        $testFile = Join-Path $p "cyberdef_perm_test_$([Guid]::NewGuid().ToString('N')).tmp"
        [IO.File]::WriteAllText($testFile, "test")
        [IO.File]::Delete($testFile)
        # If running as standard user and can write to system dir, flag it!
        $writable += $p
    } catch {}
}

Write-Host "[*] PATH directories inspected: $($envPaths.Count). Writeable count: $($writable.Count)." -ForegroundColor Cyan
if ($writable.Count -gt 0) {
    Write-Host "[!] NOTICE: Unprivileged write permission exists in: $($writable -join ', ')" -ForegroundColor Yellow
} else {
    Write-Host "[PASS] COMPLIANT: System PATH directories are protected." -ForegroundColor Green
}
exit 0
