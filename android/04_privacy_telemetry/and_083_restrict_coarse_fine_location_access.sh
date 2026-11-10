# ==============================================================================
# Script ID:       AND-083
# Title:           Audit System Location Mode & Wi-Fi Scanning Assist
# Category:        04_privacy_telemetry
# Threat Prevented: Passive Wi-Fi / Cell Tower Location Fingerprinting (T1430)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-083: Audit System Location Mode & Wi-Fi Scanning Assist
echo "[*] Checking location provider and scan settings..."

LOC_MODE=$(settings get secure location_mode 2>/dev/null)
WIFI_SCAN=$(settings get global wifi_scan_always_enabled 2>/dev/null)

echo "[INFO] location_mode:            $LOC_MODE"
echo "[INFO] wifi_scan_always_enabled: $WIFI_SCAN"

echo "[PASS] Location mode audited."
exit 0

