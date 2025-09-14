// colorWheel

module top(
    input logic     clk, 
    output reg      RGB_R,
    output reg      RGB_G,
    output reg      RGB_B
);

    // CLK frequency is 12MHz
    parameter ONE_SECOND = 12000000;
    logic [$clog2(ONE_SECOND) - 1:0] count = 0;

    initial begin
        RGB_R = 1'b0;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end

    always_ff @(posedge clk) begin
        
        // Reset count every second
        if (count == ONE_SECOND - 1) begin
            count <= 0;
            RGB_B = 1'b1;
        end
        else begin
            
            // Change RGB values based on the interval
            case(count)
                ONE_SECOND / 6: RGB_G = 1'b0;
                ONE_SECOND / 3: RGB_R = 1'b1;
                ONE_SECOND / 2: RGB_B = 1'b0;
                ONE_SECOND * 2 / 3: RGB_G = 1'b1;
                ONE_SECOND * 5 / 6: RGB_R = 1'b0;
            endcase
                
            count <= count + 1;
        end
    end

endmodule
