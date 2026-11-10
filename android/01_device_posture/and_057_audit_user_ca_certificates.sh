# ==============================================================================
# Script ID:       AND-057
# Title:           Audit User-Installed Root CA Certificates
# Category:        01_device_posture
# Threat Prevented: SSL/TLS MITM Interception, Insecure Proxy Certificates (T1557)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-057: Audit User-Installed Root CA Certificates
echo "[*] Checking for user-installed trust anchors / CA certificates..."

USER_CERTS="/data/misc/user/0/cacerts-added"

if [ -d "$USER_CERTS" ]; then
    CERT_COUNT=$(ls -1 "$USER_CERTS" 2>/dev/null | wc -l)
    if [ "$CERT_COUNT" -gt 0 ]; then
        echo "[WARN] Detected $CERT_COUNT user-installed CA certificate(s) in $USER_CERTS!"
        ls -la "$USER_CERTS"
        exit 1
    fi
fi

echo "[PASS] No rogue user CA certificates found in standard trust store."
exit 0

