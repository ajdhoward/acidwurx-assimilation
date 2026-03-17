# 🔄 ACIDWURX REPROVISIONING SCRIPT
# Run this on ANY new machine to restore full AI builder environment

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     🔄 ACIDWURX REPROVISIONING - Restore from GitHub         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

# === 1. Install Prerequisites ===
echo "[1/6] Installing prerequisites..."
command -v git >/dev/null || sudo apt install -y git
command -v gh >/dev/null || sudo apt install -y gh
command -v qwen >/dev/null || npm install -g @qwenlm/qwen-code
command -v gemini >/dev/null || echo "⚠️  Install Gemini CLI: https://github.com/google-gemini/gemini-cli"

# === 2. Authenticate GitHub ===
echo "[2/6] Authenticating GitHub..."
gh auth login --scopes repo,workflow || echo "⚠️  Manual auth required: gh auth login"

# === 3. Clone All Repos ===
echo "[3/6] Cloning repositories..."
cd ~ || exit

# Clone assimilation (unified knowledge base)
if [ ! -d "acidwurx-assimilation" ]; then
  gh repo clone ajdhoward/acidwurx-assimilation
  echo "  ✓ acidwurx-assimilation"
else
  cd acidwurx-assimilation && git pull && cd ..
  echo "  ✓ acidwurx-assimilation (updated)"
fi

# Clone coordination (AI agent coordination)
if [ ! -d "acidwurx-coordination" ]; then
  gh repo clone ajdhoward/acidwurx-coordination
  echo "  ✓ acidwurx-coordination"
else
  cd acidwurx-coordination && git pull && cd ..
  echo "  ✓ acidwurx-coordination (updated)"
fi

# Clone IAC (infrastructure + Stremio specs)
if [ ! -d "acidwurx-iac" ]; then
  gh repo clone ajdhoward/acidwurx-iac
  echo "  ✓ acidwurx-iac"
else
  cd acidwurx-iac && git pull && cd ..
  echo "  ✓ acidwurx-iac (updated)"
fi

# === 4. Restore API Keys (If Available) ===
echo "[4/6] Restoring API keys..."
if [ -f "acidwurx-assimilation/unified/oauth/vault/.master_key" ]; then
  echo "  ✓ Vault found - API keys will be available"
else
  echo "  ⚠️  No vault found - set API keys manually:"
  echo "     export GOOGLE_API_KEY=\"your-key\""
  echo "     export OPENROUTER_KEY=\"your-key\""
fi

# === 5. Verify Git State ===
echo "[5/6] Verifying git state..."
cd ~/acidwurx-assimilation/unified && \
git log --oneline -3 && \
echo "  ✓ Latest commit retrieved"

# === 6. Start AI Builders ===
echo "[6/6] AI builders ready to start!"
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     ✅ REPROVISIONING COMPLETE                                ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 RESTORED:"
echo "   • Unified knowledge base (all context)"
echo "   • AI agent coordination files"
echo "   • Task backlog"
echo "   • Stremio design specifications"
echo "   • Infrastructure documentation"
echo ""
echo "🚀 START AI BUILDERS:"
echo ""
echo "=== TERMINAL 1 - Qwen (Code Builder) ==="
echo "cd ~/acidwurx-assimilation/unified"
echo "qwen chat --prompt \"Read all context. Build projects. Update agents/qwen.md every 30 min with git commit/push.\""
echo ""
echo "=== TERMINAL 2 - Gemini (Architecture Builder) ==="
echo "cd ~/acidwurx-assimilation/unified"
echo "gemini --prompt \"Read all context. Design architecture, generate Terraform. Update agents/gemini.md every 30 min with git commit/push.\" --model gemini-2.0-flash"
echo ""
echo "📊 MONITOR PROGRESS:"
echo "   cat ~/acidwurx-assimilation/unified/agents/qwen.md | tail -20"
echo "   cat ~/acidwurx-assimilation/unified/agents/gemini.md | tail -20"
echo "   git -C ~/acidwurx-assimilation/unified log --oneline"
echo ""
echo "✅ Pick up where you left off - all state in GitHub!"
