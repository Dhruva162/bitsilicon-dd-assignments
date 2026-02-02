module stopwatch_top (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    input  wire reset,
    output wire [7:0] minutes,
    output wire [5:0] seconds,
    output wire [1:0] status
);

    wire count_en;
    wire sec_tick;

    // control FSM
    control_fsm ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .reset(reset),
        .enable_count(count_en),
        .state(status)
    );

    // seconds counter
    seconds_counter sec_cnt (
        .clk(clk),
        .rst_n(rst_n),
        .enable(count_en),
        .seconds(seconds),
        .tick_minute(sec_tick)
    );

    // minutes counter
    minutes_counter min_cnt (
        .clk(clk),
        .rst_n(rst_n),
        .enable(sec_tick),
        .minutes(minutes)
    );

endmodule
