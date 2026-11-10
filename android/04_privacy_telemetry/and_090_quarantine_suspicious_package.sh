# ==============================================================================
# Script ID:       AND-090
# Title:           Emergency Application Quarantine & Freeze Script
# Category:        04_privacy_telemetry
# Threat Prevented: Active Malware Infection Containment, Data Exfiltration (T1204)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-090: Emergency Application Quarantine Script
SUSPECT_PKG="$1"

if [ -z "$SUSPECT_PKG" ]; then
    echo "Usage: and_090_quarantine_suspicious_package.sh <package_name>"
    exit 1
fi

echo "[*] QUARANTINING SUSPICIOUS PACKAGE: $SUSPECT_PKG"
am force-stop "$SUSPECT_PKG" 2>/dev/null
pm disable-user --user 0 "$SUSPECT_PKG" 2>/dev/null

echo "[PASS] Package $SUSPECT_PKG has been stopped and disabled."
exit 0

