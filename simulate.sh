#!/bin/bash
# Simulation script for SPICE netlists using ngspice

# Check if ngspice is installed
if ! command -v ngspice &> /dev/null
then
    echo "Error: ngspice is not installed."
    echo "Please install ngspice:"
    echo "  Ubuntu/Debian: sudo apt-get install ngspice"
    echo "  macOS: brew install ngspice"
    echo "  Fedora: sudo dnf install ngspice"
    exit 1
fi

# Default netlist
NETLIST="${1:-src/netlists/five_transistor_amplifier.cir}"

# Check if netlist file exists
if [ ! -f "$NETLIST" ]; then
    echo "Error: Netlist file '$NETLIST' not found."
    echo "Usage: $0 [netlist_file]"
    exit 1
fi

echo "======================================"
echo "SPICE Netlist Simulator"
echo "======================================"
echo "Netlist: $NETLIST"
echo "Simulator: ngspice"
echo "======================================"
echo ""

# Run the simulation
ngspice -b "$NETLIST" -o simulation_output.log

# Check if simulation was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "======================================"
    echo "Simulation completed successfully!"
    echo "======================================"
    echo "Output saved to: simulation_output.log"
    echo ""
    echo "To view the results:"
    echo "  cat simulation_output.log"
else
    echo ""
    echo "======================================"
    echo "Simulation failed!"
    echo "======================================"
    echo "Check simulation_output.log for details"
    exit 1
fi
