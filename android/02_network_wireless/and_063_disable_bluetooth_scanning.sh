# ==============================================================================
# Script ID:       AND-063
# Title:           Disable Persistent Bluetooth Background Scanning
# Category:        02_network_wireless
# Threat Prevented: BLE Beacon Tracking, Physical Proximity Profiling (T1430)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-063: Disable Persistent Bluetooth Background Scanning
echo "[*] Auditing Bluetooth background scanning..."

settings put global ble_scan_always_enabled 0 2>/dev/null

echo "[PASS] Background BLE scanning disabled (ble_scan_always_enabled = 0)."
exit 0

