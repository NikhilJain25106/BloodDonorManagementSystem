@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   Initializing Aiven Cloud MySQL Database...
echo =========================================================

REM Build package if missing
if not exist "target\BloodDonorManagementSystem.jar" (
    echo Building LifeDrop package...
    call mvn clean package -DskipTests
)

java -cp "target\BloodDonorManagementSystem.jar" com.blooddonor.util.AivenInit
echo.
pause

