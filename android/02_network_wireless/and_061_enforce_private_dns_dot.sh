# ==============================================================================
# Script ID:       AND-061
# Title:           Enforce Private DNS (DNS-over-TLS)
# Category:        02_network_wireless
# Threat Prevented: DNS Spoofing, ISP Eavesdropping, Fake Wi-Fi Captive Portals (T1557)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-061: Enforce Private DNS (DNS-over-TLS)
echo "[*] Checking Private DNS (DoT) configuration..."

MODE=$(settings get global private_dns_mode 2>/dev/null)
SPECIFIER=$(settings get global private_dns_specifier 2>/dev/null)

echo "[INFO] Private DNS Mode:      $MODE"
echo "[INFO] Private DNS Provider:  $SPECIFIER"

if [ "$MODE" = "hostname" ] && [ -n "$SPECIFIER" ]; then
    echo "[PASS] Private DNS over TLS is strictly enforced with provider $SPECIFIER."
    exit 0
else
    echo "[WARN] Private DNS is not set to strict hostname mode ($MODE)."
    echo "[*] Example remediation: settings put global private_dns_mode hostname"
    echo "[*]                      settings put global private_dns_specifier one.one.one.one"
    exit 1
fi

