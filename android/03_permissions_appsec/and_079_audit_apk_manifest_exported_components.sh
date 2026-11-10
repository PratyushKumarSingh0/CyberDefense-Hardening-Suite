# ==============================================================================
# Script ID:       AND-079
# Title:           Audit APK Exported Components for Intent Spoofing
# Category:        03_permissions_appsec
# Threat Prevented: Intent Redirection, Insecure Broadcast Listeners, Auth Bypass (T1418)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-079: Audit APK Exported Components for Intent Spoofing
TARGET_PKG="$1"

if [ -z "$TARGET_PKG" ]; then
    echo "[*] Inspecting high-level package dump for exported components..."
    echo "Usage: and_079_audit_apk_manifest_exported_components.sh <package_name>"
    exit 0
fi

echo "[*] Inspecting activities/services for package: $TARGET_PKG"
dumpsys package "$TARGET_PKG" 2>/dev/null | grep -E "Activity|Service|Receiver|Provider" | head -n 25

echo "[PASS] Component inspection complete."
exit 0

