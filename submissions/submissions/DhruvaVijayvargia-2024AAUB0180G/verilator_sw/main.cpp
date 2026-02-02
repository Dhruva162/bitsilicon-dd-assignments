#include "Vstopwatch_top.h"
#include "verilated.h"
#include <iostream>
#include <iomanip>

// simulation time for Verilator
vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

// one clock cycle
void tick(Vstopwatch_top* top) {
    top->clk = 0;
    top->eval();

    top->clk = 1;
    top->eval();

    main_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vstopwatch_top* top = new Vstopwatch_top;

    // initialize inputs
    top->clk = 0;
    top->start = 0;
    top->stop  = 0;
    top->reset = 0;

    // global reset (active low)
    top->rst_n = 0;
    tick(top);
    tick(top);
    top->rst_n = 1;

    // clear stopwatch
    top->reset = 1;
    tick(top);
    top->reset = 0;

    // start stopwatch
    top->start = 1;
    tick(top);
    top->start = 0;

    // run for some time
    for (int i = 0; i < 60; i++) {
        tick(top);
        std::cout << std::setw(2) << std::setfill('0') << (int)top->minutes
                  << ":"
                  << std::setw(2) << std::setfill('0') << (int)top->seconds
                  << std::endl;
    }

    // stop (pause)
    top->stop = 1;
    tick(top);
    top->stop = 0;

    // wait while paused
    for (int i = 0; i < 5; i++) {
        tick(top);
    }

    // resume stopwatch
    top->start = 1;
    tick(top);
    top->start = 0;

    // run a bit more
    for (int i = 0; i < 15; i++) {
        tick(top);
        std::cout << std::setw(2) << std::setfill('0') << (int)top->minutes
                  << ":"
                  << std::setw(2) << std::setfill('0') << (int)top->seconds
                  << std::endl;
    }

    delete top;
    return 0;
}
