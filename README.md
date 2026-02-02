# FCT-compiler
A compiler for FCT with SPICE netlist simulation support

## Overview

This project provides the ability to simulate electronic circuits using SPICE netlists with the open-source ngspice simulator. It includes example netlists demonstrating various circuit designs.

## Features

- SPICE netlist simulation using ngspice (open-source)
- Example 5-transistor operational transconductance amplifier (OTA)
- Automated simulation script
- DC, AC, and transient analysis support

## Prerequisites

To simulate netlists, you need to install ngspice:

### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install ngspice
```

### macOS
```bash
brew install ngspice
```

### Fedora/RHEL
```bash
sudo dnf install ngspice
```

### Windows
Download and install from: http://ngspice.sourceforge.net/download.html

## Usage

### Running the Example Netlist

To simulate the example 5-transistor amplifier:

```bash
./simulate.sh
```

Or specify a custom netlist:

```bash
./simulate.sh src/netlists/your_netlist.cir
```

### Viewing Results

After simulation, results are saved to `simulation_output.log`:

```bash
cat simulation_output.log
```

## Example Netlists

### Five-Transistor Amplifier (`src/netlists/five_transistor_amplifier.cir`)

A classic differential amplifier with active current mirror load consisting of:
- M1 and M2: Differential pair (NMOS transistors)
- M3 and M4: Active current mirror load (PMOS transistors)
- M5: Tail current source (NMOS transistor)

The circuit performs:
- **DC Operating Point Analysis**: Shows the DC voltages at all nodes
- **DC Sweep Analysis**: Plots the transfer characteristic
- **AC Analysis**: Calculates frequency response and voltage gain
- **Transient Analysis**: Shows time-domain behavior

## Creating Your Own Netlists

SPICE netlists should be placed in `src/netlists/` with a `.cir` extension. Basic netlist structure:

```spice
* Title line (comment)
* Circuit description
VDD vdd 0 DC 5V
* ... components ...
.model NMOS NMOS (parameters...)
.OP
.DC ...
.AC ...
.TRAN ...
.control
run
* analysis commands
.endc
.end
```

## Directory Structure

```
FCT-compiler/
├── README.md
├── simulate.sh              # Main simulation script
└── src/
    └── netlists/           # SPICE netlist files
        └── five_transistor_amplifier.cir
```

## License

This project is open source.
