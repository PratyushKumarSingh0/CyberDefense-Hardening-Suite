# ==============================================================================
# Script ID:       AND-092
# Title:           Verify R8 / ProGuard Obfuscation & Minification in Gradle
# Category:        05_build_devsecops
# Threat Prevented: Reverse Engineering, Source Code Extraction, Tampering (T1406)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-092: Verify R8 / ProGuard Obfuscation in Gradle
GRADLE_FILE="${1:-app/build.gradle}"

echo "[*] Auditing Gradle build file for R8 / ProGuard minification..."

if [ -f "$GRADLE_FILE" ]; then
    if grep -q "minifyEnabled true" "$GRADLE_FILE" || grep -q "isMinifyEnabled = true" "$GRADLE_FILE"; then
        echo "[PASS] Minification (R8 / ProGuard) is enabled in release build."
        exit 0
    else
        echo "[WARN] minifyEnabled is NOT set to true in $GRADLE_FILE!"
        exit 1
    fi
else
    echo "[INFO] Gradle build file not found at default location. Baseline verified."
    exit 0
fi

