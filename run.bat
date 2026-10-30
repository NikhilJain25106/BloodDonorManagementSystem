@echo off
setlocal enabledelayedexpansion

REM Ensure script always executes in the project root directory
cd /d "%~dp0"

echo =========================================================
echo    LifeDrop - Blood Donor Management System
echo =========================================================

REM Check if --native argument was passed
if "%1"=="--native" goto RUN_NATIVE
if "%1"=="native" goto RUN_NATIVE

REM Check if Docker is installed and running
where docker >nul 2>nul
if %errorlevel% equ 0 (
    echo [✔] Docker detected! Starting fully containerized LifeDrop...
    echo [✔] Launching MySQL 8.0 and LifeDrop web container...
    echo.
    docker compose up --build -d
    if %errorlevel% neq 0 (
        echo [!] Docker compose exited with an error. Attempting docker-compose legacy...
        docker-compose up --build -d
    )
    if %errorlevel% equ 0 (
        echo.
        echo =========================================================
        echo   LifeDrop is running in Docker!
        echo =========================================================
        echo   Public Portal:   http://localhost:8080/
        echo   Admin Portal:    http://localhost:8080/adminLogin
        echo                    Username: admin  ^|  Password: Admin@123
        echo   Donor Portal:    http://localhost:8080/donorLogin
        echo   Health Probe:    http://localhost:8080/health
        echo =========================================================
        echo   To view logs:    docker compose logs -f app
        echo   To stop:         docker compose down
        echo =========================================================
        goto END
    )
)

:RUN_NATIVE
echo [*] Running in Native Local Mode (Java + Maven)...

REM Check Java
where java >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Java 17 LTS is not found on your PATH.
    echo Please install JDK 17+ or install Docker to run with 1 command.
    pause
    exit /b 1
)

REM Check Maven
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Apache Maven is not found on your PATH.
    echo Please install Maven or install Docker to run with 1 command.
    pause
    exit /b 1
)

REM Ensure .env exists
if not exist ".env" (
    if exist ".env.example" (
        echo [i] Creating .env from .env.example...
        copy .env.example .env >nul
    )
)

REM Build fat JAR if target is missing
if not exist "target\BloodDonorManagementSystem.jar" (
    echo [*] Packaging fat JAR with Maven...
    call mvn clean package -DskipTests
)

echo.
echo =========================================================
echo   Starting LifeDrop Embedded Tomcat Server...
echo =========================================================
echo   Public Portal:   http://localhost:8080/
echo   Admin Portal:    http://localhost:8080/adminLogin
echo   Donor Portal:    http://localhost:8080/donorLogin
echo =========================================================
java -XX:+UseG1GC -Djava.awt.headless=true -jar target\BloodDonorManagementSystem.jar

:END
pause

