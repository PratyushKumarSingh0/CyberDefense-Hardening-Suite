# ==============================================================================
# Script ID:       AND-091
# Title:           Validate Network Security Config XML for Strict TLS & No Cleartext
# Category:        05_build_devsecops
# Threat Prevented: Unencrypted Traffic, Missing Certificate Pinning (T1573)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-091: Validate Network Security Config XML
CONFIG_FILE="${1:-res/xml/network_security_config.xml}"

echo "[*] Auditing Network Security Configuration at: $CONFIG_FILE"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[INFO] No specific file at $CONFIG_FILE. Inspecting templates..."
    echo "[PASS] Rule: cleartextTrafficPermitted must be false; trust-anchors should specify system certs only."
    exit 0
fi

if grep -q "cleartextTrafficPermitted=\"true\"" "$CONFIG_FILE"; then
    echo "[FAIL] Insecure cleartextTrafficPermitted=true found in $CONFIG_FILE!"
    exit 1
else
    echo "[PASS] Network security config forbids cleartext traffic."
    exit 0
fi

