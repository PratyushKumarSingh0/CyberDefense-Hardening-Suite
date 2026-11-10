# ==============================================================================
# Script ID:       AND-072
# Title:           Audit SYSTEM_ALERT_WINDOW (Overlay / Clickjacking Permissions)
# Category:        03_permissions_appsec
# Threat Prevented: Overlay Attacks, Credential Stealing, Clickjacking / Tapjacking (T1411)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-072: Audit SYSTEM_ALERT_WINDOW (Overlay Permissions)
echo "[*] Auditing apps holding SYSTEM_ALERT_WINDOW (Draw Over Other Apps)..."

APPS=$(appops query-op SYSTEM_ALERT_WINDOW allow 2>/dev/null | head -n 20)

if [ -n "$APPS" ]; then
    echo "[WARN] The following apps have permission to draw overlays:"
    echo "$APPS"
else
    echo "[PASS] No third-party apps holding SYSTEM_ALERT_WINDOW identified."
fi
exit 0

