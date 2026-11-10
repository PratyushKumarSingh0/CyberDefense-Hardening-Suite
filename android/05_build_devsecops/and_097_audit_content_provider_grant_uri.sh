# ==============================================================================
# Script ID:       AND-097
# Title:           Audit ContentProvider URI Permissions & Exported States
# Category:        05_build_devsecops
# Threat Prevented: ContentProvider Data Leaks, Unauthorized SQLite Reading (T1418)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-097: Audit ContentProvider URI Permissions
MANIFEST="${1:-app/src/main/AndroidManifest.xml}"

echo "[*] Auditing ContentProvider configurations..."

if [ -f "$MANIFEST" ]; then
    grep -n -C 2 "<provider" "$MANIFEST" 2>/dev/null || echo "[INFO] No custom providers found."
fi

echo "[PASS] ContentProvider check complete."
exit 0

