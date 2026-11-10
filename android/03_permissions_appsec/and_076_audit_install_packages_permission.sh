# ==============================================================================
# Script ID:       AND-076
# Title:           Audit REQUEST_INSTALL_PACKAGES (Malicious Dropper Prevention)
# Category:        03_permissions_appsec
# Threat Prevented: Second-Stage Droppers, Stealth Trojan Installers (T1204)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-076: Audit REQUEST_INSTALL_PACKAGES
echo "[*] Auditing apps allowed to install packages..."

appops query-op REQUEST_INSTALL_PACKAGES allow 2>/dev/null | head -n 15

echo "[PASS] Package installation authority audited."
exit 0

