# ==============================================================================
# Script ID:       AND-095
# Title:           Verify APK Signing Scheme v2 / v3 / v4 Integrity
# Category:        05_build_devsecops
# Threat Prevented: Janus Vulnerability, APK Byte Flipping, Repackaged Trojans (T1406)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-095: Verify APK Signing Scheme v2 / v3
APK_PATH="$1"

if [ -z "$APK_PATH" ]; then
    echo "Usage: and_095_verify_apk_v2_v3_signature.sh <target.apk>"
    exit 0
fi

echo "[*] Verifying cryptographic signatures on $APK_PATH..."

if which apksigner >/dev/null 2>&1; then
    apksigner verify --verbose "$APK_PATH"
else
    echo "[INFO] apksigner not installed on current path. Rule: enforce Scheme v2/v3 signatures."
fi
exit 0

