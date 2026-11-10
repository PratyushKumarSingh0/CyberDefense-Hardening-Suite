# ==============================================================================
# Script ID:       AND-052
# Title:           Verify SELinux Enforcing Mode
# Category:        01_device_posture
# Threat Prevented: Kernel Exploitation, Sandbox Escapes, Root Privileges (T1068)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-052: Verify SELinux Enforcing Mode
echo "[*] Checking SELinux operating state..."

SELINUX_MODE=$(getenforce 2>/dev/null || getprop ro.boot.selinux)

if [ "$SELINUX_MODE" = "Enforcing" ] || [ "$SELINUX_MODE" = "enforcing" ]; then
    echo "[PASS] SELinux is actively ENFORCING Mandatory Access Controls."
    exit 0
else
    echo "[FAIL] WARNING: SELinux is in $SELINUX_MODE mode! Exploitation protections compromised."
    exit 1
fi

