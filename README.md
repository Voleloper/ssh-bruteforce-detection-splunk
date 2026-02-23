# 🔐 SSH Brute-Force Detection in Splunk

## 🧭 Project Summary

This detection engineering lab simulates SSH brute-force attacks and demonstrates how a SOC analyst can identify credential abuse using Splunk analytics.

The project focuses on transforming raw Linux authentication logs into actionable security alerts with minimal false positives.

---

## 🏗️ Lab Architecture

Attacker (Kali) → Victim (Ubuntu SSH) → Log Forwarding → Splunk SIEM

---

## ⚔️ Attack Simulation

```bash
chmod +x hydra_bruteforce.sh
./hydra_bruteforce.sh <TARGET_IP>
```

The attack generates multiple failed SSH authentication attempts visible in `/var/log/auth.log`.

---

## 🔍 Detection Strategy

The detection identifies:

* Repeated failed logins
* Time-bucketed spikes
* Single-source brute force behavior

### SPL Logic

```spl
index=linux_logs sourcetype=authlog
"Failed password"
| bucket _time span=5m
| stats count by src_ip, _time
| where count >= 10
```

---

## 🚨 Alert Design

* Threshold: ≥10 failures / 5 minutes
* Severity: Medium → High
* MITRE Technique: T1110 (Brute Force)

---

## 📊 Investigation Workflow

1. Review source IP
2. Check success after failures
3. Correlate with geo-location
4. Validate user account targeted

---

## 🎯 Key Detection Insights

* Password spraying vs brute force differentiation
* Importance of time bucketing
* Noise reduction strategies

---

## 🔮 Future Enhancements

* Risk-based alerting
* GeoIP enrichment
* UEBA integration
* SOAR auto-response

---

## ⚠️ Legal Notice

This project is intended for authorized lab environments only.
