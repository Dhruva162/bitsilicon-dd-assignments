module control_fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    input  wire reset,
    output reg  enable_count,
    output reg  [1:0] state
);

    // state encoding
    localparam IDLE    = 2'd0;
    localparam RUNNING = 2'd1;
    localparam PAUSED  = 2'd2;

    // state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else if (reset) begin
            state <= IDLE;
        end else begin
            if (state == IDLE) begin
                if (start)
                    state <= RUNNING;
            end
            else if (state == RUNNING) begin
                if (stop)
                    state <= PAUSED;
            end
            else if (state == PAUSED) begin
                if (start)
                    state <= RUNNING;
            end
            else begin
                state <= IDLE;
            end
        end
    end

    // output logic
    always @(*) begin
        enable_count = 0;
        if (state == RUNNING)
            enable_count = 1;
    end

endmodule
