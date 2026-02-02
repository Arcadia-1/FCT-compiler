# FCT-compiler
A compiler for FCT - SPICE Netlist Simulation Project

## Overview

This project provides tools and examples for simulating electronic circuits using SPICE netlists with the open-source ngspice simulator. It includes a 5-transistor differential amplifier as an example circuit.

## Features

- **Open-Source SPICE Simulation**: Uses ngspice for circuit simulation
- **Example Netlists**: 5-transistor differential amplifier with current mirror load
- **Automated Simulation**: Easy-to-use shell script for running simulations
- **Comprehensive Analysis**: DC, AC, and transient analysis capabilities

## Prerequisites

### Installing ngspice

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install ngspice
```

**macOS:**
```bash
brew install ngspice
```

**Windows:**
Download and install from [ngspice official website](http://ngspice.sourceforge.net/)

## Quick Start

### 1. Run the Example Simulation

Simulate the 5-transistor amplifier:

```bash
./simulate.sh src/netlists/5_transistor_amplifier.cir
```

The simulation will generate an output log file with analysis results.

### 2. View Available Netlists

List all available netlists:

```bash
./simulate.sh
```

## Example Netlist: 5-Transistor Amplifier

The included 5-transistor amplifier (`src/netlists/5_transistor_amplifier.cir`) is a differential amplifier with:

- **M1, M2**: NMOS differential input pair
- **M3, M4**: PMOS current mirror load
- **M5**: NMOS tail current source

### Circuit Topology

```
        VDD (5V)
         |
    M3   |   M4
    |----|----| (PMOS Current Mirror)
    |         |
  vout1     vout2 (outputs)
    |         |
    M1       M2 (NMOS Differential Pair)
    |         |
    +----+----+
         |
        M5 (NMOS Tail Current)
         |
        VSS (0V)
```

### Analyses Performed

1. **Operating Point (.op)**: DC operating point of all nodes
2. **DC Sweep (.dc)**: Transfer characteristic (input vs output voltage)
3. **AC Analysis (.ac)**: Frequency response and gain
4. **Transfer Function (.tf)**: Small-signal gain calculation

## Creating Custom Netlists

SPICE netlists follow this basic structure:

```spice
* Title line (must be first)
.title My Circuit

* Power supplies
VDD vdd 0 DC 5V

* Components (R, C, L, M, etc.)
M1 drain gate source bulk NMOS W=10u L=2u

* Analysis commands
.op
.dc VIN 0 5 0.01
.ac dec 100 1 1G

* Control commands (ngspice specific)
.control
run
plot v(output)
quit
.endc

.end
```

Place your custom netlists in the `src/netlists/` directory.

## Project Structure

```
FCT-compiler/
├── README.md              # This file
├── simulate.sh            # Simulation script
└── src/
    └── netlists/          # SPICE netlist files
        └── 5_transistor_amplifier.cir
```

## Simulation Workflow

1. **Create/Edit Netlist**: Write your circuit in SPICE syntax (.cir file)
2. **Run Simulation**: Execute `./simulate.sh <netlist.cir>`
3. **Analyze Results**: Review the output log file
4. **Iterate**: Modify circuit parameters and re-simulate

## SPICE Syntax Reference

### Common Components

- **Resistor**: `R<name> <node1> <node2> <value>`
- **Capacitor**: `C<name> <node1> <node2> <value>`
- **Inductor**: `L<name> <node1> <node2> <value>`
- **Voltage Source**: `V<name> <node+> <node-> DC <value>`
- **MOSFET**: `M<name> <drain> <gate> <source> <bulk> <model> W=<> L=<>`

### Analysis Types

- **DC Operating Point**: `.op`
- **DC Sweep**: `.dc <source> <start> <stop> <step>`
- **AC Analysis**: `.ac <dec|lin|oct> <points> <fstart> <fstop>`
- **Transient**: `.tran <tstep> <tstop>`

## Troubleshooting

### ngspice not found
Make sure ngspice is installed and in your PATH.

### Simulation errors
- Check netlist syntax (ensure .end is present)
- Verify component values are valid
- Check for node connectivity issues

## Contributing

Feel free to add more example netlists to the `src/netlists/` directory!

## License

This project is open source and available for educational and research purposes.
