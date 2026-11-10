<#
.SYNOPSIS
    Windows Defense Audit Orchestrator
.DESCRIPTION
    Runs all 50 Windows defensive auditing scripts in safe (-AuditOnly) mode,
    computes an overall security compliance score, and outputs a formatted report.
#>

[CmdletBinding()]
param (
    [switch]$Remediate,
    [string]$ReportPath = "windows_security_audit_report.json"
)

Write-Host @"
========================================================================
     CYBERDEFENSE-HARDENING-SUITE: WINDOWS ENDPOINT AUDIT RUNNER
========================================================================
Mode: $(if ($Remediate) { "ENFORCE / REMEDIATE" } else { "AUDIT ONLY (SAFE)" })
Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Host: $env:COMPUTERNAME | OS: $((Get-CimInstance Win32_OperatingSystem).Caption)
========================================================================
"@ -ForegroundColor Cyan

$scriptRoot = Split-Path -Parent $PSScriptRoot
$windowsDir = Join-Path $scriptRoot "windows"

$scripts = Get-ChildItem -Path $windowsDir -Filter "*.ps1" -Recurse | Sort-Object Name

$total = $scripts.Count
$passed = 0
$failed = 0
$results = @()

Write-Host "[*] Discovered $total defensive scripts across 5 categories.`n" -ForegroundColor Cyan

foreach ($s in $scripts) {
    $scriptName = $s.Name
    $category = $s.Directory.Name
    Write-Host "-> Running [$category] $scriptName..." -NoNewline
    
    $exitCode = 0
    try {
        if ($Remediate) {
            & $s.FullName | Out-Null
        } else {
            & $s.FullName -AuditOnly | Out-Null
        }
        $exitCode = $LASTEXITCODE
    } catch {
        $exitCode = 1
    }

    $status = if ($exitCode -eq 0) { "PASS" } else { "FAIL" }
    
    if ($status -eq "PASS") {
        $passed++
        Write-Host " [PASS]" -ForegroundColor Green
    } else {
        $failed++
        Write-Host " [ATTENTION]" -ForegroundColor Yellow
    }

    $results += [PSCustomObject]@{
        Script = $scriptName
        Category = $category
        Status = $status
        ExitCode = $exitCode
    }
}

$scorePct = [Math]::Round(($passed / $total) * 100, 1)

Write-Host @"

========================================================================
                       AUDIT SUMMARY SCORECARD
========================================================================
Total Defensive Controls Audited: $total
Passed Controls:                 $passed
Controls Requiring Attention:    $failed
Endpoint Hardening Score:        $scorePct %
========================================================================
"@ -ForegroundColor $(if ($scorePct -ge 80) { "Green" } else { "Yellow" })

$results | ConvertTo-Json -Depth 3 | Set-Content -Path $ReportPath -Force
Write-Host "[+] Detailed JSON report exported to: $ReportPath" -ForegroundColor Green
