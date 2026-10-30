@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   Cleaning Staged Credentials & Pushing Clean Commit...
echo =========================================================

REM Undo the last local commit so we can re-commit without plaintext secrets
git reset HEAD~1

REM Stage all files (secret files are now sanitized and .env is ignored)
git add .

REM Create fresh commit
git commit -m "fix(render): configure sync environment variables, fix healthcheck and sanitize secrets"

REM Push to GitHub
git push origin main

echo.
echo =========================================================
echo   Push completed successfully!
echo =========================================================
timeout /t 5
