# 🔒 FIREWALL SETUP REQUIRED

**IMPORTANT:** You need to run the firewall script ONCE on markslone.

---

## 📋 Run This Command on markslone

SSH to markslone and run:

```bash
ssh adam@192.168.1.179
cd /home/adam
./setup-firewall.sh
```

**Enter your sudo password when prompted.**

---

## 🔐 What This Does

| Rule | Access From | Purpose |
|------|-------------|---------|
| SSH (22) | 192.168.1.0/24 | SSH from LAN only |
| Grafana (3000) | 192.168.1.0/24 | LAN only |
| Technitium (8080) | 192.168.1.0/24 | LAN only |
| Home Assistant (8123) | 192.168.1.0/24 | LAN only |
| Prometheus (9090) | 192.168.1.0/24 | LAN only |
| Node-RED (1880) | 192.168.1.0/24 | LAN only |
| Stremio (11470) | 192.168.1.0/24 | LAN only |
| DNS (53, 853) | 192.168.1.0/24 | LAN only |
| **ALL OTHER** | ❌ BLOCKED | Internet blocked |

---

## ✅ After Running

Your services will be:
- ✅ Accessible from your PC (192.168.1.164)
- ✅ Accessible from any LAN device (192.168.1.x)
- ❌ **NOT accessible from internet** (blocked by firewall)

---

## 🧪 Verify Firewall

After running the script:

```bash
sudo ufw status verbose
```

Should show:
```
Default: deny (incoming), allow (outgoing), deny (routed)
New connections: deny

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    192.168.1.0/24
3000/tcp                   ALLOW IN    192.168.1.0/24
8080/tcp                   ALLOW IN    192.168.1.0/24
... (all services LAN only)
```

---

**Run this now to lock down your services!** 🔒
