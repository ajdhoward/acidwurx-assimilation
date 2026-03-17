# 🤖 Agent: Gemini CLI (Architecture Builder)

**Role**: Design architecture from assimilated knowledge  
**Sources**: All assimilated data (local + GitHub + email + chat + logs)  
**Status**: ⏳ Ready to build

---

## 📋 Responsibilities

1. Read unified context from `/unified/context/`
2. Design system architecture
3. Generate Terraform for all devices/entities
4. Update progress every 30 min via git commit/push

---

## 🧠 Context Window

**Max Tokens**: 1M (Gemini 2.0)  
**Preferred Models**: `gemini-2.0-flash` (60/min free)  
**API Key**: Stored in encrypted vault

---

## 📝 Activity Log

| Timestamp | Action | Output | Status |
|-----------|--------|--------|--------|
| - | - | - | Not yet active |

---

## 🔄 Current State

```yaml
active: false
assigned_tasks: []
blocked_by: []
last_commit: null
next_check_in: null
```

---

## 📡 Communication

### To Other Agents
- `@qwen` for code building coordination
- `@human` for architecture decisions
- Post progress to `tasks/in-progress.md`

### To Human
- Architecture diagrams in `context/architecture.md`
- Deployment status in `reports/daily-brief.md`

---

## 🚀 Start Command

```bash
cd ~/acidwurx-assimilation/unified
gemini --prompt "Read all context in /unified/context/. Design architecture and generate Terraform for all devices. Update agents/gemini.md with progress every 30 min and git commit/push." --model gemini-2.0-flash
```

---

## 🎯 Current Priorities

1. [ ] Read all context files
2. [ ] Design system architecture
3. [ ] Generate Terraform configurations
4. [ ] Update this file with progress
5. [ ] Git commit/push every 30 min

---

*Agent File Version: 1.0*  
*Created: 2026-03-17T04:15:00+00:00*
