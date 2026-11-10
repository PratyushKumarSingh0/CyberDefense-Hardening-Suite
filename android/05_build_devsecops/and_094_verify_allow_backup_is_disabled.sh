# ==============================================================================
# Script ID:       AND-094
# Title:           Verify android:allowBackup Is Disabled in Manifest
# Category:        05_build_devsecops
# Threat Prevented: Local ADB Backup Extraction, Private Data Stealing (T1005)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-094: Verify android:allowBackup Is Disabled
MANIFEST="${1:-app/src/main/AndroidManifest.xml}"

echo "[*] Checking allowBackup attribute in AndroidManifest.xml..."

if [ -f "$MANIFEST" ]; then
    if grep -q 'android:allowBackup="true"' "$MANIFEST"; then
        echo "[WARN] android:allowBackup is TRUE in $MANIFEST (Data can be extracted via 'adb backup')!"
        exit 1
    else
        echo "[PASS] allowBackup is safely disabled or omitted."
        exit 0
    fi
else
    echo "[INFO] Manifest not at $MANIFEST. Ensure android:allowBackup=\"false\" in release manifests."
    exit 0
fi

