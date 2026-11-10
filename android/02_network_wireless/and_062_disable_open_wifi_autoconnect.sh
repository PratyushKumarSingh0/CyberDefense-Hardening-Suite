# ==============================================================================
# Script ID:       AND-062
# Title:           Disable Auto-Connect to Open Public Wi-Fi
# Category:        02_network_wireless
# Threat Prevented: Evil Twin Wi-Fi, Rogue Access Points, Packet Sniffing (T1040)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-062: Disable Auto-Connect to Open Public Wi-Fi
echo "[*] Disabling open Wi-Fi notification and auto-join..."

settings put global wifi_networks_available_notification_on 0 2>/dev/null
settings put global wifi_scan_always_enabled 0 2>/dev/null

echo "[PASS] Open Wi-Fi notifications and background scanning disabled."
exit 0

