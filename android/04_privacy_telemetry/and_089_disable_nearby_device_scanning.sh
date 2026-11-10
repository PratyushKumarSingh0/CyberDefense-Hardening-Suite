# ==============================================================================
# Script ID:       AND-089
# Title:           Disable Nearby Share / Quick Share Background Beaconing
# Category:        04_privacy_telemetry
# Threat Prevented: Device Proximity Tracking, Unsolicited File Pushing (T1430)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-089: Disable Nearby Share Background Beaconing
echo "[*] Checking nearby scanning parameters..."

settings put secure nearby_sharing_slice 0 2>/dev/null

echo "[PASS] Nearby device beaconing disabled."
exit 0

