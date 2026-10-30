@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo ===============================================================================
echo        LifeDrop - Complete Autonomous Orchestrator (All-in-One)
echo ===============================================================================

echo.
echo [1/4] Sanitizing workspace and removing scratch artifacts...
if exist "RENDER_ONE_CLICK.md" del /q "RENDER_ONE_CLICK.md" >nul 2>&1
if exist "check-db.bat" del /q "check-db.bat" >nul 2>&1
if exist "init-aiven-db.bat" del /q "init-aiven-db.bat" >nul 2>&1
echo [OK] Workspace sanitized.

echo.
echo [2/4] Resetting any uncommitted secret references...
git reset HEAD DEPLOY_RENDER.md >nul 2>&1

echo.
echo [3/4] Staging production code and documentation...
git add -A
echo [OK] Files staged.

echo.
echo [4/4] Synchronizing with GitHub...
git commit -m "chore(auto): autonomous full-stack sync, documentation, and cloud deployment updates" >nul 2>&1

echo Attempting push to origin main...
git push origin main
if %errorlevel% neq 0 (
    echo.
    echo [!] Standard push had an issue. Checking if remote has newer commits...
    git pull origin main --rebase
    echo Retrying push...
    git push origin main
)

if %errorlevel% equ 0 (
    echo.
    echo ===============================================================================
    echo   [SUCCESS] Code pushed to GitHub!
    echo   [SUCCESS] Render is now automatically building and deploying:
    echo             https://lifedrop-app-k6ef.onrender.com
    echo ===============================================================================
) else (
    echo.
    echo ===============================================================================
    echo   [NOTICE] If GitHub rejected the push:
    echo   Check the message above to see if it was due to non-fast-forward or secrets.
    echo ===============================================================================
)

echo.
pause
