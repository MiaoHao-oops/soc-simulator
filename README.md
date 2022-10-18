# SoC-Simulator

A [Verilator](https://www.veripool.org/verilator/) based SoC simulator that allows you to define AXI Slave interface in software.

## Features

Device Support:

- UARTLite

Easy to co-simulate with [cemu](https://github.com/cyyself/cemu).

## Quick Start

- Refer to Makefile and modify variables `TOP_NAME`, `INC_FILE`, `INC_DIR` and `INC_PATH`:
  - `TOP_NAME`: the name of your CPU top module
  - `INC_FILE`: all RTL code files included in your design
  - `INC_DIR`: home directory of RTL header files
  - `INC_PATH`: cemu core home

- Makefile targets:
  - default: generate executable simulation module `obj_dir/V$(TOP_NAME)`
  - `run_func`: run function tests, diff with golden trace in `test/func/golden_trace.txt` with AXI latency 34 (read the source code for detail)
  - `run_perf`: run all performance tests without diff test
  - `diff_perf`: run all performance tests diff with cemu
  - `diff_{bitcount, bubblesort, ..., stringsearch}`: run specified performance test and diff with cemu (suggested)

- Makefile variables:
  - `T`: dump waveform when `T` is set to `y` in repo home directory (note: you'd better dump waveform after the module report Error since the waveform file requires large disk space.)

- Examples:
  - run function tests and dump waveform file: `make run_func T=y`
  - run crc32 and diff with cemu: `make diff_crc32`

## Example Usage

[Simulate Rocket-Chip](doc/rocket.md)