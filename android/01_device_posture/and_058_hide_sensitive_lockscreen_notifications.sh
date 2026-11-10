# ==============================================================================
# Script ID:       AND-058
# Title:           Hide Sensitive Lock Screen Notifications
# Category:        01_device_posture
# Threat Prevented: Shoulder Surfing, 2FA SMS Code Exposure on Locked Screen (T1005)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-058: Hide Sensitive Lock Screen Notifications
echo "[*] Auditing lock screen private notifications setting..."

SETTING=$(settings get secure lock_screen_allow_private_notifications 2>/dev/null)

if [ "$SETTING" = "0" ]; then
    echo "[PASS] Sensitive lock screen notifications are hidden."
    exit 0
else
    echo "[WARN] Sensitive notifications may display on lock screen ($SETTING)."
    echo "[*] Remediating: Setting lock_screen_allow_private_notifications to 0..."
    settings put secure lock_screen_allow_private_notifications 0 2>/dev/null
    echo "[PASS] Updated setting to hide private notifications."
    exit 0
fi

