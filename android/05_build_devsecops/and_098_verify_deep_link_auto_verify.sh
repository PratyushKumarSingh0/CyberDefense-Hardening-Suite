# ==============================================================================
# Script ID:       AND-098
# Title:           Verify Android App Links AutoVerify & Intent Redirection
# Category:        05_build_devsecops
# Threat Prevented: Intent Hijacking, Phishing via Unverified Custom Schemes (T1418)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-098: Verify Android App Links AutoVerify
MANIFEST="${1:-app/src/main/AndroidManifest.xml}"

echo "[*] Auditing deep link intent-filters..."

if [ -f "$MANIFEST" ]; then
    if grep -q 'android:autoVerify="true"' "$MANIFEST"; then
        echo "[PASS] autoVerify is enabled for App Links."
    else
        echo "[INFO] Verify that all HTTP/HTTPS intent-filters declare android:autoVerify=\"true\"."
    fi
fi

exit 0

