# ==============================================================================
# Script ID:       AND-053
# Title:           Audit Developer Options & USB Debugging Status
# Category:        01_device_posture
# Threat Prevented: Juice Jacking, Physical USB Attack, Unauthorized ADB Access (T1200)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-053: Audit Developer Options & USB Debugging Status
echo "[*] Auditing Developer Options and USB Debugging..."

DEV_OPTS=$(settings get global development_settings_enabled 2>/dev/null || echo "0")
ADB_ENABLED=$(settings get global adb_enabled 2>/dev/null || echo "0")

echo "[INFO] Developer Settings Enabled: $DEV_OPTS"
echo "[INFO] ADB Debugging Enabled:       $ADB_ENABLED"

if [ "$ADB_ENABLED" = "1" ]; then
    echo "[WARN] USB Debugging is ACTIVE. Recommended: Disable when not in active development."
else
    echo "[PASS] USB Debugging is DISABLED."
fi
exit 0

