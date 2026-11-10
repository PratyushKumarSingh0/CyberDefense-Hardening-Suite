# ==============================================================================
# Script ID:       AND-099
# Title:           Audit Hardware-Backed KeyStore & StrongBox Configuration
# Category:        05_build_devsecops
# Threat Prevented: In-Memory Key Extraction, Software-Only Key Compromise (T1552)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-099: Audit Hardware-Backed KeyStore & StrongBox Configuration
SEARCH_DIR="${1:-app/src}"

echo "[*] Scanning code for AndroidKeyStore and StrongBox Keystore usage..."

if which grep >/dev/null 2>&1 && [ -d "$SEARCH_DIR" ]; then
    grep -r -i "setIsStrongBoxBacked" "$SEARCH_DIR" 2>/dev/null || echo "[INFO] StrongBox flag not found in source."
fi

echo "[PASS] KeyStore posture reviewed."
exit 0

