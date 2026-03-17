# 🎬 ACIDWURX STREMIO BESPOKE PLATFORM - MASTER PLAN

**Version**: 1.0  
**Date**: 2026-03-17  
**Status**: Planning Phase

---

## 🎯 EXECUTIVE SUMMARY

**Vision**: Create a fully customized Stremio experience with deep home automation integration, featuring pause-on-call, IoT triggers, and bespoke UI.

**Key Finding**: ✅ **Home Assistant is already running** on `markslone:192.168.1.179:8123` - this enables ALL IoT integration features!

---

## 📊 PART 1: CAN WE CREATE A BESPOKE STREMIO LAYOUT?

### ✅ YES - Three Approaches Available

| Approach | Complexity | Customization Level | Recommended |
|----------|------------|---------------------|-------------|
| **1. Stremio Enhanced Fork** | Low | Themes + Plugins | ⭐ Start Here |
| **2. WuPlay Fork** | Medium | Multi-profile + Web config | For advanced needs |
| **3. Custom Web UI** | High | Full control | Ultimate goal |

---

### Option 1: Stremio Enhanced (RECOMMENDED START)

**GitHub**: https://github.com/REVENGE977/stremio-enhanced

**Features**:
| Feature | Description |
|---------|-------------|
| 🎨 **Themes** | CSS-based visual customization |
| 🔌 **Plugins** | JavaScript functionality extensions |
| 💬 **Discord Rich Presence** | Built-in activity sharing |
| 🖥️ **Electron-Based** | Desktop app with full control |
| ⚙️ **Auto Server** | Background streaming service |

**What You Can Customize**:
- Colors, fonts, layouts via CSS
- Add custom buttons/menus via JavaScript
- Modify sidebar, header, card layouts
- Add new settings panels
- Integrate external APIs

**Limitations**:
- Still bound by Stremio Web structure
- Major UI changes require fork maintenance
- Updates may break customizations

---

### Option 2: WuPlay Fork

**Website**: https://wuplay.app

**Features**:
| Feature | Standard Stremio | WuPlay |
|---------|-----------------|--------|
| Account Required | ✅ Yes | ❌ No |
| Multi-Profile | ❌ No | ✅ Yes |
| Web Configurator | ❌ No | ✅ Yes |
| IP Tracking | ✅ Yes | ❌ No |
| UI Polish | ⭐⭐⭐⭐ | ⭐⭐⭐ |

**Best For**: Privacy-focused, multi-user households

---

### Option 3: Custom Web UI (ULTIMATE GOAL)

**What This Means**: Build a completely custom frontend that:
- Uses Stremio addon protocol (manifest.json, stream, meta endpoints)
- Renders content with your own HTML/CSS/JS
- Integrates Home Assistant directly
- Full control over every pixel

**Tech Stack**:
```
Frontend: React/Vue.js + Tailwind CSS
Backend: Node.js/Express (proxy to Stremio addons)
Integration: Home Assistant WebSocket API
Player: Video.js or Plyr with custom controls
```

**Timeline**: 4-6 weeks for MVP

---

## 📱 PART 2: APPS THAT USE STREMIO ADDONS

### Existing Stremio-Based Applications

| App | Platform | Unique Features | Price |
|-----|----------|-----------------|-------|
| **Stremio (Official)** | All platforms | Standard experience | Free |
| **WuPlay** | Android TV/Fire TV | Multi-profile, no account | Free |
| **Stremio Enhanced** | Windows/Linux/Mac | Themes, plugins, Discord | Free |
| **Syncler** | Android TV | Premium UI, debrid focus | $2/month |
| **Weyd** | Android TV | Clean interface, cloud sync | $1.50/month |
| **DebridStream** | Android | Multi-debrid support | $1/month |
| **TorZ** | Web/Android | Torrent + debrid hybrid | Free |

### Feature Comparison Table

