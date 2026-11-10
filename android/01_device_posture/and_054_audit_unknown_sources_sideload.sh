# ==============================================================================
# Script ID:       AND-054
# Title:           Audit Unknown Sources / Third-Party App Sideloading
# Category:        01_device_posture
# Threat Prevented: Malicious APK Sideloading, Drive-by Downloads (T1204)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-054: Audit Unknown Sources Sideloading
echo "[*] Checking unknown sources / sideload policy..."

NON_MARKET=$(settings get secure install_non_market_apps 2>/dev/null || echo "0")

if [ "$NON_MARKET" = "0" ] || [ -z "$NON_MARKET" ] || [ "$NON_MARKET" = "null" ]; then
    echo "[PASS] Global installation of non-market apps is restricted."
    exit 0
else
    echo "[WARN] Global unknown sources sideloading is PERMITTED ($NON_MARKET)."
    exit 1
fi

