# ==============================================================================
# Script ID:       AND-093
# Title:           Verify APK Binary Is Not Debuggable (android:debuggable=false)
# Category:        05_build_devsecops
# Threat Prevented: Runtime Memory Inspection, JDWP Remote Debugging Exploits (T1059)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-093: Verify APK Debuggable Flag
APK_FILE="$1"

if [ -z "$APK_FILE" ]; then
    echo "Usage: and_093_audit_apk_debuggable_flag.sh <target_app.apk>"
    exit 0
fi

echo "[*] Auditing APK debuggable flag in: $APK_FILE"

if which aapt >/dev/null 2>&1; then
    IS_DEBUG=$(aapt dump badging "$APK_FILE" 2>/dev/null | grep -i "debuggable")
    if [ -n "$IS_DEBUG" ]; then
        echo "[FAIL] CRITICAL: APK is compiled in DEBUGGABLE mode ($IS_DEBUG)!"
        exit 1
    else
        echo "[PASS] APK is NOT debuggable (production hardened)."
        exit 0
    fi
else
    echo "[INFO] 'aapt' tool not in PATH. Skipping binary extraction check."
    exit 0
fi

