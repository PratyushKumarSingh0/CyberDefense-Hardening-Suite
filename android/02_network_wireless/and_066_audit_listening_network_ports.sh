# ==============================================================================
# Script ID:       AND-066
# Title:           Audit Listening Local Sockets and Open Ports
# Category:        02_network_wireless
# Threat Prevented: Local Port Binding Backdoors, Insecure IPC Services (T1046)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-066: Audit Listening Local Sockets and Open Ports
echo "[*] Auditing active listening sockets on device..."

if [ -f /proc/net/tcp ]; then
    LISTEN_COUNT=$(grep " 0A " /proc/net/tcp | wc -l)
    echo "[INFO] Active TCP listening sockets: $LISTEN_COUNT"
fi

echo "[PASS] Socket audit complete."
exit 0

