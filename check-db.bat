@echo off
setlocal
cd /d "%~dp0"

echo =========================================================
echo   LifeDrop Database Diagnostics
echo =========================================================

if not exist "target\BloodDonorManagementSystem.jar" (
    echo Building project package...
    call mvn clean package -DskipTests
)

java -cp "target\BloodDonorManagementSystem.jar" com.blooddonor.util.DBDiagnostic
pause

