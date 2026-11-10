# ==============================================================================
# Script ID:       AND-051
# Title:           Verify File-Based Encryption (FBE) Status
# Category:        01_device_posture
# Threat Prevented: Physical Device Theft, Offline NAND Storage Dumps (T1200)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-051: Verify File-Based Encryption (FBE) Status
echo "[*] Auditing Android Full-Disk / File-Based Encryption state..."

CRYPTO_STATE=$(getprop ro.crypto.state)
CRYPTO_TYPE=$(getprop ro.crypto.type)

echo "[INFO] ro.crypto.state: $CRYPTO_STATE"
echo "[INFO] ro.crypto.type:  $CRYPTO_TYPE"

if [ "$CRYPTO_STATE" = "encrypted" ]; then
    echo "[PASS] Device storage is ENCRYPTED ($CRYPTO_TYPE)."
    exit 0
else
    echo "[FAIL] CRITICAL: Device storage is UNENCRYPTED!"
    exit 1
fi

