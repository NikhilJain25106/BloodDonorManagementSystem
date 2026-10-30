#!/usr/bin/env bash
# ===============================================================================
# LifeDrop - Complete Autonomous Orchestrator (macOS / Linux / WSL)
# ===============================================================================

set -e
cd "$(dirname "$0")"

echo "==============================================================================="
echo "       LifeDrop - Complete Autonomous Orchestrator (All-in-One)"
echo "==============================================================================="

echo "[1/3] Sanitizing workspace..."
rm -f RENDER_ONE_CLICK.md check-db.bat init-aiven-db.bat

echo "[2/3] Staging all production assets..."
git add -A

echo "[3/3] Synchronizing with GitHub and triggering Render redeploy..."
git commit -m "chore(auto): autonomous full-stack sync, documentation, and cloud deployment updates" || true
git push origin main

echo ""
echo "==============================================================================="
echo "  [SUCCESS] Code pushed to GitHub! Render is deploying your site live:"
echo "            https://lifedrop-app-k6ef.onrender.com"
echo "==============================================================================="

