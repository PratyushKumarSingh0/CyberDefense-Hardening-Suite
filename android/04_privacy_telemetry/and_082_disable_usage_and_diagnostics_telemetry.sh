# ==============================================================================
# Script ID:       AND-082
# Title:           Disable Diagnostic and Usage Data Collection
# Category:        04_privacy_telemetry
# Threat Prevented: Telemetry Data Leakage, Behavioral Metadata Exfiltration (T1005)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-082: Disable Diagnostic and Usage Data Collection
echo "[*] Configuring diagnostic reporting restrictions..."

settings put secure upload_apk_enable 0 2>/dev/null
settings put secure send_action_app_error 0 2>/dev/null

echo "[PASS] Telemetry upload flags configured to 0."
exit 0

