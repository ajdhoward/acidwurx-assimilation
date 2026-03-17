# 🎬 ACIDWURX STREMIO BESPOKE PLATFORM
## Comprehensive Design Specification

**Version**: 1.0  
**Status**: Draft  
**Created**: 2026-03-17  
**Last Updated**: 2026-03-17  
**Owner**: Adam Howard (AcidWurx)

---

# TABLE OF CONTENTS

1. [Executive Summary](#1-executive-summary)
2. [Vision & Goals](#2-vision--goals)
3. [Target Users](#3-target-users)
4. [Platform Architecture](#4-platform-architecture)
5. [Feature Specifications](#5-feature-specifications)
6. [User Interface Design](#6-user-interface-design)
7. [Home Assistant Integration](#7-home-assistant-integration)
8. [API Specifications](#8-api-specifications)
9. [Data Model](#9-data-model)
10. [Security & Privacy](#10-security--privacy)
11. [Performance Requirements](#11-performance-requirements)
12. [Deployment Architecture](#12-deployment-architecture)
13. [Development Roadmap](#13-development-roadmap)
14. [Appendices](#14-appendices)

---

# 1. EXECUTIVE SUMMARY

## 1.1 Project Overview

**AcidWurx Stremio Bespoke Platform** is a fully customized streaming media platform built on the Stremio addon ecosystem, featuring deep home automation integration, bespoke UI/UX, and unique IoT-triggered playback controls.

## 1.2 Unique Value Proposition

| Feature | Competitors | AcidWurx |
|---------|-------------|----------|
| Stremio Addon Support | ✅ | ✅ |
| Home Automation | ❌ | ✅ **Pause on Call** |
| IoT Triggers | ❌ | ✅ **Doorbell, Lights, etc.** |
| Custom UI | ⚠️ Limited | ✅ **Full Control** |
| Multi-Profile | ⚠️ Paid | ✅ **Free** |
| Health Monitoring | ❌ | ✅ **Built-in** |
| $0 Cost | ⚠️ Freemium | ✅ **Guaranteed** |

## 1.3 Key Differentiators

1. **Pause-on-Call**: Automatically pause playback when phone rings
2. **IoT Integration**: Doorbell, lights, presence detection via Home Assistant
3. **Bespoke UI**: Fully branded, customizable interface
4. **Health Monitor**: Track device performance across ecosystem
5. **Zero Cost**: All features free via Cloudflare + home infrastructure

---

# 2. VISION & GOALS

## 2.1 Vision Statement

> "Create the most intelligent streaming platform that understands your environment and adapts to your life—pausing when you need attention, dimming lights for ambiance, and providing a beautiful, personalized interface that feels uniquely yours."

## 2.2 Design Principles

| Principle | Description |
|-----------|-------------|
| **Ambient Intelligence** | The platform anticipates needs without explicit commands |
| **Zero Friction** | Setup and daily use require minimal manual intervention |
| **Privacy First** | All data stays local or in encrypted Cloudflare KV |
| **Modular Design** | Features can be enabled/disabled independently |
| **Responsive** | UI responds in <100ms, actions complete in <500ms |

## 2.3 Success Metrics

| Metric | Current | Target (3mo) | Target (6mo) |
|--------|---------|--------------|--------------|
| Pause-on-Call Latency | N/A | <500ms | <200ms |
| UI Frame Rate | N/A | 60fps | 60fps |
| Time to First Frame | N/A | <2s | <1.5s |
| IoT Trigger Reliability | N/A | 99% | 99.9% |
| User Satisfaction | N/A | 4/5 | 5/5 |

---

# 3. TARGET USERS

## 3.1 Primary User: Adam Howard

**Profile**: Tech-savvy home automation enthusiast

| Attribute | Value |
|-----------|-------|
| **Location** | UK (GMT/BST) |
| **Devices** | Samsung A04s, Fire TV Cube, PC |
| **Smart Home** | Home Assistant, MQTT devices |
| **Technical Level** | Advanced |
| **Pain Points** | Interruptions during viewing, generic UI |

## 3.2 Secondary Users

| User | Use Case | Requirements |
|------|----------|--------------|
| **Family Members** | Casual viewing | Simple remote, profiles |
| **Guests** | Occasional use | Guest mode, limited access |

---

# 4. PLATFORM ARCHITECTURE

## 4.1 High-Level Architecture

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

## 4.2 Component Specifications

### 4.2.1 Custom Web UI

**Technology Stack**:
- **Frontend Framework**: React 18+ with TypeScript
- **Build Tool**: Vite (for fast HMR)
- **Styling**: Tailwind CSS + CSS Modules
- **State Management**: Zustand (lightweight)
- **Routing**: React Router v6

**Key Modules**:
```
src/
├── components/
│   ├── Player/          # Video player controls
│   ├── Catalog/         # Content browsing
│   ├── Settings/        # User preferences
│   └── Dashboard/       # Health monitor view
├── hooks/
│   ├── useStremioApi.ts # API integration
│   ├── useHomeAssistant.ts # HA WebSocket
│   └── usePlayback.ts   # Playback state
├── services/
│   ├── stremio.ts       # Stremio addon client
│   ├── homeassistant.ts # HA REST + WebSocket
│   └── health.ts        # Device monitoring
└── stores/
    ├── playback.ts      # Playback state store
    └── settings.ts      # User settings store
```

### 4.2.2 Home Assistant Integration

**Connection Methods**:
| Method | Protocol | Use Case |
|--------|----------|----------|
| **REST API** | HTTP | Webhook triggers |
| **WebSocket** | WS | Real-time state updates |
| **Long Polling** | HTTP | Fallback for state |

**Entities to Expose**:
```yaml
media_player.acidwurx_stremio:
  friendly_name: "AcidWurx Stremio"
  supported_features:
    - play
    - pause
    - stop
    - seek
    - volume_set
  device_class: tv

sensor.stremio_playback_state:
  friendly_name: "Playback State"
  unit_of_measurement: "%"
  icon: mdi:play-circle

switch.stremio_iot_mode:
  friendly_name: "IoT Automation Mode"
  icon: mdi:home-automation
```

### 4.2.3 Video Player

**Selected**: Video.js

**Rationale**:
- Subtitle support (VTT, SRT, SSA)
- Quality selector (HLS adaptive)
- Plugin ecosystem
- Mobile responsive
- Custom skin support

**Custom Features**:
```javascript
// Custom control bar
const playerOptions = {
  controls: {
    children: [
      'PlayToggle',
      'VolumePanel',
      'CurrentTimeDisplay',
      'TimeDivider',
      'DurationDisplay',
      'ProgressControl',
      'QualitySelector',    // Custom
      'PlaybackRateMenu',   // Custom
      'SubtitlesMenu',      // Custom
      'FullscreenToggle'
    ]
  },
  html5: {
    hls: {
      enableLowInitialPlaylist: true,
      smoothQualityChange: true
    }
  }
};
```

---

# 5. FEATURE SPECIFICATIONS

## 5.1 Phase 1 Features (Week 1-2)

### F1.1: Pause on Phone Call

**User Story**: 
> "As a user watching content, I want playback to automatically pause when my phone rings, so I don't miss calls and don't have to manually pause."

**Technical Specification**:

```yaml
Feature: Pause-on-Call
Priority: P0 (Critical)
Effort: 3 hours

Trigger Flow:
  1. Samsung A04s detects incoming call
  2. Tasker sends webhook to Home Assistant
  3. HA automation triggers pause command
  4. Command sent to Fire TV via ADB
  5. Playback pauses within 500ms

Components:
  - Tasker Profile (A04s)
  - Home Assistant Automation
  - ADB Bridge Service

Acceptance Criteria:
  ✓ Pause latency < 500ms
  ✓ Works for cellular and VoIP calls
  ✓ Does not trigger for alarm/timer
  ✓ Resumes correctly after call ends
  ✓ Manual override available
```

**Implementation Details**:

```yaml
# Home Assistant Automation
automation:
  - alias: "Stremio - Pause on Call Start"
    trigger:
      platform: webhook
      webhook_id: stremio_call_start
    condition:
      condition: state
      entity_id: switch.stremio_iot_mode
      state: "on"
    action:
      - service: remote.send_command
        target:
          entity_id: remote.fire_tv_cube
        data:
          command:
            - key: "HOME"
      - service: persistent_notification.create
        data:
          title: "Playback Paused"
          message: "Call detected - playback paused"

  - alias: "Stremio - Resume After Call"
    trigger:
      platform: webhook
      webhook_id: stremio_call_end
    condition:
      condition: state
      entity_id: switch.stremio_iot_mode
      state: "on"
    action:
      - service: remote.send_command
        target:
          entity_id: remote.fire_tv_cube
        data:
          command:
            - key: "SELECT"
      - delay: "00:00:02"
      - service: media_player.media_play
        target:
          entity_id: media_player.stremio_tv
```

```xml
<!-- Tasker Profile (A04s) -->
<Tasker Profile Export>
  <Profile name="Stremio Call Pause">
    <Event type="Phone Call Incoming"/>
    <Enter Task="Send Webhook">
      <HTTP POST="http://192.168.1.179:8123/api/webhook/stremio_call_start"/>
    </Enter>
    <Exit Task="Send Webhook">
      <HTTP POST="http://192.168.1.179:8123/api/webhook/stremio_call_end"/>
    </Exit>
  </Profile>
</Tasker>
```

---

### F1.2: Pause on Doorbell

**User Story**:
> "As a user, I want playback to pause when the doorbell rings, so I can hear and respond to visitors."

**Technical Specification**:

```yaml
Feature: Pause on Doorbell
Priority: P1 (High)
Effort: 1 hour

Trigger:
  - Doorbell button press (any smart doorbell)
  - Motion detection at door (optional)

Action:
  - Pause playback
  - Show doorbell camera snapshot (if available)
  - Unpause after 30 seconds or manual resume

Acceptance Criteria:
  ✓ Triggers on any doorbell event
  ✓ Shows camera feed on supported doorbells
  ✓ Auto-resume after timeout
```

---

### F1.3: Lights Dim on Play

**User Story**:
> "As a user, I want lights to dim automatically when I start watching, creating an immersive experience."

**Technical Specification**:

```yaml
Feature: Lights Dim on Play
Priority: P1 (High)
Effort: 2 hours

Trigger:
  - Playback starts (any content)
  - Time of day: after sunset (optional)

Action:
  - Dim living room lights to 20%
  - Turn off kitchen lights (if unoccupied)
  - Set color temperature to 2700K (warm)

Restore:
  - Restore lights on pause > 5 minutes
  - Restore lights on playback end
  - Manual override via remote

Acceptance Criteria:
  ✓ Works with Philips Hue/LIFX/any HA lights
  ✓ Respects existing light states
  ✓ Configurable dim level per room
```

---

### F1.4: Health Monitor Alerts

**User Story**:
> "As a user, I want to be notified if my streaming devices go offline, so I can troubleshoot before needing to watch."

**Technical Specification**:

```yaml
Feature: Health Monitor Alerts
Priority: P2 (Medium)
Effort: 2 hours

Monitoring:
  - Device heartbeat (every 30s)
  - Stream error rate
  - API response latency

Alert Channels:
  - Telegram (primary)
  - Home Assistant notification
  - Email (fallback)

Alert Thresholds:
  - Device offline > 5 minutes
  - Error rate > 10%
  - Latency > 2000ms

Acceptance Criteria:
  ✓ Alerts sent within 1 minute of issue
  ✓ Clear actionable error messages
  ✓ Alert suppression during active playback
```

---

### F1.5: Voice Control

**User Story**:
> "As a user, I want to control playback with voice commands, so I don't need to find the remote."

**Technical Specification**:

```yaml
Feature: Voice Control
Priority: P1 (High)
Effort: 3 hours

Supported Commands:
  - "Pause Stremio"
  - "Play Stremio"
  - "Stop Stremio"
  - "Skip forward 10 seconds"
  - "Go back 10 seconds"
  - "Volume up/down"
  - "What's playing?"

Integration:
  - Amazon Alexa (via HA Alexa Media)
  - Google Assistant (via HA Google Assistant SDK)
  - Home Assistant Assist (local, offline)

Acceptance Criteria:
  ✓ Works from any room with Alexa/Google
  ✓ < 2 second response time
  ✓ Natural language variations supported
```

---

## 5.2 Phase 2 Features (Week 3-4)

### F2.1: Stremio Enhanced Theme

**User Story**:
> "As a user, I want a custom-branded interface that reflects my personal style."

**Technical Specification**:

```yaml
Feature: AcidWurx Custom Theme
Priority: P1 (High)
Effort: 6 hours

Theme Elements:
  - Color Palette: AcidWurx brand colors
  - Logo: Custom AcidWurx logo in header
  - Fonts: Custom web fonts
  - Card Design: Glassmorphism or neumorphism
  - Animations: Smooth transitions

CSS Variables:
  --acidwurx-primary: #FF6B35
  --acidwurx-secondary: #004E89
  --acidwurx-accent: #FFD166
  --acidwurx-bg: #1A1A2E
  --acidwurx-surface: #16213E

Acceptance Criteria:
  ✓ All UI elements themed
  ✓ Logo visible on all pages
  ✓ Consistent with AcidWurx brand
  ✓ Dark mode optimized
```

---

### F2.2: Dashboard Widgets

**User Story**:
> "As a user, I want to see Stremio status and controls in my Home Assistant dashboard."

**Technical Specification**:

```yaml
Feature: HA Lovelace Dashboard Cards
Priority: P2 (Medium)
Effort: 4 hours

Card Types:
  - Playback Status Card
  - Quick Controls Card
  - Health Monitor Card
  - Now Playing Card

Features:
  - Play/Pause/Stop buttons
  - Progress bar with seek
  - Volume control
  - Device selector
  - Health indicators

Acceptance Criteria:
  ✓ Cards work on mobile and desktop
  ✓ Real-time state updates
  ✓ Matches HA theme
```

---

### F2.3: Multi-Device Sync

**User Story**:
> "As a user, I want my watch history and progress to sync across all my devices."

**Technical Specification**:

```yaml
Feature: Multi-Device Sync
Priority: P1 (High)
Effort: 8 hours

Sync Data:
  - Watch history (last 100 items)
  - Playback progress (per item)
  - Bookmarks/favorites
  - Settings (theme, preferences)

Storage:
  - Primary: Cloudflare KV (encrypted)
  - Cache: LocalStorage (per device)
  - Backup: SQLite (local)

Sync Triggers:
  - On playback start/stop
  - Every 5 minutes (background)
  - On app foreground

Conflict Resolution:
  - Last write wins (by timestamp)
  - Progress: keep highest value

Acceptance Criteria:
  ✓ Sync completes in < 2 seconds
  ✓ Works offline (syncs when online)
  ✓ No data loss on conflicts
```

---

## 5.3 Phase 3 Features (Week 5-8)

### F3.1: Custom Web UI (MVP)

**User Story**:
> "As a user, I want a completely custom interface designed specifically for my needs."

**Technical Specification**:

```yaml
Feature: Custom Web UI MVP
Priority: P0 (Critical)
Effort: 40 hours

Core Features:
  - Content browsing (catalogs)
  - Stream selection
  - Video playback
  - Subtitle support
  - Search functionality
  - User profiles
  - Settings panel

Technical Stack:
  - React 18 + TypeScript
  - Vite (build tool)
  - Tailwind CSS (styling)
  - Video.js (player)
  - Zustand (state)

Pages:
  - Home (featured content)
  - Browse (catalogs)
  - Search
  - Details (meta page)
  - Player (fullscreen)
  - Settings

Acceptance Criteria:
  ✓ All Stremio addons compatible
  ✓ 60fps UI performance
  ✓ Mobile responsive
  ✓ Keyboard navigation
  ✓ Remote control support
```

---

### F3.2: Presence Detection

**User Story**:
> "As a user, I want playback to pause when I leave home and resume when I return."

**Technical Specification**:

```yaml
Feature: Presence Detection
Priority: P2 (Medium)
Effort: 6 hours

Detection Methods:
  - GPS (phone location)
  - WiFi connection (phone connected to home WiFi)
  - Bluetooth (phone connected to home BT)
  - Home Assistant person entity

Actions:
  - Leave: Pause after 30 second grace period
  - Return: Show "Resume?" notification
  - Away > 1 hour: Send "Still watching?" reminder

Acceptance Criteria:
  ✓ No false positives (doesn't pause while home)
  ✓ Grace period prevents accidental pauses
  ✓ Works with multiple people
```

---

### F3.3: Bedtime Automation

**User Story**:
> "As a user, I want playback to automatically wind down at bedtime."

**Technical Specification**:

```yaml
Feature: Bedtime Automation
Priority: P3 (Low)
Effort: 3 hours

Schedule:
  - Trigger time: 11:00 PM (configurable)
  - Grace period: 10 minutes

Actions:
  - 11:00 PM: Show "Bedtime soon" notification
  - 11:05 PM: Dim volume to 50%
  - 11:08 PM: Dim volume to 25%
  - 11:10 PM: Pause playback
  - 11:10 PM: Fade screen to black (if supported)

Override:
  - "Continue watching" button (adds 30 min)
  - Voice command: "Stay awake mode"

Acceptance Criteria:
  ✓ Gentle, gradual transitions
  ✓ Easy to override
  ✓ Respects weekend/holiday schedule
```

---

## 5.4 Phase 4 Features (Week 9-12)

### F4.1: AI Recommendations

**User Story**:
> "As a user, I want personalized content recommendations based on my viewing history."

**Technical Specification**:

```yaml
Feature: AI Recommendations
Priority: P2 (Medium)
Effort: 16 hours

Data Sources:
  - Watch history
  - Ratings (if available)
  - Time of day patterns
  - Genre preferences

AI Approach:
  - Local analysis (privacy-preserving)
  - Collaborative filtering (optional, anonymized)
  - Content-based filtering (metadata matching)

Output:
  - "Because you watched X" row
  - "Perfect for tonight" suggestions
  - "Hidden gems you might like"

Acceptance Criteria:
  ✓ Recommendations update weekly
  ✓ No external API calls (privacy)
  ✓ Explainable ("Because you watched...")
```

---

### F4.2: Transcoding Server

**User Story**:
> "As a user, I want incompatible video formats to transcode automatically."

**Technical Specification**:

```yaml
Feature: Transcoding Server
Priority: P3 (Low)
Effort: 24 hours

Technology:
  - FFmpeg (transcoding engine)
  - HLS output (universal compatibility)
  - Hardware acceleration (Intel QSV/NVENC)

Use Cases:
  - Subtitle burn-in (for unsupported formats)
  - Audio transcoding (AC3 → AAC)
  - Resolution downscaling (for mobile)
  - Bitrate adaptation (slow connections)

Performance Targets:
  - Real-time transcoding for 1080p
  - < 5 second startup delay
  - < 50% CPU usage (with hardware accel)

Acceptance Criteria:
  ✓ Transcodes on-the-fly
  ✓ Multiple quality levels
  ✓ Subtitle support
```

---

### F4.3: Watch Party

**User Story**:
> "As a user, I want to watch content synchronized with friends remotely."

**Technical Specification**:

```yaml
Feature: Watch Party
Priority: P2 (Medium)
Effort: 20 hours

Features:
  - Synchronized playback (±100ms)
  - Voice chat (optional)
  - Text chat
  - Host controls (play/pause for all)
  - Ready checks

Technology:
  - WebSocket (real-time sync)
  - WebRTC (voice chat)
  - Cloudflare Durable Objects (state)

Capacity:
  - 2-10 participants optimal
  - Up to 50 supported

Acceptance Criteria:
  ✓ Sync maintained across different connections
  ✓ Re-sync on network issues
  ✓ Chat doesn't interfere with playback
```

---

# 6. USER INTERFACE DESIGN

## 6.1 Design System

### Color Palette

```css
:root {
  /* AcidWurx Brand Colors */
  --aw-primary: #FF6B35;        /* Vibrant orange */
  --aw-secondary: #004E89;      /* Deep blue */
  --aw-accent: #FFD166;         /* Warm yellow */
  
  /* Background Colors */
  --aw-bg-dark: #1A1A2E;        /* Deep navy */
  --aw-bg-surface: #16213E;     /* Lighter navy */
  --aw-bg-elevated: #0F3460;    /* Elevated surface */
  
  /* Text Colors */
  --aw-text-primary: #FFFFFF;
  --aw-text-secondary: #B8B8B8;
  --aw-text-muted: #6B6B6B;
  
  /* Status Colors */
  --aw-success: #06D6A0;
  --aw-warning: #FFD166;
  --aw-error: #EF476F;
  --aw-info: #118AB2;
}
```

### Typography

```css
:root {
  /* Font Families */
  --aw-font-heading: 'Inter', -apple-system, sans-serif;
  --aw-font-body: 'Inter', -apple-system, sans-serif;
  --aw-font-mono: 'JetBrains Mono', monospace;
  
  /* Font Sizes */
  --aw-text-xs: 0.75rem;    /* 12px */
  --aw-text-sm: 0.875rem;   /* 14px */
  --aw-text-base: 1rem;     /* 16px */
  --aw-text-lg: 1.125rem;   /* 18px */
  --aw-text-xl: 1.25rem;    /* 20px */
  --aw-text-2xl: 1.5rem;    /* 24px */
  --aw-text-3xl: 1.875rem;  /* 30px */
  --aw-text-4xl: 2.25rem;   /* 36px */
}
```

### Spacing System

```css
:root {
  --aw-space-1: 0.25rem;   /* 4px */
  --aw-space-2: 0.5rem;    /* 8px */
  --aw-space-3: 0.75rem;   /* 12px */
  --aw-space-4: 1rem;      /* 16px */
  --aw-space-5: 1.25rem;   /* 20px */
  --aw-space-6: 1.5rem;    /* 24px */
  --aw-space-8: 2rem;      /* 32px */
  --aw-space-10: 2.5rem;   /* 40px */
  --aw-space-12: 3rem;     /* 48px */
  --aw-space-16: 4rem;     /* 64px */
}
```

---

## 6.2 Component Library

### Button Component

```tsx
interface ButtonProps {
  variant: 'primary' | 'secondary' | 'ghost' | 'danger';
  size: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  onClick?: () => void;
  children: React.ReactNode;
}

// Variants:
// - Primary: Orange background, white text
// - Secondary: Blue background, white text
// - Ghost: Transparent, white text
// - Danger: Red background, white text
```

### Card Component

```tsx
interface CardProps {
  variant: 'default' | 'elevated' | 'glass';
  hoverable?: boolean;
  children: React.ReactNode;
}

// Variants:
// - Default: Solid background, subtle border
// - Elevated: Shadow, elevated appearance
// - Glass: Glassmorphism effect (backdrop-blur)
```

### Player Controls

```tsx
interface PlayerControlsProps {
  playing: boolean;
  volume: number;
  muted: boolean;
  currentTime: number;
  duration: number;
  quality: string;
  subtitles: boolean;
  onPlayPause: () => void;
  onSeek: (time: number) => void;
  onVolumeChange: (volume: number) => void;
  onQualityChange: (quality: string) => void;
  onSubtitleToggle: () => void;
}
```

---

## 6.3 Page Layouts

### Home Page

```
┌─────────────────────────────────────────────────────────────┐
│  [Logo]  Home  Browse  Search  Settings    [Profile] [🔔]  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              HERO BANNER (Featured)                 │   │
│  │  [Background Image]                                 │   │
│  │  Title, Description, [Watch] [Info]                 │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  Continue Watching                                          │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                  │
│  │     │ │     │ │     │ │     │ │     │  ← Horizontal    │
│  │     │ │     │ │     │ │     │ │     │    Scroll        │
│  └─────┘ └─────┘ └─────┘ └─────┘ └─────┘                  │
│                                                             │
│  Trending Now                                               │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                  │
│  │     │ │     │ │     │ │     │ │     │                  │
│  └─────┘ └─────┘ └─────┘ └─────┘ └─────┘                  │
│                                                             │
│  Because You Watched [X]                                    │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                  │
│  │     │ │     │ │     │ │     │ │     │                  │
│  └─────┘ └─────┘ └─────┘ └─────┘ └─────┘                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Player Page

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│                                                             │
│                    [VIDEO PLAYER]                           │
│                                                             │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│  [Play] [Volume]  12:34 ━━━━━━━━━━━━━━━ 45:20  [Quality]   │
│         ────────────────────────────────────────  [Subs]    │
└─────────────────────────────────────────────────────────────┘
```

---

# 7. HOME ASSISTANT INTEGRATION

## 7.1 Entity Registry

### Media Player Entity

```yaml
entity_id: media_player.acidwurx_stremio
friendly_name: "AcidWurx Stremio"
state: playing | paused | stopped | idle | buffering
supported_features:
  - play (1)
  - pause (2)
  - stop (4)
  - seek (8)
  - volume_set (16)
  - mute (32)
  - next_track (64)
  - previous_track (128)
  
attributes:
  media_content_type: movie | episode | channel
  media_title: "Movie/Episode Title"
  media_series_title: "Series Name" (if episode)
  media_season: 1
  media_episode: 5
  app_name: "AcidWurx Stremio"
  volume_level: 0.8
  is_volume_muted: false
  media_position: 732
  media_duration: 2720
  media_position_updated_at: "2026-03-17T01:30:00+00:00"
```

### Sensor Entities

```yaml
# Playback State Sensor
entity_id: sensor.stremio_playback_state
state: "75"  # Percentage complete
unit_of_measurement: "%"
icon: mdi:progress-circle

# Device Health Sensor
entity_id: sensor.stremio_device_health
state: "healthy" | "degraded" | "unhealthy"
attributes:
  latency_ms: 45
  error_rate: 0.02
  last_heartbeat: "2026-03-17T01:30:00+00:00"

# Active Viewers Sensor
entity_id: sensor.stremio_active_viewers
state: 1
unit_of_measurement: "viewers"
icon: mdi:account-eye
```

### Switch Entities

```yaml
# IoT Automation Mode
entity_id: switch.stremio_iot_mode
state: "on" | "off"
icon: mdi:home-automation
friendly_name: "IoT Automation Mode"

# Pause on Call
entity_id: switch.stremio_pause_on_call
state: "on" | "off"
icon: mdi:phone-pause
friendly_name: "Pause on Incoming Calls"

# Lights Automation
entity_id: switch.stremio_lights_dim
state: "on" | "off"
icon: mdi:lightbulb
friendly_name: "Dim Lights on Play"
```

---

## 7.2 Automations

### Automation: Pause on Call

```yaml
automation:
  - id: "stremio_pause_on_call"
    alias: "Stremio - Pause on Incoming Call"
    description: "Pauses Stremio playback when phone call is detected"
    mode: single
    max_exceeded: silent
    
    trigger:
      - platform: webhook
        webhook_id: stremio_call_start
        id: call_start
      - platform: state
        entity_id: binary_sensor.doorbell_pressed
        to: "on"
        id: doorbell
    
    condition:
      - condition: state
        entity_id: media_player.acidwurx_stremio
        state: "playing"
      - condition: state
        entity_id: switch.stremio_iot_mode
        state: "on"
    
    action:
      - choose:
          - conditions:
              - condition: trigger
                id: call_start
            sequence:
              - service: persistent_notification.create
                data:
                  title: "📞 Call Detected"
                  message: "Playback paused for incoming call"
                  notification_id: stremio_call_pause
          - conditions:
              - condition: trigger
                id: doorbell
            sequence:
              - service: camera.snapshot
                target:
                  entity_id: camera.doorbell
                data:
                  filename: "/tmp/doorbell_snapshot.jpg"
              - service: persistent_notification.create
                data:
                  title: "🚪 Doorbell"
                  message: "Playback paused - visitor at door"
                  image: "/local/doorbell_snapshot.jpg"
                  notification_id: stremio_doorbell_pause
        default:
          - service: media_player.media_pause
            target:
              entity_id: media_player.acidwurx_stremio
```

---

# 8. API SPECIFICATIONS

## 8.1 Stremio Addon API

### Manifest Endpoint

```
GET /manifest.json

Response:
{
  "id": "com.acidwurx.stremio-bespoke",
  "version": "1.0.0",
  "name": "AcidWurx Bespoke",
  "description": "Custom Stremio platform with IoT integration",
  "logo": "https://acidwurx.org/logo.png",
  "background": "https://acidwurx.org/background.jpg",
  "types": ["movie", "series"],
  "resources": ["catalog", "meta", "stream"],
  "idPrefixes": ["tt", "tmdb"],
  "behaviorHints": {
    "configurable": true,
    "configurationRequired": false,
    "adult": false,
    "p2p": false
  }
}
```

### Stream Endpoint

```
GET /stream/{type}/{id}.json

Response:
{
  "streams": [
    {
      "name": "AcidWurx Premium",
      "title": "1080p | English | HEVC",
      "url": "https://stream.acidwurx.org/video.m3u8",
      "behaviorHints": {
        "notWebReady": false,
        "proxyHeaders": {
          "request": {
            "Authorization": "Bearer {token}"
          }
        }
      }
    }
  ]
}
```

---

## 8.2 Home Assistant API

### WebSocket Connection

```javascript
// Connect to HA WebSocket
const socket = new WebSocket('ws://192.168.1.179:8123/api/websocket');

// Auth handshake
socket.onopen = () => {
  socket.send(JSON.stringify({
    type: 'auth',
    access_token: 'LONG_LIVED_TOKEN'
  }));
};

// Subscribe to media player state
socket.send(JSON.stringify({
  id: 1,
  type: 'subscribe_entities',
  entity_ids: ['media_player.acidwurx_stremio']
}));

// Receive state updates
socket.onmessage = (event) => {
  const data = JSON.parse(event.data);
  if (data.type === 'entity_updated') {
    handleStateUpdate(data.data);
  }
};
```

### REST API Calls

```javascript
// Trigger webhook (pause on call)
fetch('http://192.168.1.179:8123/api/webhook/stremio_call_start', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    device: 'samsung_a04s',
    caller: '+44XXXXXXXXXX'
  })
});

// Get entity state
fetch('http://192.168.1.179:8123/api/states/media_player.acidwurx_stremio', {
  headers: {
    'Authorization': 'Bearer LONG_LIVED_TOKEN'
  }
});
```

---

# 9. DATA MODEL

## 9.1 Cloudflare KV Schema

### User Profiles

```typescript
interface UserProfile {
  id: string;              // UUID
  name: string;
  avatar?: string;
  created: number;         // Unix timestamp
  settings: UserSettings;
  watchHistory: WatchHistoryItem[];
  favorites: string[];     // Content IDs
}

// KV Key: profile:{userId}
// TTL: Never expire
```

### Watch History

```typescript
interface WatchHistoryItem {
  contentId: string;       // tt1234567 or tmdb:123
  type: 'movie' | 'episode';
  title: string;
  progress: number;        // Seconds watched
  duration: number;        // Total duration
  startedAt: number;       // Unix timestamp
  lastWatched: number;     // Unix timestamp
  completed: boolean;
  rating?: number;         // 1-10
}

// KV Key: history:{userId}:{contentId}
// TTL: 1 year
```

### Device Health

```typescript
interface DeviceHealth {
  deviceId: string;
  lastHeartbeat: number;
  status: 'healthy' | 'degraded' | 'unhealthy';
  latency: number;         // ms
  errorRate: number;       // 0.0 - 1.0
  uptime: number;          // seconds
  lastError?: string;
}

// KV Key: health:{deviceId}
// TTL: 1 hour (updated every 30s)
```

---

## 9.2 Local Storage Schema

### Playback State (LocalStorage)

```typescript
interface PlaybackState {
  contentId: string;
  position: number;        // Current position in seconds
  quality: string;         // e.g., "1080p"
  audioTrack: string;
  subtitleTrack: string;
  volume: number;          // 0.0 - 1.0
  muted: boolean;
  playbackRate: number;    // 0.5 - 2.0
}

// Storage Key: acidwurx:playback
```

---

# 10. SECURITY & PRIVACY

## 10.1 Data Protection

### Encryption Standards

| Data Type | Encryption | Storage |
|-----------|-----------|---------|
| API Tokens | AES-256-GCM | Cloudflare Secrets |
| User Profiles | AES-256-GCM | Cloudflare KV |
| Watch History | AES-256-GCM | Cloudflare KV |
| Local Cache | None | LocalStorage |
| Health Data | None | Cloudflare KV |

### Key Management

```
Cloudflare Secrets:
  - CLOUDFLARE_API_KEY
  - OPENROUTER_KEY
  - GOOGLE_API_KEY
  - HA_WEBHOOK_TOKEN

Local Environment:
  - HA_LONG_LIVED_TOKEN (in .env, gitignored)
  - ADB_KEYS (in secure storage)
```

---

## 10.2 Privacy Principles

1. **Local First**: All processing happens locally when possible
2. **Minimal Data**: Only collect what's needed for features
3. **User Control**: Users can export/delete all data
4. **No Tracking**: No analytics, no telemetry, no fingerprinting
5. **Transparent**: All data flows documented

---

## 10.3 Security Checklist

- [ ] All API keys in Cloudflare Secrets (not in code)
- [ ] HTTPS enforced for all external connections
- [ ] Webhook tokens validated on receipt
- [ ] ADB connections authenticated
- [ ] Input validation on all user inputs
- [ ] XSS protection (Content-Security-Policy)
- [ ] CSRF protection for state-changing operations
- [ ] Rate limiting on API endpoints
- [ ] Error messages don't leak sensitive info

---

# 11. PERFORMANCE REQUIREMENTS

## 11.1 Latency Targets

| Operation | Target | Maximum |
|-----------|--------|---------|
| UI Click → Response | < 100ms | < 200ms |
| Pause Command → Action | < 500ms | < 1000ms |
| Webhook → Playback Pause | < 500ms | < 1000ms |
| Page Load (cold) | < 2s | < 5s |
| Stream Start | < 3s | < 10s |
| Subtitle Load | < 1s | < 3s |
| Quality Switch | < 2s | < 5s |

---

## 11.2 Resource Targets

| Metric | Target | Maximum |
|--------|--------|---------|
| CPU Usage (idle) | < 5% | < 10% |
| CPU Usage (playback) | < 30% | < 50% |
| Memory Usage | < 500MB | < 1GB |
| Network (idle) | < 10KB/s | < 50KB/s |
| Network (playback) | Stream bitrate | Stream + 10% |

---

## 11.3 Reliability Targets

| Metric | Target |
|--------|--------|
| Uptime | 99.9% |
| Webhook Delivery | 99.99% |
| Data Sync Success | 99.9% |
| Error Rate | < 0.1% |
| Crash Rate | < 0.01% |

---

# 12. DEPLOYMENT ARCHITECTURE

## 12.1 Infrastructure Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    INTERNET                                 │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              Cloudflare Edge                                │
│  - DDoS Protection                                          │
│  - CDN (static assets)                                      │
│  - Workers (API proxy)                                      │
│  - KV (data storage)                                        │
└────────────────────────┬────────────────────────────────────┘
                         │ Tunnel
                         ▼
┌─────────────────────────────────────────────────────────────┐
│              Home Network (192.168.1.0/24)                  │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  markslone   │  │  Fire TV     │  │  Samsung     │     │
│  │  (192.168.1.179) │  Cube        │  │  A04s        │     │
│  │              │  │              │  │              │     │
│  │ - HA         │  │ - Stremio    │  │ - Tasker    │     │
│  │ - Stremio    │  │ - Player    │  │ - Webhook   │     │
│  │ - Health     │  │              │  │              │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 12.2 Docker Compose Configuration

```yaml
version: '3.8'

services:
  stremio-bespoke:
    image: node:18-alpine
    container_name: stremio-bespoke
    restart: unless-stopped
    ports:
      - "192.168.1.164:3000:3000"
    volumes:
      - ./stremio-bespoke:/app
      - stremio_bespoke_node_modules:/app/node_modules
    working_dir: /app
    command: npm run start
    environment:
      - NODE_ENV=production
      - HA_URL=http://homeassistant:8123
      - HA_TOKEN=${HA_LONG_LIVED_TOKEN}
    networks:
      - acidwurx-network
    depends_on:
      - homeassistant

  homeassistant:
    image: homeassistant/home-assistant:latest
    container_name: homeassistant
    restart: unless-stopped
    ports:
      - "8123:8123"
    volumes:
      - homeassistant_config:/config
    environment:
      - TZ=Europe/London
    networks:
      - acidwurx-network

networks:
  acidwurx-network:
    external: true

volumes:
  stremio_bespoke_node_modules:
  homeassistant_config:
```

---

# 13. DEVELOPMENT ROADMAP

## 13.1 Phase Timeline

```
Week 1-2: Foundation
├── Install Stremio Enhanced
├── Set up HA media player integration
├── Create pause-on-call webhook
├── Test with Samsung A04s Tasker
└── Deploy lights-dim automation

Week 3-4: Enhancement
├── Design AcidWurx custom theme
├── Create HA Lovelace dashboard cards
├── Set up voice control
└── Deploy health monitor alerts

Week 5-8: Custom Platform
├── Build React web UI (MVP)
├── Integrate Stremio addon API
├── Implement presence detection
└── Add bedtime automation

Week 9-12: Advanced
├── AI recommendations engine
├── Cloud sync via Cloudflare KV
├── Watch party synchronization
└── Kids mode with parental controls
```

---

## 13.2 Milestone Checklist

### Milestone 1: IoT Integration Complete (Week 2)
- [ ] Pause-on-call working (< 500ms)
- [ ] Doorbell pause working
- [ ] Lights dim automation working
- [ ] Voice control functional
- [ ] Health monitor alerts sending

### Milestone 2: UI Enhancement Complete (Week 4)
- [ ] Custom theme deployed
- [ ] HA dashboard cards working
- [ ] Multi-device sync functional
- [ ] All Phase 1 features tested

### Milestone 3: Custom UI MVP (Week 8)
- [ ] React web UI deployed
- [ ] All Stremio addons compatible
- [ ] Presence detection working
- [ ] Bedtime automation complete

### Milestone 4: Advanced Features (Week 12)
- [ ] AI recommendations live
- [ ] Cloud sync operational
- [ ] Watch party tested
- [ ] Kids mode deployed

---

# 14. APPENDICES

## Appendix A: Glossary

| Term | Definition |
|------|------------|
| **HA** | Home Assistant |
| **ADB** | Android Debug Bridge |
| **KV** | Key-Value store (Cloudflare) |
| **IoT** | Internet of Things |
| **HLS** | HTTP Live Streaming |
| **VTT** | WebVTT (subtitle format) |
| **HMR** | Hot Module Replacement |

---

## Appendix B: Reference Documents

- [Stremio Addon SDK](https://github.com/Stremio/stremio-addon-sdk)
- [Home Assistant API](https://developers.home-assistant.io/docs/api/)
- [Cloudflare Workers](https://developers.cloudflare.com/workers/)
- [Video.js Documentation](https://docs.videojs.com/)
- [React Documentation](https://react.dev/)

---

## Appendix C: Contact & Support

**Project Owner**: Adam Howard  
**Email**: [redacted]  
**GitHub**: [redacted]  
**Discord**: [redacted]

---

**Document Version**: 1.0  
**Last Updated**: 2026-03-17T02:00:00+00:00  
**Next Review**: 2026-03-24

---

*End of Specification Document*
