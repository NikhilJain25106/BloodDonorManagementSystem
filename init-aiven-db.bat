@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   Testing & Initializing Aiven Cloud MySQL...
echo =========================================================

REM Build package if missing
if not exist "target\BloodDonorManagementSystem.jar" (
    echo Building package...
    call mvn clean package -DskipTests
)

java -cp "target\BloodDonorManagementSystem.jar" com.blooddonor.util.AivenInit mysql-33813183-lifedropbm-77.a.aivencloud.com 22772 defaultdb avnadmin AVNS_lHp0SNhnO1zx8LYPSo_

echo.
pause
