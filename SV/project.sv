
/*module flopr #(parameter WIDTH = 8) ( 
  input  logic             clk, reset,
  input  logic [WIDTH-1:0] d, 
  output logic [WIDTH-1:0] q);

  always_ff @(posedge clk)
    if (reset) q <= #1 0;
    else       q <= #1 d;
endmodule*/

module game(grid_out, clk, flop_reset, seed,mux_start,show_rand_seed_sw);
logic [63:0] y;
logic [63:0] d;
logic [63:0] q;

output logic [63:0] grid_out;
input logic clk;
input logic flop_reset;
input logic [63:0]seed;
input logic mux_start;
input logic show_rand_seed_sw;


mux2 dut(q,seed,mux_start,y);
flopr gut ( clk, flop_reset, d, q);
datapath dp(y,d); 
mux2 sut(q,seed,show_rand_seed_sw,grid_out);

endmodule
