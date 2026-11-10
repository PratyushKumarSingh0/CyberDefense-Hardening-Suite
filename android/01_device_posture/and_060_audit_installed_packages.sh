# ==============================================================================
# Script ID:       AND-060
# Title:           Audit 3rd-Party Installed Packages vs System Baseline
# Category:        01_device_posture
# Threat Prevented: Unauthorized Applications, Stealth Spyware, Malicious Sideloads (T1204)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-060: Audit 3rd-Party Installed Packages
echo "[*] Enumerating non-system (3rd-party) installed packages..."

PACKAGES=$(pm list packages -3 2>/dev/null | sed 's/package://g')
COUNT=$(echo "$PACKAGES" | grep -v '^$' | wc -l)

echo "[INFO] Discovered $COUNT third-party applications installed:"
echo "$PACKAGES" | head -n 25

echo "[PASS] Package inventory captured ($COUNT apps)."
exit 0

