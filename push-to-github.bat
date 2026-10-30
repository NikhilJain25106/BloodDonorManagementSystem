@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   Pushing LifeDrop to GitHub for Render Deployment
echo =========================================================

git add .
git commit -m "feat: configure automated Render deployment with render.yaml and cloud SSL DB support"
git push origin main

echo.
echo =========================================================
echo   Code pushed to GitHub successfully!
echo   Render will now auto-detect render.yaml and Dockerfile.
echo =========================================================
pause

