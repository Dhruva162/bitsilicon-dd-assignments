module seconds_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire enable,
    output reg  [5:0] seconds,
    output reg  tick_minute
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seconds     <= 6'd0;
            tick_minute <= 1'b0;
        end
        else if (enable) begin
            if (seconds == 6'd59) begin
                seconds     <= 6'd0;
                tick_minute <= 1'b1;
            end
            else begin
                seconds     <= seconds + 6'd1;
                tick_minute <= 1'b0;
            end
        end
        else begin
            tick_minute <= 1'b0;
        end
    end

endmodule
