# Security Policy

## Scope and Intent

The **CyberDefense-Hardening-Suite** is an open-source defensive cybersecurity project designed for:
- System Administrators
- Security Operations Centers (SOC) & Incident Responders
- Detection Engineers & Blue Teams
- Mobile Security Auditors
- Enterprise IT Security teams

All 100 scripts in this repository are strictly preventative, auditing, and hardening utilities designed to reduce the attack surface of Windows endpoints and Android mobile devices against unauthorized access, lateral movement, malware infection, and credential theft.

## Safe Usage Disclaimer

- **Test in Staging First**: Always validate hardening scripts in a test or lab environment before enterprise deployment to prevent disruption to specialized business applications.
- **Audit Mode**: Always run scripts with `-AuditOnly` initially to assess baseline compliance prior to applying active remediation.
- **Administrative Privileges**: Most Windows scripts require elevated Administrator permissions, and select Android settings modifications require ADB authorization or device owner privileges.

## Reporting a Vulnerability

If you discover an issue, bug, or security vulnerability within any script in this repository, please report it responsibly by opening a private GitHub Security Advisory or submitting an issue marked with the `security` tag.
