module lfsr(seed, clk, reset, shift_seed);
//inputs and outputs for a smaller implementation
//perhaps 8 or 16 bits

//your implementation of the LFSR.  Remember that this 
//implementation has memory so it should be done 
//with some form of a flip-flop based register
input logic seed; 
input logic clk; 
input logic reset;
input logic [15:0]shift_seed;

always @(posedge clk) begin

    if(reset) begin
    shift_seed = seed;
    end
    else begin
    shift_seed = {shift_seed[14:0], shift_seed[15]^shift_seed[12]^shift_seed[3]};
    end
end

endmodule


module lfsr64 (seed, clk, reset, shift_seed);
//inputs and outputs for the full seed size (64 bits)

//either build a 64 bit version using your smaller implementation above
//or use the same methods from the xilinx document to build a full
//64 bit version
input logic seed; 
input logic clk; 
input logic reset;
output logic [63:0]shift_seed;

always @ (posedge clk) begin

    if (reset) begin
    shift_seed = seed;
    end
    else begin
    shift_seed = {shift_seed[63:0], shift_seed[63]^shift_seed[62]^shift_seed[60]^shift_seed[59]};
    end
end

endmodule