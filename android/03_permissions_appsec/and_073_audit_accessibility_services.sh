# ==============================================================================
# Script ID:       AND-073
# Title:           Audit Active Accessibility Services (Keylogging / Banking Trojans)
# Category:        03_permissions_appsec
# Threat Prevented: Banking Trojans, Automated Permission Granting, Keylogging (T1417)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-073: Audit Active Accessibility Services
echo "[*] Auditing active Accessibility Services..."

SERVICES=$(settings get secure enabled_accessibility_services 2>/dev/null)

if [ -z "$SERVICES" ] || [ "$SERVICES" = "null" ]; then
    echo "[PASS] No third-party accessibility services enabled."
    exit 0
else
    echo "[WARN] Active Accessibility Services detected:"
    echo "$SERVICES"
    echo "[*] CAUTION: Malware often abuses Accessibility to log keystrokes or steal 2FA."
    exit 0
fi

