# ==============================================================================
# Script ID:       AND-077
# Title:           Audit Active Device Administrator Applications
# Category:        03_permissions_appsec
# Threat Prevented: Ransomware Lockouts, Unremovable Malware, Remote Wipe Abuse (T1486)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-077: Audit Active Device Administrator Applications
echo "[*] Auditing active Device Administrators (device_policy)..."

dumpsys device_policy 2>/dev/null | grep -i "admin=" | head -n 10

echo "[PASS] Device administrator audit complete."
exit 0

