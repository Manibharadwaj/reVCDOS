#!/bin/bash
# reVCDOS Auto-Installer — just run this and play GTA Vice City
# Usage: curl -sL https://raw.githubusercontent.com/Manibharadwaj/reVCDOS/main/install.sh | bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════╗"
echo "║   GTA Vice City — Browser Edition       ║"
echo "║   Auto-Installer                        ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Check Python
echo -e "${YELLOW}[1/4] Checking Python...${NC}"
if command -v python3 &>/dev/null; then
    PYTHON=python3
    PIP="python3 -m pip"
elif command -v python &>/dev/null; then
    PYTHON=python
    PIP="python -m pip"
else
    echo -e "${RED}Python not found! Install Python 3.8+ from python.org${NC}"
    exit 1
fi
echo -e "${GREEN}Found: $($PYTHON --version)${NC}"

# Check git
echo -e "${YELLOW}[2/4] Cloning repo...${NC}"
if ! command -v git &>/dev/null; then
    echo -e "${RED}Git not found! Install git first.${NC}"
    exit 1
fi

if [ -d "reVCDOS" ]; then
    echo -e "${GREEN}reVCDOS folder already exists, pulling latest...${NC}"
    cd reVCDOS && git pull
else
    git clone https://github.com/Manibharadwaj/reVCDOS.git
    cd reVCDOS
fi

# Install deps
echo -e "${YELLOW}[3/4] Installing dependencies...${NC}"
$PIP install -r requirements.txt --quiet 2>/dev/null || \
$PIP install -r requirements.txt --break-system-packages --quiet 2>/dev/null || \
$PIP install -r requirements.txt --user --quiet

# Launch
echo -e "${YELLOW}[4/4] Starting server...${NC}"
echo -e "${GREEN}"
echo "╔══════════════════════════════════════════╗"
echo "║  GTA Vice City is starting!             ║"
echo "║                                          ║"
echo "║  First run: downloads ~1GB game data     ║"
echo "║  Open: http://localhost:8000             ║"
echo "║  Cheats: http://localhost:8000/?cheats=1  ║"
echo "║                                          ║"
echo "║  Press Ctrl+C to stop the server         ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

$PYTHON server.py