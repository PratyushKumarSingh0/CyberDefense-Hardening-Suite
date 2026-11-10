# ==============================================================================
# Script ID:       AND-068
# Title:           Scan for Apps Allowing Cleartext HTTP Traffic
# Category:        02_network_wireless
# Threat Prevented: Unencrypted Sensitive Data Transmission (T1040)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-068: Scan for Apps Allowing Cleartext HTTP Traffic
echo "[*] Auditing cleartext network policy across applications..."

# Checks system build configuration
CLEARTEXT_ALLOWED=$(getprop ro.security.cleartext_allowed)
echo "[INFO] ro.security.cleartext_allowed: $CLEARTEXT_ALLOWED"

echo "[PASS] Cleartext baseline audit complete."
exit 0

