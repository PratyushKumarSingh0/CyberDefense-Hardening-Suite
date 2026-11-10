# CyberDefense Hardening Suite (100 Defense Scripts)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6.svg?logo=windows)](windows/)
[![Platform: Android](https://img.shields.io/badge/Platform-Android%2010%20to%2015-3DDC84.svg?logo=android)](android/)
[![MITRE ATT&CK](https://img.shields.io/badge/Framework-MITRE%20ATT%26CK-red.svg)](https://attack.mitre.org/)
[![Scripts Count](https://img.shields.io/badge/Defensive%20Scripts-100-success.svg)](#index-of-defensive-scripts)


 MITRE ATT&CK-aligned defensive cybersecurity arsenal featuring **100 modular scripts** designed to audit, harden, and protect **Windows endpoints** and **Android mobile devices** against cyber attacks, ransomware, credential theft, and unauthorized access.

---

## Table of Contents

- [Overview & Architecture](#overview--architecture)
- [Repository Structure](#repository-structure)
- [Quick Start Guide](#quick-start-guide)
  - [Windows Audit & Hardening](#windows-audit--hardening)
  - [Android Audit via ADB](#android-audit-via-adb)
- [Index of All 100 Defensive Scripts](#index-of-all-100-defensive-scripts)
  - [Windows Endpoint Defense (Scripts 001 - 050)](#windows-endpoint-defense-scripts-001---050)
    - [01. Network & Protocol Hardening (001 - 010)](#01-network--protocol-hardening-001---010)
    - [02. System Integrity & Exploit Protection (011 - 020)](#02-system-integrity--exploit-protection-011---020)
    - [03. Defender & Antivirus Configuration (021 - 030)](#03-defender--antivirus-configuration-021---030)
    - [04. Identity, Authentication & Access Control (031 - 040)](#04-identity-authentication--access-control-031---040)
    - [05. Auditing, Logging & Incident Readiness (041 - 050)](#05-auditing-logging--incident-readiness-041---050)
  - [Android Mobile Defense (Scripts 051 - 100)](#android-mobile-defense-scripts-051---100)
    - [01. Device Posture & OS Integrity (051 - 060)](#01-device-posture--os-integrity-051---060)
    - [02. Network & Wireless Hardening (061 - 070)](#02-network--wireless-hardening-061---070)
    - [03. Permissions & Application Security (071 - 080)](#03-permissions--application-security-071---080)
    - [04. Privacy & Telemetry Hardening (081 - 090)](#04-privacy--telemetry-hardening-081---090)
    - [05. Build-Time & DevSecOps Verification (091 - 100)](#05-build-time--devsecops-verification-091---100)
- [How to Upload to GitHub](#how-to-upload-to-github)
- [License & Disclaimer](#license--disclaimer)

---

## Overview & Architecture

Modern threat actors exploit unhardened legacy protocols, missing audit telemetry, default system credentials, and permissive mobile runtime configurations. The **CyberDefense Hardening Suite** provides a zero-trust, defense-in-depth posture:

- **100% Defensive Focus**: Designed for SOC analysts, system administrators, security engineers, and DevOps/SecOps teams.
- **Safe Auditing First**: All Windows scripts implement an `-AuditOnly` flag to assess deviations without modifying systems.
- **Cross-Platform**: Covers enterprise Windows workstations/servers and Android mobile endpoints/APKs.
- **Zero Third-Party Dependencies**: Windows scripts use native PowerShell (`powershell.exe`/`pwsh`) and CIM/WMI cmdlets; Android scripts use native POSIX shell (`/bin/sh`) compatible with `adb shell`.

---

## Repository Structure

```text
CyberDefense-Hardening-Suite/
├── .github/
│   └── workflows/
│       └── validate-scripts.yml       # GitHub Actions CI syntax & linting pipeline
├── windows/                           # 50 Windows Hardening & Audit Scripts
│   ├── 01_network_hardening/          # SMBv1, LLMNR, NetBIOS, TLS 1.3, RDP NLA, Firewall
│   ├── 02_system_integrity/           # Credential Guard, HVCI, Exploit Guard, AppLocker
│   ├── 03_defender_antivirus/         # Real-Time, ASR Rules, CFA Ransomware Guard, PUA
│   ├── 04_identity_access/            # Password Policy, Lockout, UAC, NTLMv2, Admin Audit
│   └── 05_audit_logging/              # Command-Line 4688, ScriptBlock, Sysmon, BitLocker
├── android/                           # 50 Android Hardening & Security Scripts
│   ├── 01_device_posture/             # FBE Encryption, SELinux, Root Detection, AVB
│   ├── 02_network_wireless/           # Private DNS (DoT), Wi-Fi Scanning, Always-On VPN
│   ├── 03_permissions_appsec/         # Overlays, Accessibility, Droppers, Secret Scanning
│   ├── 04_privacy_telemetry/          # Advertising ID, Sensor Mute, App Standby, Quarantine
│   └── 05_build_devsecops/            # Network Security Config, R8/ProGuard, Signatures
├── runners/
│   ├── run_windows_defense_audit.ps1  # Automated orchestrator for all 50 Windows checks
│   └── run_android_defense_audit.sh   # Automated ADB orchestrator for all 50 Android checks
├── CONTRIBUTING.md                    # Contribution guidelines
├── LICENSE                            # MIT License
├── README.md                          # Comprehensive documentation
└── SECURITY.md                        # Responsible disclosure policy
```

---

## Quick Start Guide

### Windows Audit & Hardening

Open an elevated PowerShell session (Run as Administrator):

```powershell
# 1. Run all 50 Windows defensive checks in safe read-only audit mode:
.\runners\run_windows_defense_audit.ps1

# 2. To apply active remediation and harden the host:
.\runners\run_windows_defense_audit.ps1 -Remediate

# 3. Or run any individual script with -AuditOnly:
.\windows\01_network_hardening\win_001_disable_smbv1.ps1 -AuditOnly
```

### Android Audit via ADB

Connect your Android device via USB with USB Debugging enabled, or connect to an emulator:

```bash
# 1. Verify device connectivity
adb devices

# 2. Run all 50 Android defensive checks:
sh ./runners/run_android_defense_audit.sh

# 3. Or run an individual script directly via adb shell:
adb shell "sh -s" < ./android/01_device_posture/and_051_verify_disk_encryption.sh
```

---

## Index of All 100 Defensive Scripts

### Windows Endpoint Defense (Scripts 001 - 050)

#### 01. Network & Protocol Hardening (001 - 010)
| Script ID | Script File | Defense Objective | Threat Prevented | MITRE ATT&CK |
|---|---|---|---|---|
| **WIN-001** | [`win_001_disable_smbv1.ps1`](windows/01_network_hardening/win_001_disable_smbv1.ps1) | Disable SMBv1 Protocol | WannaCry, EternalBlue, Lateral Movement | T1021.002 |
| **WIN-002** | [`win_002_disable_llmnr.ps1`](windows/01_network_hardening/win_002_disable_llmnr.ps1) | Disable LLMNR Multicast | Responder Credential Capture, Hash Interception | T1557.001 |
| **WIN-003** | [`win_003_disable_netbios.ps1`](windows/01_network_hardening/win_003_disable_netbios.ps1) | Disable NetBIOS over TCP/IP | NBT-NS Poisoning, NTLM Relay Attacks | T1557.001 |
| **WIN-004** | [`win_004_enable_smb_signing.ps1`](windows/01_network_hardening/win_004_enable_smb_signing.ps1) | Enforce SMB Packet Signing | SMB Relay & Man-in-the-Middle Spoofing | T1557 |
| **WIN-005** | [`win_005_enforce_tls13.ps1`](windows/01_network_hardening/win_005_enforce_tls13.ps1) | Enforce TLS 1.2/1.3 & Disable SSL | Downgrade Attacks, POODLE, Insecure Ciphers | T1573 |
| **WIN-006** | [`win_006_restrict_rdp_nla.ps1`](windows/01_network_hardening/win_006_restrict_rdp_nla.ps1) | Enforce RDP Network Level Auth (NLA) | BlueKeep (CVE-2019-0708), RDP Brute Force | T1021.001 |
| **WIN-007** | [`win_007_disable_wpad.ps1`](windows/01_network_hardening/win_007_disable_wpad.ps1) | Disable Web Proxy Auto-Discovery | WPAD Spoofing, MITM Web Traffic Redirection | T1557 |
| **WIN-008** | [`win_008_block_inbound_high_risk_ports.ps1`](windows/01_network_hardening/win_008_block_inbound_high_risk_ports.ps1) | Block High-Risk Inbound Ports | Lateral Probing on Ports 135, 137-139, 445 | T1046 |
| **WIN-009** | [`win_009_enforce_firewall_all_profiles.ps1`](windows/01_network_hardening/win_009_enforce_firewall_all_profiles.ps1) | Enforce Firewall on All Profiles | Ingress Scanning & Unauthorized Services | T1562.004 |
| **WIN-010** | [`win_010_block_anonymous_sam_enum.ps1`](windows/01_network_hardening/win_010_block_anonymous_sam_enum.ps1) | Restrict Anonymous SAM & Share Enum | Unauthenticated User & Share Enumeration | T1087.001 |

#### 02. System Integrity & Exploit Protection (011 - 020)
| Script ID | Script File | Defense Objective | Threat Prevented | MITRE ATT&CK |
|---|---|---|---|---|
| **WIN-011** | [`win_011_enable_credential_guard.ps1`](windows/02_system_integrity/win_011_enable_credential_guard.ps1) | Enable Windows Credential Guard | LSASS Memory Dumping, Mimikatz, Pass-the-Hash | T1003.001 |
| **WIN-012** | [`win_012_enable_hvci_memory_integrity.ps1`](windows/02_system_integrity/win_012_enable_hvci_memory_integrity.ps1) | Enable Hypervisor Code Integrity (HVCI) | Kernel Rootkits, Unsigned Malicious Drivers | T1068 |
| **WIN-013** | [`win_013_apply_exploit_guard_mitigations.ps1`](windows/02_system_integrity/win_013_apply_exploit_guard_mitigations.ps1) | Apply DEP, ASLR, and SEHOP | Buffer Overflows, ROP Gadgets, Memory Exploits | T1203 |
| **WIN-014** | [`win_014_enable_powershell_constrained_language.ps1`](windows/02_system_integrity/win_014_enable_powershell_constrained_language.ps1) | Enforce PowerShell Constrained Language | Fileless Malware, Reflective Assembly Loading | T1059.001 |
| **WIN-015** | [`win_015_deploy_applocker_rules.ps1`](windows/02_system_integrity/win_015_deploy_applocker_rules.ps1) | Enable AppLocker Identity Service | Untrusted Executables in Temp & AppData | T1204.002 |
| **WIN-016** | [`win_016_enforce_signed_powershell_scripts.ps1`](windows/02_system_integrity/win_016_enforce_signed_powershell_scripts.ps1) | Enforce RemoteSigned Script Policy | Execution of Unsigned Internet Scripts | T1059.001 |
| **WIN-017** | [`win_017_block_office_internet_macros.ps1`](windows/02_system_integrity/win_017_block_office_internet_macros.ps1) | Block Office Macros from Internet Origin | Malicious Phishing Documents (Emotet, Qakbot) | T1566.001 |
| **WIN-018** | [`win_018_disable_windows_script_host.ps1`](windows/02_system_integrity/win_018_disable_windows_script_host.ps1) | Disable Windows Script Host (WSH) | VBScript / JScript Malware Droppers | T1059.005 |
| **WIN-019** | [`win_019_disable_powershell_v2.ps1`](windows/02_system_integrity/win_019_disable_powershell_v2.ps1) | Disable Legacy PowerShell v2.0 | Version Downgrade Attacks to Bypass AMSI | T1562.001 |
| **WIN-020** | [`win_020_enable_application_guard.ps1`](windows/02_system_integrity/win_020_enable_application_guard.ps1) | Audit Application Guard Availability | Browser Drive-by Downloads & Zero-Day Exploits | T1189 |

#### 03. Defender & Antivirus Configuration (021 - 030)
| Script ID | Script File | Defense Objective | Threat Prevented | MITRE ATT&CK |
|---|---|---|---|---|
| **WIN-021** | [`win_021_configure_defender_realtime.ps1`](windows/03_defender_antivirus/win_021_configure_defender_realtime.ps1) | Enforce Real-Time & Script Scanning | Antivirus Evasion, Fileless Script Execution | T1562.001 |
| **WIN-022** | [`win_022_enable_asr_block_rules.ps1`](windows/03_defender_antivirus/win_022_enable_asr_block_rules.ps1) | Enable Attack Surface Reduction Rules | Office Spawning Child Processes, LSASS Stealing | T1059, T1003 |
| **WIN-023** | [`win_023_enable_pua_pup_protection.ps1`](windows/03_defender_antivirus/win_023_enable_pua_pup_protection.ps1) | Enable PUA / PUP Protection | Adware, Coin Miners, Bundled Spyware | T1496 |
| **WIN-024** | [`win_024_schedule_automated_scans.ps1`](windows/03_defender_antivirus/win_024_schedule_automated_scans.ps1) | Schedule Daily Quick & Weekly Full Scan | Dormant Malware & Persistent Rootkits | T1059 |
| **WIN-025** | [`win_025_enable_controlled_folder_access.ps1`](windows/03_defender_antivirus/win_025_enable_controlled_folder_access.ps1) | Enable Controlled Folder Access | Ransomware Data Encryption Attacks | T1486 |
| **WIN-026** | [`win_026_block_untrusted_usb_executables.ps1`](windows/03_defender_antivirus/win_026_block_untrusted_usb_executables.ps1) | Block Binaries from Removable Storage | BadUSB, Removable Media Worms, Stuxnet Vector | T1091 |
| **WIN-027** | [`win_027_enable_network_protection_block.ps1`](windows/03_defender_antivirus/win_027_enable_network_protection_block.ps1) | Enable Network Protection in Block Mode | C2 Beaconing, Phishing Domain Communication | T1071 |
| **WIN-028** | [`win_028_enable_behavior_monitoring.ps1`](windows/03_defender_antivirus/win_028_enable_behavior_monitoring.ps1) | Enforce Heuristic Behavior Monitoring | Polymorphic Payloads & Obfuscated Malware | T1027 |
| **WIN-029** | [`win_029_enforce_defender_sig_updates.ps1`](windows/03_defender_antivirus/win_029_enforce_defender_sig_updates.ps1) | Audit & Enforce Daily AV Signatures | Vulnerabilities Explaining Known Threat Signatures | T1204 |
| **WIN-030** | [`win_030_isolate_compromised_endpoint.ps1`](windows/03_defender_antivirus/win_030_isolate_compromised_endpoint.ps1) | Emergency Endpoint Isolation Script | Ransomware Lateral Spread, Active Exfiltration | T1021, T1041 |

#### 04. Identity, Authentication & Access Control (031 - 040)
| Script ID | Script File | Defense Objective | Threat Prevented | MITRE ATT&CK |
|---|---|---|---|---|
| **WIN-031** | [`win_031_enforce_password_policy.ps1`](windows/04_identity_access/win_031_enforce_password_policy.ps1) | Enforce Password Length (14+) & History | Password Spraying, Weak Dictionary Credentials | T1110 |
| **WIN-032** | [`win_032_configure_account_lockout.ps1`](windows/04_identity_access/win_032_configure_account_lockout.ps1) | Enforce Lockout at 5 Failed Attempts | Brute Force Attacks, Automated Credential Stuffing | T1110.001 |
| **WIN-033** | [`win_033_disable_guest_account.ps1`](windows/04_identity_access/win_033_disable_guest_account.ps1) | Disable Built-in Guest Account | Unauthenticated Anonymous System Access | T1078.001 |
| **WIN-034** | [`win_034_rename_built_in_admin.ps1`](windows/04_identity_access/win_034_rename_built_in_admin.ps1) | Audit Built-in Administrator Name | Default Administrator Credential Guessing | T1110 |
| **WIN-035** | [`win_035_enforce_uac_maximum_level.ps1`](windows/04_identity_access/win_035_enforce_uac_maximum_level.ps1) | Enforce Maximum UAC on Secure Desktop | Silent Elevation, UAC Bypass Techniques | T1548.002 |
| **WIN-036** | [`win_036_deny_ntlmv1_and_lm.ps1`](windows/04_identity_access/win_036_deny_ntlmv1_and_lm.ps1) | Restrict NTLM to NTLMv2 Only | Rainbow Table Cracking, NTLMv1 Downgrades | T1557.001 |
| **WIN-037** | [`win_037_restrict_rdp_admin_group.ps1`](windows/04_identity_access/win_037_restrict_rdp_admin_group.ps1) | Audit Remote Desktop Users Group | Overprivileged Remote Desktop Access | T1021.001 |
| **WIN-038** | [`win_038_disable_insecure_cached_logons.ps1`](windows/04_identity_access/win_038_disable_insecure_cached_logons.ps1) | Restrict Cached Domain Logons | DCC2 / mscache2 Offline Hash Extraction | T1003.002 |
| **WIN-039** | [`win_039_verify_mfa_smartcard_policy.ps1`](windows/04_identity_access/win_039_verify_mfa_smartcard_policy.ps1) | Audit Windows Hello / MFA Policy | Stolen Password Replay Attacks | T1078 |
| **WIN-040** | [`win_040_audit_local_administrators.ps1`](windows/04_identity_access/win_040_audit_local_administrators.ps1) | Audit Local Administrator Members | Rogue Backdoor Accounts, Shadow Admins | T1098 |

#### 05. Auditing, Logging & Incident Readiness (041 - 050)
| Script ID | Script File | Defense Objective | Threat Prevented | MITRE ATT&CK |
|---|---|---|---|---|
| **WIN-041** | [`win_041_enable_process_creation_commandline_audit.ps1`](windows/05_audit_logging/win_041_enable_process_creation_commandline_audit.ps1) | Enable Command-Line Process Auditing (4688) | Living-off-the-Land Binaries (LOLBins) | T1059 |
| **WIN-042** | [`win_042_enable_powershell_scriptblock_logging.ps1`](windows/05_audit_logging/win_042_enable_powershell_scriptblock_logging.ps1) | Enable Deep Script Block Logging (4104) | In-Memory Obfuscated PowerShell Attacks | T1059.001 |
| **WIN-043** | [`win_043_enable_powershell_transcription.ps1`](windows/05_audit_logging/win_043_enable_powershell_transcription.ps1) | Enable Centralized Session Transcription | Non-Repudiation, Interactive Shell Forensics | T1059.001 |
| **WIN-044** | [`win_044_configure_event_log_capacity.ps1`](windows/05_audit_logging/win_044_configure_event_log_capacity.ps1) | Enforce 1GB+ Security Event Log Size | Log Wrapping, Anti-Forensic Overwrites | T1070.001 |
| **WIN-045** | [`win_045_enable_dns_client_query_logging.ps1`](windows/05_audit_logging/win_045_enable_dns_client_query_logging.ps1) | Enable DNS Operational Query Logging | DNS Tunneling, Fast-Flux, Stealth C2 Lookups | T1071.004 |
| **WIN-046** | [`win_046_verify_sysmon_active.ps1`](windows/05_audit_logging/win_046_verify_sysmon_active.ps1) | Audit Sysmon Service & Driver State | EDR / SIEM Blind Spots, Process Injection | T1562.001 |
| **WIN-047** | [`win_047_audit_world_writable_directories.ps1`](windows/05_audit_logging/win_047_audit_world_writable_directories.ps1) | Scan PATH Dirs for Unprivileged Write | DLL Search Order Hijacking, Privilege Escalation | T1574.001 |
| **WIN-048** | [`win_048_enforce_bitlocker_encryption_audit.ps1`](windows/05_audit_logging/win_048_enforce_bitlocker_encryption_audit.ps1) | Audit BitLocker Protection on OS Drive | Physical Theft, Offline File Extraction | T1200 |
| **WIN-049** | [`win_049_disable_unnecessary_services.ps1`](windows/05_audit_logging/win_049_disable_unnecessary_services.ps1) | Disable RemoteRegistry & Insecure Services | Unauthenticated Remote Service Exploitation | T1021 |
| **WIN-050** | [`win_050_collect_autoruns_triage_snapshot.ps1`](windows/05_audit_logging/win_050_collect_autoruns_triage_snapshot.ps1) | Snapshot Registry Run Keys & Persistence | Persistence Detection & Baseline Deviations | T1547.001 |

---

### Android Mobile Defense (Scripts 051 - 100)

#### 01. Device Posture & OS Integrity (051 - 060)
| Script ID | Script File | Defense Objective | Threat Prevented |
|---|---|---|---|
| **AND-051** | [`and_051_verify_disk_encryption.sh`](android/01_device_posture/and_051_verify_disk_encryption.sh) | Verify File-Based Encryption (FBE) | Physical NAND Extraction, Lost Device Exposure |
| **AND-052** | [`and_052_verify_selinux_enforcing.sh`](android/01_device_posture/and_052_verify_selinux_enforcing.sh) | Verify SELinux Enforcing Status | Kernel Exploits, Sandbox Escapes, Root Exploits |
| **AND-053** | [`and_053_audit_developer_options.sh`](android/01_device_posture/and_053_audit_developer_options.sh) | Audit Developer Options & ADB Debugging | Juice Jacking, Rogue USB Debugging Exploits |
| **AND-054** | [`and_054_audit_unknown_sources_sideload.sh`](android/01_device_posture/and_054_audit_unknown_sources_sideload.sh) | Audit Unknown Sources Sideloading Policy | Malicious 3rd-Party APK Installations |
| **AND-055** | [`and_055_check_security_patch_level.sh`](android/01_device_posture/and_055_check_security_patch_level.sh) | Audit Security Patch Level (SPL) Freshness | Known Unpatched Android Framework CVEs |
| **AND-056** | [`and_056_detect_root_and_su_binaries.sh`](android/01_device_posture/and_056_detect_root_and_su_binaries.sh) | Detect Su Binaries & Magisk Indicators | OS Integrity Compromise, Elevated Privilege Abuse |
| **AND-057** | [`and_057_audit_user_ca_certificates.sh`](android/01_device_posture/and_057_audit_user_ca_certificates.sh) | Audit User-Installed CA Certificates | TLS MITM Proxy Interception & Traffic Snooping |
| **AND-058** | [`and_058_hide_sensitive_lockscreen_notifications.sh`](android/01_device_posture/and_058_hide_sensitive_lockscreen_notifications.sh) | Hide Private Lock Screen Notifications | Shoulder Surfing, 2FA SMS Code Interception |
| **AND-059** | [`and_059_verify_android_verified_boot.sh`](android/01_device_posture/and_059_verify_android_verified_boot.sh) | Verify Android Verified Boot (AVB Green) | Bootloader Tampering, Evil Maid Physical Attacks |
| **AND-060** | [`and_060_audit_installed_packages.sh`](android/01_device_posture/and_060_audit_installed_packages.sh) | Inventory 3rd-Party Non-System Apps | Stealth Spyware Apps & Unauthorized Sideloads |

#### 02. Network & Wireless Hardening (061 - 070)
| Script ID | Script File | Defense Objective | Threat Prevented |
|---|---|---|---|
| **AND-061** | [`and_061_enforce_private_dns_dot.sh`](android/02_network_wireless/and_061_enforce_private_dns_dot.sh) | Enforce Private DNS (DNS-over-TLS) | Public Wi-Fi DNS Spoofing & ISP Eavesdropping |
| **AND-062** | [`and_062_disable_open_wifi_autoconnect.sh`](android/02_network_wireless/and_062_disable_open_wifi_autoconnect.sh) | Disable Open Wi-Fi Auto-Connect | Evil Twin Wi-Fi & Rogue Hotspot Interception |
| **AND-063** | [`and_063_disable_bluetooth_scanning.sh`](android/02_network_wireless/and_063_disable_bluetooth_scanning.sh) | Disable Background Bluetooth Scanning | Physical BLE Beacon Tracking & Profiling |
| **AND-064** | [`and_064_restrict_background_cellular_data.sh`](android/02_network_wireless/and_064_restrict_background_cellular_data.sh) | Audit & Restrict Background Data | Covert Background C2 Communication |
| **AND-065** | [`and_065_enforce_always_on_vpn.sh`](android/02_network_wireless/and_065_enforce_always_on_vpn.sh) | Audit Always-On VPN with Lockdown | Cleartext Data Leaks Outside Encrypted Tunnel |
| **AND-066** | [`and_066_audit_listening_network_ports.sh`](android/02_network_wireless/and_066_audit_listening_network_ports.sh) | Audit Listening Local Sockets & Ports | Stealth Local Backdoors & Insecure IPC Ports |
| **AND-067** | [`and_067_disable_nfc_beam_when_idle.sh`](android/02_network_wireless/and_067_disable_nfc_beam_when_idle.sh) | Audit NFC / Android Beam State | Proximity Relay Exploits & Unauthorized Tags |
| **AND-068** | [`and_068_detect_cleartext_traffic_candidates.sh`](android/02_network_wireless/and_068_detect_cleartext_traffic_candidates.sh) | Audit Cleartext HTTP Traffic Policy | Unencrypted Network Communication |
| **AND-069** | [`and_069_audit_hotspot_tethering_state.sh`](android/02_network_wireless/and_069_audit_hotspot_tethering_state.sh) | Audit Tethering & Mobile Hotspot | Unauthorized Network Bridging & Exfiltration |
| **AND-070** | [`and_070_verify_wifi_wpa3_readiness.sh`](android/02_network_wireless/and_070_verify_wifi_wpa3_readiness.sh) | Audit WPA3 / SAE Wi-Fi Security | KRACK Attacks & Weak WPA2 Handshake Cracking |

#### 03. Permissions & Application Security (071 - 080)
| Script ID | Script File | Defense Objective | Threat Prevented |
|---|---|---|---|
| **AND-071** | [`and_071_audit_dangerous_permissions.sh`](android/03_permissions_appsec/and_071_audit_dangerous_permissions.sh) | Audit Dangerous Permissions (SMS, Mic, GPS) | Overprivileged Spyware & Unauthorized Surveillance |
| **AND-072** | [`and_072_audit_system_alert_window_overlays.sh`](android/03_permissions_appsec/and_072_audit_system_alert_window_overlays.sh) | Audit `SYSTEM_ALERT_WINDOW` Overlays | Overlay Attacks, Banking Phishing, Tapjacking |
| **AND-073** | [`and_073_audit_accessibility_services.sh`](android/03_permissions_appsec/and_073_audit_accessibility_services.sh) | Audit Active Accessibility Services | Banking Trojans, Keyloggers, Auto-Clickers |
| **AND-074** | [`and_074_audit_usage_stats_permissions.sh`](android/03_permissions_appsec/and_074_audit_usage_stats_permissions.sh) | Audit `PACKAGE_USAGE_STATS` Access | App Usage Tracking & Context-Aware Exploits |
| **AND-075** | [`and_075_audit_all_files_storage_access.sh`](android/03_permissions_appsec/and_075_audit_all_files_storage_access.sh) | Audit `MANAGE_EXTERNAL_STORAGE` Privileges | Ransomware Encryption & Mass Data Scraping |
| **AND-076** | [`and_076_audit_install_packages_permission.sh`](android/03_permissions_appsec/and_076_audit_install_packages_permission.sh) | Audit `REQUEST_INSTALL_PACKAGES` Droppers | Malicious Droppers & Secondary Trojan Payloads |
| **AND-077** | [`and_077_audit_active_device_administrators.sh`](android/03_permissions_appsec/and_077_audit_active_device_administrators.sh) | Audit Active Device Administrator Apps | Ransomware Screen Lockers & Remote Wipe Abuse |
| **AND-078** | [`and_078_revoke_dormant_app_permissions.sh`](android/03_permissions_appsec/and_078_revoke_dormant_app_permissions.sh) | Revoke Sensitive Permissions from Package | Privilege Creep in Dormant or Suspicious Apps |
| **AND-079** | [`and_079_audit_apk_manifest_exported_components.sh`](android/03_permissions_appsec/and_079_audit_apk_manifest_exported_components.sh) | Audit Exported Activities, Services, Receivers | Intent Spoofing, Insecure IPC, Auth Bypass |
| **AND-080** | [`and_080_scan_apk_for_embedded_secrets.sh`](android/03_permissions_appsec/and_080_scan_apk_for_embedded_secrets.sh) | Scan Code & APK for Hardcoded API Keys | Leaked Cloud Credentials, Tokens, Bearer Keys |

#### 04. Privacy & Telemetry Hardening (081 - 090)
| Script ID | Script File | Defense Objective | Threat Prevented |
|---|---|---|---|
| **AND-081** | [`and_081_reset_google_advertising_id.sh`](android/04_privacy_telemetry/and_081_reset_google_advertising_id.sh) | Audit Advertising ID & Opt-Out State | Cross-App Behavioral Profiling & Ad Tracking |
| **AND-082** | [`and_082_disable_usage_and_diagnostics_telemetry.sh`](android/04_privacy_telemetry/and_082_disable_usage_and_diagnostics_telemetry.sh) | Disable Diagnostic Telemetry Reporting | Telemetry Metadata Leakage & Diagnostic Logs |
| **AND-083** | [`and_083_restrict_coarse_fine_location_access.sh`](android/04_privacy_telemetry/and_083_restrict_coarse_fine_location_access.sh) | Audit Location Providers & Wi-Fi Scanning | Geolocation Fingerprinting & Covert Tracking |
| **AND-084** | [`and_084_disable_google_location_history.sh`](android/04_privacy_telemetry/and_084_disable_google_location_history.sh) | Audit Location History Logging Baseline | Persistent Physical Movement Tracking |
| **AND-085** | [`and_085_disable_clipboard_read_alerts.sh`](android/04_privacy_telemetry/and_085_disable_clipboard_read_alerts.sh) | Enforce Visual Clipboard Access Alerts | Silent Background Clipboard Snooping |
| **AND-086** | [`and_086_audit_sensor_privacy_toggles.sh`](android/04_privacy_telemetry/and_086_audit_sensor_privacy_toggles.sh) | Audit Hardware Mic/Camera Killswitches | Unauthorized Microphone/Camera Eavesdropping |
| **AND-087** | [`and_087_enforce_background_execution_limits.sh`](android/04_privacy_telemetry/and_087_enforce_background_execution_limits.sh) | Enforce Background Execution Restrictions | Battery Drain from Stealth Crypto-Miners/Bots |
| **AND-088** | [`and_088_clear_keyboard_learning_dictionaries.sh`](android/04_privacy_telemetry/and_088_clear_keyboard_learning_dictionaries.sh) | Audit User Keyboard Dictionary Words | Credentials & Passwords Cached in Keyboard IME |
| **AND-089** | [`and_089_disable_nearby_device_scanning.sh`](android/04_privacy_telemetry/and_089_disable_nearby_device_scanning.sh) | Disable Nearby Share Background Beaconing | Device Proximity Tracking & Rogue File Pushes |
| **AND-090** | [`and_090_quarantine_suspicious_package.sh`](android/04_privacy_telemetry/and_090_quarantine_suspicious_package.sh) | Emergency Package Quarantine & Freeze | Active Mobile Malware Infection Containment |

#### 05. Build-Time & DevSecOps Verification (091 - 100)
| Script ID | Script File | Defense Objective | Threat Prevented |
|---|---|---|---|
| **AND-091** | [`and_091_verify_network_security_config_xml.sh`](android/05_build_devsecops/and_091_verify_network_security_config_xml.sh) | Verify `cleartextTrafficPermitted=false` | Insecure Cleartext HTTP Communication |
| **AND-092** | [`and_092_verify_r8_proguard_minification.sh`](android/05_build_devsecops/and_092_verify_r8_proguard_minification.sh) | Verify R8 / ProGuard Minification | Reverse Engineering & Code Decompilation |
| **AND-093** | [`and_093_audit_apk_debuggable_flag.sh`](android/05_build_devsecops/and_093_audit_apk_debuggable_flag.sh) | Verify `android:debuggable="false"` in APK | JDWP Memory Injection & Runtime Exploitation |
| **AND-094** | [`and_094_verify_allow_backup_is_disabled.sh`](android/05_build_devsecops/and_094_verify_allow_backup_is_disabled.sh) | Verify `android:allowBackup="false"` | Local ADB Backup Extraction Attacks |
| **AND-095** | [`and_095_verify_apk_v2_v3_signature.sh`](android/05_build_devsecops/and_095_verify_apk_v2_v3_signature.sh) | Enforce APK Signing Scheme v2/v3/v4 | Janus Vulnerability & APK Tampering |
| **AND-096** | [`and_096_scan_gradle_dependencies_cve.sh`](android/05_build_devsecops/and_096_scan_gradle_dependencies_cve.sh) | Audit Gradle for Dependency Vulnerabilities | Vulnerable 3rd-Party SDKs & Supply Chain Risks |
| **AND-097** | [`and_097_audit_content_provider_grant_uri.sh`](android/05_build_devsecops/and_097_audit_content_provider_grant_uri.sh) | Audit ContentProvider URI Permissions | Database Leaks & Unauthorized File Sharing |
| **AND-098** | [`and_098_verify_deep_link_auto_verify.sh`](android/05_build_devsecops/and_098_verify_deep_link_auto_verify.sh) | Enforce App Links `autoVerify="true"` | Deep Link / Intent Hijacking Attacks |
| **AND-099** | [`and_099_enforce_biometric_crypto_strongbox.sh`](android/05_build_devsecops/and_099_enforce_biometric_crypto_strongbox.sh) | Audit Hardware StrongBox KeyStore Usage | In-Memory Cryptographic Key Extraction |
| **AND-100** | [`and_100_generate_android_security_scorecard.sh`](android/05_build_devsecops/and_100_generate_android_security_scorecard.sh) | Generate Android Security Scorecard | Comprehensive Device Security Posture Blindspots |

---

## How to Upload to GitHub

Follow these steps to publish this complete repository to your GitHub account:

### 1. Initialize Git and Commit
Open PowerShell or your terminal in the repository folder:

```powershell
cd "C:\Users\praty\.gemini\antigravity\scratch\CyberDefense-Hardening-Suite"

# Initialize git repository
git init -b main

# Stage all 100 defensive scripts and metadata files
git add .

# Create the initial commit
git commit -m "feat: Initial commit of CyberDefense Hardening Suite (100 defensive scripts for Windows and Android)"
```

### 2. Create a Remote Repository on GitHub
1. Go to [GitHub.com](https://github.com) and click **New Repository**.
2. Name it `CyberDefense-Hardening-Suite` (or your preferred name).
3. Leave it empty (do **not** check "Add README", ".gitignore", or "license", since these are already included).
4. Click **Create repository**.

### 3. Push to Your GitHub Account
Copy your repository URL from GitHub and run:

```powershell
# Link your local repo to GitHub (replace with your actual GitHub username)
git remote add origin https://github.com/PratyushKumarSingh0/CyberDefense-Hardening-Suite.git

# Push the main branch
git push -u origin main
```

---

## License & Disclaimer

This project is licensed under the [MIT License](LICENSE).

> **Disclaimer**: This suite is intended strictly for authorized security auditing, system hardening, and defensive posture evaluation. Always test hardening scripts in a staging or development environment before applying active remediation to production infrastructure.
