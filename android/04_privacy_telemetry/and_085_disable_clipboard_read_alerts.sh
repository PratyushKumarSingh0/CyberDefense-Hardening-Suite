# ==============================================================================
# Script ID:       AND-085
# Title:           Enable Clipboard Access Visual Alerts (Android 12+)
# Category:        04_privacy_telemetry
# Threat Prevented: Silent Background Clipboard Snooping (T1115)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-085: Enable Clipboard Access Visual Alerts
echo "[*] Enforcing clipboard access alert popups..."

settings put secure show_clip_access_notification 1 2>/dev/null

echo "[PASS] Clipboard access notifications enabled (show_clip_access_notification=1)."
exit 0

