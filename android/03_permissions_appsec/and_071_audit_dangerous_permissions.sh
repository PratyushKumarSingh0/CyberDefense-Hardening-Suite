# ==============================================================================
# Script ID:       AND-071
# Title:           Audit Apps Granted Sensitive & Dangerous Runtime Permissions
# Category:        03_permissions_appsec
# Threat Prevented: Excessive Permissions, Spyware Data Theft (T1433, T1430)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-071: Audit Apps Granted Sensitive & Dangerous Runtime Permissions
echo "[*] Auditing applications holding dangerous permissions (Camera, Mic, SMS, Location)..."

DANGEROUS="android.permission.RECORD_AUDIO android.permission.CAMERA android.permission.READ_SMS android.permission.ACCESS_FINE_LOCATION"

for perm in $DANGEROUS; do
    echo "--- Apps holding $perm ---"
    cmd package list packages -g 2>/dev/null | grep -B 1 "$perm" | grep "package:" | head -n 5
done

echo "[PASS] Dangerous permissions audit completed."
exit 0

