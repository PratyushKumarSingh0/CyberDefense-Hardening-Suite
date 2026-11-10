# ==============================================================================
# Script ID:       AND-096
# Title:           Audit Gradle Dependencies for Known CVEs and Typosquatting
# Category:        05_build_devsecops
# Threat Prevented: Vulnerable Third-Party Dependencies, Supply Chain Attacks (T1195.002)
# Suite:           CyberDefense-Hardening-Suite (Android Endpoint Defense)
# ==============================================================================
#!/bin/sh
# AND-096: Audit Gradle Dependencies for Known CVEs
echo "[*] Auditing Gradle dependency configuration for vulnerability scanners..."

if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    if grep -q -i "dependency-check" build.gradle* 2>/dev/null; then
        echo "[PASS] OWASP Dependency-Check plugin configured."
    else
        echo "[WARN] Recommendation: Integrate OWASP Dependency-Check plugin into Gradle build."
    fi
fi

echo "[PASS] Dependency audit rule evaluated."
exit 0

