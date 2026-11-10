# ==============================================================================
# Script ID:       AND-065
# Title:           Audit Always-On VPN and Lockdown Mode
# Category:        02_network_wireless
# Threat Prevented: Cleartext Traffic Leaks Outside VPN Tunnel (T1573)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-065: Audit Always-On VPN and Lockdown Mode
echo "[*] Auditing Always-On VPN status..."

VPN_APP=$(settings get secure always_on_vpn_app 2>/dev/null)
VPN_LOCK=$(settings get secure always_on_vpn_lockdown 2>/dev/null)

echo "[INFO] Always-on VPN App:      $VPN_APP"
echo "[INFO] VPN Lockdown Mode:      $VPN_LOCK"

if [ -n "$VPN_APP" ] && [ "$VPN_APP" != "null" ]; then
    echo "[PASS] Always-on VPN is configured ($VPN_APP)."
    exit 0
else
    echo "[WARN] No Always-On VPN is currently enforced."
    exit 0
fi

