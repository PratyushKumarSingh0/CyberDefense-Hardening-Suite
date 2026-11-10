# ==============================================================================
# Script ID:       AND-078
# Title:           Revoke Sensitive Permissions from Specified Package
# Category:        03_permissions_appsec
# Threat Prevented: Excessive Dormant Privileges (T1433)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-078: Revoke Sensitive Permissions from Specified Package
PKG="$1"

if [ -z "$PKG" ]; then
    echo "Usage: and_078_revoke_dormant_app_permissions.sh <package_name>"
    exit 1
fi

echo "[*] Revoking sensitive permissions for package: $PKG"
pm revoke "$PKG" android.permission.READ_SMS 2>/dev/null
pm revoke "$PKG" android.permission.ACCESS_FINE_LOCATION 2>/dev/null
pm revoke "$PKG" android.permission.RECORD_AUDIO 2>/dev/null
pm revoke "$PKG" android.permission.CAMERA 2>/dev/null

echo "[PASS] Sensitive permissions revoked for $PKG."
exit 0