| Feature | Stremio | WuPlay | Syncler | **Your Bespoke** |
|---------|---------|--------|---------|------------------|
| Addon Support | ✅ Full | ✅ Full | ⚠️ Limited | ✅ Full (planned) |
| Multi-Profile | ❌ | ✅ | ✅ | ✅ (planned) |
| Web Config | ❌ | ✅ | ❌ | ✅ (planned) |
| Custom Themes | ⚠️ Limited | ❌ | ❌ | ✅ (planned) |
| Home Assistant | ❌ | ❌ | ❌ | ✅ (PLANNED) |
| Pause on Call | ❌ | ❌ | ❌ | ✅ (PLANNED) |
| IoT Triggers | ❌ | ❌ | ❌ | ✅ (PLANNED) |
| Voice Control | ❌ | ❌ | ⚠️ Alexa | ✅ (planned) |
| Local Health Monitor | ❌ | ❌ | ❌ | ✅ (DONE) |

---

## 🏠 PART 3: HOME ASSISTANT INTEGRATION (ALREADY RUNNING!)

### Current Setup Discovered

```
✅ Home Assistant: http://192.168.1.179:8123
✅ Docker Compose: homeassistant.yml configured
✅ MCP Server: homeassistant-mcp available
✅ MQTT Broker: Running for IoT devices
```

### Integration Possibilities

| Feature | How It Works | Complexity |
|---------|-------------|------------|
| **Pause on Phone Call** | Home Assistant detects call → Sends pause command to Stremio | Medium |
| **Pause on Doorbell** | Doorbell rings → Pause playback | Easy |
| **Lights Dim on Play** | Playback starts → Dim smart lights | Easy |
| **Phone as Remote** | Home Assistant Companion app → Media controls | Easy |
| **Voice Control** | Alexa/Google → "Pause Stremio" | Medium |
| **Presence Detection** | Leave home → Pause, return → Resume | Medium |
| **Bedtime Automation** | 11 PM → Fade volume, pause after 10 min | Easy |
| **Multi-Room Sync** | Same content on multiple TVs | Hard |

---

## 🔔 PART 4: PAUSE-ON-CALL IMPLEMENTATION

### Technical Approach

```
┌─────────────────────────────────────────────────────────────┐
│  CALL DETECTION METHODS                                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Android Phone (Samsung A04s)                           │
│     • Tasker/Automate app detects call state              │
│     • Sends webhook to Home Assistant                      │
│     • HA sends pause command to Stremio                    │
│                                                             │
│  2. VoIP/SIP Calls                                         │
│     • Asterisk/FreePBX webhook on incoming call           │
│     • Direct Home Assistant integration                    │
│                                                             │
│  3. Network Monitoring                                     │
│     • Detect VoIP traffic pattern                          │
│     • Trigger automation via packet analysis               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  HOME ASSISTANT AUTOMATION                                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  trigger:                                                  │
│    platform: webhook                                        │
│    webhook_id: stremio_pause_on_call                       │
│                                                             │
│  action:                                                   │
│    - service: media_player.media_pause                     │
│      target:                                               │
│        entity_id: media_player.stremio_tv                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│  STREMIO CONTROL METHODS                                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Home Assistant Media Player Integration                │
│     • Install "Stremio" custom component in HA            │
│     • Exposes play/pause/seek as HA entities              │
│                                                             │
│  2. WebSocket API                                           │
│     • Custom Node.js service listens for HA events        │
│     • Sends keyboard/input commands to Stremio            │
│                                                             │
│  3. ADB Control (Android TV/Fire Stick)                    │
│     • HA sends ADB command: `input keyevent 85` (pause)   │
│     • Works on Fire TV Cube/Stick                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Recommended Implementation

**For Your Setup (Samsung A04s + Fire TV/Fire Stick)**:

```yaml
# Home Assistant Automation (configuration.yaml)

