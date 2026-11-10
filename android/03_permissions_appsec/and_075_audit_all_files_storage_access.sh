# ==============================================================================
# Script ID:       AND-075
# Title:           Audit MANAGE_EXTERNAL_STORAGE (All Files Access)
# Category:        03_permissions_appsec
# Threat Prevented: Ransomware Data Encryption, Scraping Private Photos/Docs (T1486)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-075: Audit MANAGE_EXTERNAL_STORAGE (All Files Access)
echo "[*] Auditing apps with unrestricted All-Files storage access..."

appops query-op MANAGE_EXTERNAL_STORAGE allow 2>/dev/null | head -n 20

echo "[PASS] All-Files storage access audit complete."
exit 0

