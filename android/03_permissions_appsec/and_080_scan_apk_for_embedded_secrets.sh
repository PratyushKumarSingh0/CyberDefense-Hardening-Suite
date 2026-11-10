# ==============================================================================
# Script ID:       AND-080
# Title:           Scan Unpacked APK or Code Directory for Hardcoded Secrets
# Category:        03_permissions_appsec
# Threat Prevented: API Key Leakage, Hardcoded Firebase / AWS Tokens (T1552)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-080: Scan Unpacked APK or Code Directory for Hardcoded Secrets
SEARCH_DIR="${1:-.}"

echo "[*] Scanning '$SEARCH_DIR' for sensitive credentials and tokens..."

PATTERNS="AIza[0-9A-Za-z-_]{35}|bearer\s+[A-Za-z0-9\._\-]{20,}|AKIA[0-9A-Z]{16}"

if which grep >/dev/null 2>&1; then
    grep -E -r -i "$PATTERNS" "$SEARCH_DIR" 2>/dev/null | head -n 10
fi

echo "[PASS] Scan completed."
exit 0

