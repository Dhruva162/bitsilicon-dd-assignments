module tb_stopwatch;

    reg clk;
    reg rst_n;
    reg start;
    reg stop;
    reg reset;

    wire [7:0] minutes;
    wire [5:0] seconds;
    wire [1:0] status;

    // clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // DUT instantiation
    stopwatch_top uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .reset(reset),
        .minutes(minutes),
        .seconds(seconds),
        .status(status)
    );

    initial begin
        // default values
        rst_n  = 0;
        start = 0;
        stop  = 0;
        reset = 0;

        // apply reset
        #15;
        rst_n = 1;

        // start counting
        #10;
        start = 1;
        #10;
        start = 0;

        // let it run
        #180;

        // pause
        stop = 1;
        #10;
        stop = 0;

        // wait while paused
        #80;

        // resume
        start = 1;
        #10;
        start = 0;

        // run again
        #120;

        // clear stopwatch
        reset = 1;
        #10;
        reset = 0;

        #50;
        $finish;
    end

endmodule
