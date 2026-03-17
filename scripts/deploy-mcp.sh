#!/bin/bash
# Deploy all MCP servers for AI access

set -e

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     🛠️  ACIDWURX MCP SERVERS - DEPLOYMENT                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"

cd ~/acidwurx-iac/docker-compose || exit

# Check for .env file
if [ ! -f mcp.env ]; then
  echo "⚠️  Creating mcp.env from template..."
  cp mcp.env.template mcp.env
  echo ""
  echo "📝 EDIT mcp.env WITH YOUR API KEYS:"
  echo "   nano mcp.env"
  echo ""
  echo "Required keys:"
  echo "   - GITHUB_TOKEN"
  echo "   - GOOGLE_API_KEY"
  echo "   - CLOUDFLARE_API_TOKEN"
  echo "   - HA_LONG_LIVED_TOKEN"
  echo "   - TORBOX_API_KEY"
  echo ""
  echo "After editing, run: $0 again"
  exit 0
fi

# Load environment
set -a
source mcp.env
set +a

echo "[1/3] Starting MCP servers..."
docker-compose -f mcp-servers-complete.yml up -d

echo ""
echo "[2/3] Waiting for health checks..."
sleep 10

echo ""
echo "[3/3] Checking server status..."
docker-compose -f mcp-servers-complete.yml ps

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║     ✅ MCP SERVERS DEPLOYED                                   ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 AVAILABLE MCP SERVERS:"
echo ""
echo "Core Infrastructure:"
echo "   • github-mcp      - Repos, issues, PRs, actions"
echo "   • google-mcp      - Gmail, Drive, Calendar, Tasks"
echo "   • cloudflare-mcp  - Workers, KV, DNS, Tunnels"
echo ""
echo "Home Automation:"
echo "   • homeassistant-mcp - All HA entities, automations"
echo "   • adb-mcp           - Samsung A04s control"
echo ""
echo "Stremio:"
echo "   • stremio-mcp - Addon management, playback control"
echo ""
echo "Development:"
echo "   • terraform-mcp   - IaC management"
echo "   • docker-mcp      - Container management"
echo "   • filesystem-mcp  - File access"
echo "   • git-mcp         - Git operations"
echo ""
echo "AI/ML:"
echo "   • qwen-mcp    - Qwen CLI access"
echo "   • gemini-mcp  - Google AI access"
echo ""
echo "Data:"
echo "   • postgres-mcp    - Database access"
echo "   • knowledge-mcp   - Search assimilated data"
echo ""
echo "🤖 AI BUILDER USAGE:"
echo "   In AI prompts: mcp://server-name/tool-name"
echo ""
echo "   Example: 'Use github-mcp to create issues for tasks'"
echo ""
echo "📊 MONITORING:"
echo "   docker-compose -f mcp-servers-complete.yml ps"
echo "   docker-compose -f mcp-servers-complete.yml logs -f"
echo ""
