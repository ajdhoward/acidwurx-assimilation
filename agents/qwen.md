# 🤖 Agent: Qwen CLI (Code Builder)

**Role**: Assimilate knowledge, build projects from unified context  
**Sources**: All assimilated data (local + GitHub + email + chat + logs)  
**Status**: ⏳ Ready to build

---

## 📋 Responsibilities

1. Read unified context from `/unified/context/`
2. Extract actionable tasks
3. Build projects in `/unified/projects/`
4. Update progress every 30 min via git commit/push

---

## 🧠 Context Window

**Max Tokens**: 256K (Qwen 3.5)  
**Preferred Models**: `qwen/qwen3-coder:free` (OpenRouter)  
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
- `@gemini` for architecture coordination
- `@human` for blocker resolution
- Post progress to `tasks/in-progress.md`

### To Human
- Build status in `reports/daily-brief.md`
- Blockers in `prompts/external-help-*.md`

---

## 🚀 Start Command

```bash
cd ~/acidwurx-assimilation/unified
qwen chat --prompt "Read all context in /unified/context/. Build projects based on discovered requirements. Update agents/qwen.md with progress every 30 min and git commit/push."
```

---

## 🎯 Current Priorities

1. [ ] Read all context files
2. [ ] Identify buildable projects
3. [ ] Start with highest priority task
4. [ ] Update this file with progress
5. [ ] Git commit/push every 30 min

---

*Agent File Version: 1.0*  
*Created: 2026-03-17T04:15:00+00:00*
