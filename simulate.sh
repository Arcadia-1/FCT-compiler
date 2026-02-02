#!/bin/bash

# SPICE Netlist Simulator Script
# This script simulates SPICE netlists using ngspice (open-source SPICE simulator)

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}SPICE Netlist Simulator${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Check if ngspice is installed
if ! command -v ngspice &> /dev/null; then
    echo -e "${RED}Error: ngspice is not installed${NC}"
    echo ""
    echo "Please install ngspice:"
    echo "  Ubuntu/Debian: sudo apt-get install ngspice"
    echo "  macOS: brew install ngspice"
    echo "  Windows: Download from http://ngspice.sourceforge.net/"
    echo ""
    exit 1
fi

# Check for netlist argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <netlist_file.cir>"
    echo ""
    echo "Available netlists:"
    find src/netlists -name "*.cir" -type f 2>/dev/null | while read -r file; do
        echo "  - $file"
    done
    echo ""
    exit 1
fi

NETLIST_FILE=$1

# Check if netlist file exists
if [ ! -f "$NETLIST_FILE" ]; then
    echo -e "${RED}Error: Netlist file '$NETLIST_FILE' not found${NC}"
    exit 1
fi

echo -e "${GREEN}Simulating:${NC} $NETLIST_FILE"
echo ""

# Run ngspice simulation
ngspice -b "$NETLIST_FILE" -o "${NETLIST_FILE%.cir}_output.log"

# Check if simulation was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Simulation completed successfully${NC}"
    echo -e "Output saved to: ${NETLIST_FILE%.cir}_output.log"
else
    echo ""
    echo -e "${RED}✗ Simulation failed${NC}"
    exit 1
fi
