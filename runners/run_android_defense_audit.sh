#!/bin/sh
# ==============================================================================
# CyberDefense-Hardening-Suite: Android Endpoint Audit Runner
# ==============================================================================
# Executes all 50 Android defensive audit checks via ADB or direct on-device shell.
# ==============================================================================

set -e

echo "========================================================================"
echo "    CYBERDEFENSE-HARDENING-SUITE: ANDROID DEFENSIVE AUDIT RUNNER        "
echo "========================================================================"

# Determine if running via ADB or on-device
USE_ADB=""
if which adb >/dev/null 2>&1; then
    DEVICE_COUNT=$(adb devices | grep -v "List" | grep "device" | wc -l)
    if [ "$DEVICE_COUNT" -gt 0 ]; then
        echo "[+] Connected ADB device discovered. Running remotely via ADB."
        USE_ADB="adb shell"
    fi
fi

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ANDROID_DIR="$SCRIPT_DIR/android"

TOTAL=0
PASSED=0

echo "[*] Scanning defensive scripts in: $ANDROID_DIR"

for script in "$ANDROID_DIR"/*/*.sh; do
    if [ -f "$script" ]; then
        TOTAL=$((TOTAL + 1))
        SNAME=$(basename "$script")
        echo -n "[RUN] $SNAME ... "
        
        # Execute script
        if [ -n "$USE_ADB" ]; then
            # Stream script to adb shell
            if adb shell "sh -s" < "$script" >/dev/null 2>&1; then
                PASSED=$((PASSED + 1))
                echo "[PASS]"
            else
                echo "[ATTENTION]"
            fi
        else
            if sh "$script" >/dev/null 2>&1; then
                PASSED=$((PASSED + 1))
                echo "[PASS]"
            else
                echo "[ATTENTION]"
            fi
        fi
    fi
done

echo "========================================================================"
echo "Android Audit Complete: $PASSED / $TOTAL checks compliant."
echo "========================================================================"
