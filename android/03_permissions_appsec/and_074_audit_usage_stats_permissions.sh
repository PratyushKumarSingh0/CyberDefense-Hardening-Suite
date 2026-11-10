# ==============================================================================
# Script ID:       AND-074
# Title:           Audit PACKAGE_USAGE_STATS (App Usage Access)
# Category:        03_permissions_appsec
# Threat Prevented: Behavioral Profiling, Context-Aware Overlay Triggering (T1418)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-074: Audit PACKAGE_USAGE_STATS
echo "[*] Checking apps with GET_USAGE_STATS permission..."

STATS_APPS=$(appops query-op GET_USAGE_STATS allow 2>/dev/null | head -n 15)
echo "$STATS_APPS"

echo "[PASS] Usage statistics audit completed."
exit 0

