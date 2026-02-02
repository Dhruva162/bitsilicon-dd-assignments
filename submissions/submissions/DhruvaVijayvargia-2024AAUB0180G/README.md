Digital Stopwatch Controller
Name: Dhruva Vijayvargia
Student ID: 2024AAUB0180G

Overview
This assignment implements a simple digital stopwatch that displays time in
minutes and seconds (MM:SS). The design follows a hardware–software co-design
approach. All counting and control logic is written in Verilog, while a C++
program is used to interact with the design using Verilator.

Design Summary
The stopwatch design is divided into separate Verilog modules for clarity.
A control finite state machine (FSM) manages the start, stop, pause, and reset
operations. The FSM has three states: Idle, Running, and Paused.

The seconds counter counts from 0 to 59 and generates a signal when it rolls
over. This signal is used to increment the minutes counter, which counts from
0 to 99. Counting occurs only when the stopwatch is in the Running state.
Reset clears the time to 00:00 and returns the FSM to the Idle state.

Tools Used
- ModelSim-Intel for Verilog simulation
- Verilator for hardware–software co-simulation

Running the Verilator Simulation
From the verilator_sw directory, run:
make
./obj_dir/Vstopwatch_top

The stopwatch output is printed to the terminal in MM:SS format.