automation:
  - alias: "Pause Stremio on Phone Call"
    trigger:
      platform: webhook
      webhook_id: pause_stremio_call_start
    action:
      - service: remote.send_command
        target:
          entity_id: remote.fire_tv_cube
        data:
          command:
            - key: "HOME"  # Pause playback

  - alias: "Resume Stremio After Call"
    trigger:
      platform: webhook
      webhook_id: resume_stremio_call_end
    action:
      - service: remote.send_command
        target:
          entity_id: remote.fire_tv_cube
        data:
          command:
            - key: "SELECT"  # Resume playback
```

**On Samsung A04s (Termux + Tasker)**:
```bash
# Tasker HTTP Request on Call Incoming:
POST http://192.168.1.179:8123/api/webhook/pause_stremio_call_start

# Tasker HTTP Request on Call Ended:
POST http://192.168.1.179:8123/api/webhook/resume_stremio_call_end
```

---

## 🎯 PART 5: FULL FEATURE BACKLOG

### Phase 1: Quick Wins (Week 1-2)

| ID | Feature | Description | Effort |
|----|---------|-------------|--------|
| F1.1 | **Home Assistant Stremio Integration** | Install custom component to expose Stremio as media player | 2h |
| F1.2 | **Pause on Call Webhook** | Create HA automation + Tasker profile on A04s | 3h |
| F1.3 | **Pause on Doorbell** | Trigger pause when doorbell rings | 1h |
| F1.4 | **Lights Dim on Play** | Automate Philips Hue/LIFX on playback start | 2h |
| F1.5 | **Health Monitor Alerts** | Telegram notification when device offline | 2h |

### Phase 2: Enhanced UI (Week 3-4)

| ID | Feature | Description | Effort |
|----|---------|-------------|--------|
| F2.1 | **Stremio Enhanced Install** | Deploy themed fork with custom CSS | 4h |
| F2.2 | **Custom Theme Design** | Create AcidWurx branded theme | 6h |
| F2.3 | **Dashboard Widgets** | HA Lovelace cards for Stremio control | 4h |
| F2.4 | **Voice Control Setup** | Alexa/Google integration via HA | 3h |
| F2.5 | **Multi-Device Sync** | Sync watch history across devices | 8h |

### Phase 3: Advanced Features (Week 5-8)

| ID | Feature | Description | Effort |
|----|---------|-------------|--------|
| F3.1 | **Custom Web UI (MVP)** | React frontend with Stremio addon support | 40h |
| F3.2 | **Presence Detection** | Pause when leave home, resume on return | 6h |
| F3.3 | **Bedtime Automation** | Gradual volume fade + auto-pause | 3h |
| F3.4 | **Phone Remote Control** | HA Companion app as full remote | 4h |
| F3.5 | **Watch Party** | Multi-device synchronized playback | 20h |

### Phase 4: Premium Features (Week 9-12)

| ID | Feature | Description | Effort |
|----|---------|-------------|--------|
| F4.1 | **AI Recommendations** | Suggest content based on viewing history | 16h |
| F4.2 | **Transcoding Server** | Jellyfin-style transcoding for incompatible formats | 24h |
| F4.3 | **Cloud Sync** | Sync settings/history to Cloudflare KV | 8h |
| F4.4 | **Offline Downloads** | Download for offline viewing (with debrid) | 12h |
| F4.5 | **Kids Mode** | Content filtering + time limits | 8h |

---

## 🏗️ PART 6: ARCHITECTURE PROPOSAL

### Custom Platform Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    ACIDWURX STREMIO PLATFORM                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────┐ │
│  │  Custom Web UI  │◄──►│  Home Assistant │◄──►│  IoT Devices│ │
│  │  (React/Vue)    │    │  (Automation)   │    │  (Lights,   │ │
│  │                 │    │                 │    │   Doorbell, │ │
│  │  - Bespoke UI   │    │  - Call detect  │    │   Phone)    │ │
│  │  - Themes       │    │  - Presence     │    │             │ │
│  │  - Multi-profile│    │  - Media control│    │             │ │
│  └────────┬────────┘    └────────┬────────┘    └─────────────┘ │
│           │                      │                               │
│           └──────────┬───────────┘                               │
│                      │                                           │
│           ┌──────────▼───────────┐                              │
│           │   Stremio Addon API  │                              │
│           │   (Torrentio, etc.)  │                              │
│           │                      │                              │
│           │  - Stream endpoints  │                              │
│           │  - Metadata          │                              │
│           │  - Catalogs          │                              │
│           └──────────┬───────────┘                              │
│                      │                                           │
│           ┌──────────▼───────────┐                              │
│           │   Video Player       │                              │
│           │   (Video.js/Plyr)    │                              │
│           │                      │                              │
│           │  - Custom controls   │                              │
│           │  - Subtitle sync     │                              │
│           │  - Quality selector  │                              │
│           └──────────────────────┘                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📅 PART 7: IMPLEMENTATION TIMELINE

### Week 1-2: Foundation
- [ ] Install Stremio Enhanced fork
- [ ] Set up Home Assistant media player integration
- [ ] Create pause-on-call webhook
- [ ] Test with Samsung A04s Tasker automation

### Week 3-4: UI Enhancement
- [ ] Design AcidWurx custom theme
- [ ] Create HA Lovelace dashboard cards
- [ ] Set up voice control (Alexa/Google)
- [ ] Deploy health monitor Telegram alerts

### Week 5-8: Custom Platform
- [ ] Build React web UI (MVP)
- [ ] Integrate Stremio addon API
- [ ] Implement presence detection
- [ ] Add bedtime automation

### Week 9-12: Advanced
- [ ] AI recommendations engine
- [ ] Cloud sync via Cloudflare KV
- [ ] Watch party synchronization
- [ ] Kids mode with parental controls

---

## 🛠️ PART 8: IMMEDIATE NEXT STEPS

### Today (30 minutes)
```bash
# 1. Test Home Assistant is accessible
curl http://192.168.1.179:8123

