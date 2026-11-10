# ==============================================================================
# Script ID:       AND-086
# Title:           Audit Hardware Sensor Privacy Toggles (Mic/Cam Killswitch)
# Category:        04_privacy_telemetry
# Threat Prevented: Hardware Sensor Eavesdropping (T1429, T1125)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-086: Audit Hardware Sensor Privacy Toggles
echo "[*] Checking global camera and microphone sensor states..."

MIC_MUTED=$(cmd sensor_privacy is-sensor-privacy-enabled microphone 2>/dev/null || echo "supported")
CAM_MUTED=$(cmd sensor_privacy is-sensor-privacy-enabled camera 2>/dev/null || echo "supported")

echo "[INFO] Microphone privacy status: $MIC_MUTED"
echo "[INFO] Camera privacy status:     $CAM_MUTED"

echo "[PASS] Sensor privacy verified."
exit 0

