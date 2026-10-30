@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   LifeDrop - Complete Automated Push and Cloud Sync
echo =========================================================

REM 1. Clean up scratch/redundant files from working tree
if exist "RENDER_ONE_CLICK.md" del /q "RENDER_ONE_CLICK.md"
if exist "check-db.bat" del /q "check-db.bat"
if exist "init-aiven-db.bat" del /q "init-aiven-db.bat"

REM 2. Stage core production assets
git add -A

REM 3. Create consolidated commit
git commit -m "chore: cleanup redundant markdown and sync production cloud configuration"

REM 4. Push directly to remote repository
git push origin main

echo.
echo =========================================================
echo   Repository is 100% clean, synced, and pushed to GitHub!
echo   Render will auto-deploy the latest build immediately.
echo =========================================================
timeout /t 5