# 2. Check if Stremio custom component exists in HA
# Go to: http://192.168.1.179:8123/config/dashboard
# HACS → Integrations → Search "Stremio"

# 3. Install if available, or use ADB method
```

### This Week
1. ✅ Choose approach: Stremio Enhanced vs Custom Web UI
2. ✅ Set up pause-on-call test (webhook + Tasker)
3. ✅ Install custom theme on Stremio Enhanced
4. ✅ Create HA automation for doorbell pause

### This Month
1. Design custom UI mockups
2. Build React frontend MVP
3. Integrate all IoT triggers
4. Deploy to production

---

## 💡 PART 9: RECOMMENDATION

### Start with This Stack:

| Component | Choice | Why |
|-----------|--------|-----|
| **Base Platform** | Stremio Enhanced | Easy customization, plugin support |
| **Automation Hub** | Home Assistant (already running!) | Perfect for IoT integration |
| **Call Detection** | Tasker on Samsung A04s | Reliable, works offline |
| **Device Control** | ADB over WiFi (Fire TV) | No root needed, reliable |
| **Custom UI** | React + Vite (Phase 2) | Modern, fast, easy to theme |
| **Video Player** | Video.js | Subtitle support, quality selector |
| **Sync Backend** | Cloudflare KV | Free, fast, already have account |

---

## 🎯 SUCCESS METRICS

| Metric | Current | Target (3 months) |
|--------|---------|-------------------|
| Pause on Call | ❌ Not working | ✅ <500ms latency |
| Custom UI | ❌ Stock Stremio | ✅ Fully branded |
| IoT Integrations | ❌ None | ✅ 5+ triggers |
| Multi-Device Sync | ❌ Manual | ✅ Automatic |
| Voice Control | ❌ None | ✅ Full Alexa/Google |
| Health Monitoring | ✅ Basic | ✅ Advanced + alerts |

---

**Ready to start building?** 🚀

*Last Updated: 2026-03-17T01:30:00+00:00*
