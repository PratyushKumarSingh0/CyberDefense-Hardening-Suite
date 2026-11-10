# Contributing to CyberDefense-Hardening-Suite

Thank you for your interest in contributing to the **CyberDefense-Hardening-Suite**! This project provides production-grade, MITRE ATT&CK-mapped defensive scripts to harden Windows and Android endpoints against modern cyber threats.

---

## Contribution Guidelines

1. **Defensive Focus Only**:
   - Every script must serve an exclusively defensive purpose (hardening, auditing, posture assessment, telemetry verification, access restriction, quarantine).
   - No offensive exploits, weaponized payloads, or malware samples are permitted.

2. **Standardized Script Format**:
   - **Windows Scripts (`.ps1`)**:
     - Must support the `[switch]$AuditOnly` parameter.
     - When `-AuditOnly` is passed, the script must inspect state without altering system configuration, and return `exit 0` if compliant, or `exit 1` if vulnerable.
     - Include a comment-based help block with `.SYNOPSIS`, `.DESCRIPTION`, `Threat Prevented`, and `MITRE ATT&CK` references.
   - **Android Scripts (`.sh`)**:
     - Must run with standard POSIX `/bin/sh` syntax.
     - Must cleanly handle both execution via `adb shell` or local terminal (e.g., Termux / rooted device).
     - Return `exit 0` on compliance or informational success; return `exit 1` on critical vulnerability or missing prerequisites.

3. **Code Quality & Testing**:
   - Test Windows PowerShell scripts against PSScriptAnalyzer.
   - Validate Android shell scripts with `shellcheck`.

4. **Pull Request Process**:
   - Create a feature branch: `git checkout -b feature/new-defensive-script`.
   - Update `README.md` if adding or modifying script mappings.
   - Submit a Pull Request with a clear explanation of the threat model addressed.
