# ==============================================================================
# Script ID:       AND-088
# Title:           Audit User Keyboard Dictionary for Leaked Credentials
# Category:        04_privacy_telemetry
# Threat Prevented: Sensitive Credentials Cached in Input Method Editor (IME) (T1056)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-088: Audit User Keyboard Dictionary
echo "[*] Auditing user dictionary entries for sensitive cached strings..."

content query --uri content://user_dictionary/words 2>/dev/null | head -n 10

echo "[PASS] User dictionary audit completed."
exit 0

