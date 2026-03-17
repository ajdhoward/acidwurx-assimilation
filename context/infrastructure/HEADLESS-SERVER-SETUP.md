# 🔌 HEADLESS SERVER SETUP - MARKSLONE

**Scripts ready for when markslone is online**

---

## 📁 Scripts Location

```
/home/adam/acidwurx-iac/scripts/
├── lockdown-firewall.sh      🔒 Firewall setup (sudo required)
├── disable-lid-close.sh      🔌 Lid close disable (sudo required)
└── setup-firewall.sh         📋 Original firewall script
```

---

## 🔒 1. FIREWALL LOCKDOWN

**Purpose:** Block all internet access, LAN only

```bash
ssh adam@192.168.1.179 'cd /home/adam/acidwurx-iac/scripts && sudo ./lockdown-firewall.sh'
```

**What it does:**
- ✅ Enables UFW firewall
- ✅ Blocks all incoming traffic by default
- ✅ Allows only LAN (192.168.1.0/24)
- ✅ Protects all 8 services

---

## 🔌 2. DISABLE LID CLOSE SHUTDOWN

**Purpose:** Keep server running when laptop lid is closed

```bash
ssh adam@192.168.1.179 'cd /home/adam/acidwurx-iac/scripts && sudo ./disable-lid-close.sh'
```

**What it does:**
- ✅ Configures systemd-logind
- ✅ Ignores lid close event
- ✅ System stays running (headless mode)
- ✅ Screen turns off (power saving)

**Settings applied:**
```
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

---

## 🚀 QUICK SETUP (Both at Once)

When markslone is online, run:

```bash
ssh adam@192.168.1.179 << 'EOF'
cd /home/adam/acidwurx-iac/scripts

echo "=== FIREWALL SETUP ==="
sudo ./lockdown-firewall.sh

echo ""
echo "=== LID CLOSE DISABLE ==="
sudo ./disable-lid-close.sh

echo ""
echo "✅ ALL SETUP COMPLETE!"
EOF
```

**Enter sudo password twice (once per script).**

---

## 🧪 VERIFY AFTER SETUP

### Check Firewall
```bash
ssh adam@192.168.1.179 'sudo ufw status verbose'
```

Should show:
```
Default: deny (incoming)
192.168.1.0/24 ALLOW for all service ports
```

### Check Lid Close Config
```bash
ssh adam@192.168.1.179 'grep HandleLidSwitch /etc/systemd/logind.conf'
```

Should show:
```
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

### Check Service Status
```bash
ssh adam@192.168.1.179 'docker ps --format "table {{.Names}}\t{{.Status}}"'
```

All 8 containers should be **Up**.

---

## 📊 SETUP CHECKLIST

| Task | Script | Sudo | Status |
|------|--------|------|--------|
| Firewall lockdown | lockdown-firewall.sh | ✅ Required | ⏳ Pending |
| Disable lid close | disable-lid-close.sh | ✅ Required | ⏳ Pending |
| Verify services | docker ps | ❌ Not needed | ✅ Ready |

---

**All scripts ready! Run when markslone is back online.** 🚀
