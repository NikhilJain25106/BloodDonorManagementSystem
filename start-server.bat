@echo off
setlocal
cd /d "%~dp0"
echo =========================================================
echo  Starting LifeDrop - Blood Donor Management System
echo =========================================================

REM Build fat JAR if target does not exist
if not exist "target\BloodDonorManagementSystem.jar" (
    echo Building LifeDrop package...
    call mvn clean package -DskipTests
)

echo Starting embedded server on port 8080...
echo.
echo Application will be available at:
echo http://localhost:8080/
echo.
echo Admin Login: http://localhost:8080/adminLogin
echo Donor Login: http://localhost:8080/donorLogin
echo =========================================================
java -jar target\BloodDonorManagementSystem.jar
pause
