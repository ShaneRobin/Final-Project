
/*module flopr #(parameter WIDTH = 8) ( 
  input  logic             clk, reset,
  input  logic [WIDTH-1:0] d, 
  output logic [WIDTH-1:0] q);

  always_ff @(posedge clk)
    if (reset) q <= #1 0;
    else       q <= #1 d;
endmodule*/

module game(output logic [63:0] grid_out, input logic clk,  input logic reset, input logic [63:0]seed,input select,input show_rand_seed);
logic [63:0] y;
logic [63:0] d;
logic [63:0] q;


mux2 #(64) dut(q,seed,select,y);
flopr #(64) gut(clk, reset,d,q);
datapath dp(y,d); 
mux2 #(64) sut(q,seed,show_rand_seed,grid_out);

endmodule
