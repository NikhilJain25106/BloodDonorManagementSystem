#!/usr/bin/env bash
# =============================================================================
# LifeDrop - Universal Startup Script (macOS / Linux / WSL / Git Bash)
# Runs LifeDrop on any device with one simple command: ./run.sh
# =============================================================================

set -e

# Always ensure execution from the project repository root directory
cd "$(dirname "$0")"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}=========================================================${NC}"
echo -e "${CYAN}   🩸 LifeDrop — Blood Donor Management System          ${NC}"
echo -e "${CYAN}=========================================================${NC}"

# Detect available tools
HAS_DOCKER=false
if command -v docker &> /dev/null && (docker compose version &> /dev/null || docker-compose --version &> /dev/null); then
    HAS_DOCKER=true
fi

HAS_JAVA=false
if command -v java &> /dev/null; then
    JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F '.' '{print $1}')
    if [ "$JAVA_VER" -ge 17 ] 2>/dev/null; then
        HAS_JAVA=true
    fi
fi

HAS_MAVEN=false
if command -v mvn &> /dev/null; then
    HAS_MAVEN=true
fi

# Determine execution mode
RUN_MODE="docker"

if [ "$1" == "--native" ] || [ "$1" == "native" ]; then
    RUN_MODE="native"
elif [ "$HAS_DOCKER" = false ]; then
    RUN_MODE="native"
fi

if [ "$RUN_MODE" == "docker" ]; then
    echo -e "${GREEN}[✔] Docker detected! Starting fully containerized environment...${NC}"
    echo -e "${YELLOW}This includes MySQL 8.0, automatic database schema setup, and Tomcat web app.${NC}"
    echo ""

    if docker compose version &> /dev/null; then
        DOCKER_CMD="docker compose"
    else
        DOCKER_CMD="docker-compose"
    fi

    echo -e "${CYAN}Executing: ${DOCKER_CMD} up --build -d${NC}"
    $DOCKER_CMD up --build -d

    echo ""
    echo -e "${GREEN}=========================================================${NC}"
    echo -e "${GREEN}  LifeDrop is running successfully in Docker!             ${NC}"
    echo -e "${GREEN}=========================================================${NC}"
    echo -e "  🌐 Public Portal:   ${CYAN}http://localhost:8080/${NC}"
    echo -e "  🔒 Admin Portal:    ${CYAN}http://localhost:8080/adminLogin${NC}"
    echo -e "     Credentials:     Username: ${YELLOW}admin${NC} | Password: ${YELLOW}Admin@123${NC}"
    echo -e "  💉 Donor Portal:    ${CYAN}http://localhost:8080/donorLogin${NC}"
    echo -e "     Credentials:     Identifier: ${YELLOW}rohan.mehta@example.com${NC} or ${YELLOW}9876543210${NC}"
    echo -e "  🩺 Health Probe:    ${CYAN}http://localhost:8080/health${NC}"
    echo -e "${GREEN}=========================================================${NC}"
    echo -e "  To view logs:       ${YELLOW}${DOCKER_CMD} logs -f app${NC}"
    echo -e "  To stop server:     ${YELLOW}${DOCKER_CMD} down${NC}"
    echo -e "${GREEN}=========================================================${NC}"
    exit 0
fi

# Native local mode
echo -e "${YELLOW}[!] Running in Native Local Mode...${NC}"

if [ "$HAS_JAVA" = false ]; then
    echo -e "${RED}[ERROR] OpenJDK 17 or higher is required but not found.${NC}"
    echo "Please install Java 17 or install Docker to run with zero dependencies."
    exit 1
fi

if [ "$HAS_MAVEN" = false ]; then
    echo -e "${RED}[ERROR] Apache Maven is required to build locally but not found.${NC}"
    echo "Please install Maven (e.g. 'brew install maven' or 'sudo apt install maven') or run via Docker."
    exit 1
fi

# Ensure .env exists
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    echo -e "${YELLOW}[i] No .env file found. Creating from .env.example...${NC}"
    cp .env.example .env
fi

# Build fat JAR if target is missing
if [ ! -f "target/BloodDonorManagementSystem.jar" ]; then
    echo -e "${CYAN}[*] Building LifeDrop executable package with Maven...${NC}"
    mvn clean package -DskipTests
fi

echo ""
echo -e "${GREEN}=========================================================${NC}"
echo -e "${GREEN}  Starting LifeDrop Embedded Server...                   ${NC}"
echo -e "${GREEN}=========================================================${NC}"
echo -e "  🌐 Web App:      ${CYAN}http://localhost:8080/${NC}"
echo -e "  🔒 Admin Login:  ${CYAN}http://localhost:8080/adminLogin${NC}"
echo -e "  💉 Donor Login:  ${CYAN}http://localhost:8080/donorLogin${NC}"
echo -e "${GREEN}=========================================================${NC}"

java -XX:+UseG1GC -Djava.awt.headless=true -jar target/BloodDonorManagementSystem.jar

