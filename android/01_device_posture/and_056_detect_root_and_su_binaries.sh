# ==============================================================================
# Script ID:       AND-056
# Title:           Detect Root Indicators and Su Binaries
# Category:        01_device_posture
# Threat Prevented: Compromised OS Sandbox, Magisk / SuperSU Privilege Hijacking (T1068)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-056: Detect Root and Su Binaries
echo "[*] Searching for root indicators and su binaries..."

ROOT_FOUND=0
PATHS="/system/bin/su /system/xbin/su /sbin/su /system/sd/xbin/su /system/bin/failsafe/su /data/local/su /data/local/bin/su /data/local/xbin/su"

for p in $PATHS; do
    if [ -f "$p" ]; then
        echo "[FAIL] Root binary detected at: $p"
        ROOT_FOUND=1
    fi
done

if which su >/dev/null 2>&1; then
    echo "[FAIL] 'su' command is discoverable on PATH."
    ROOT_FOUND=1
fi

if [ $ROOT_FOUND -eq 0 ]; then
    echo "[PASS] No standard su binaries or root paths discovered."
    exit 0
else
    exit 1
fi

