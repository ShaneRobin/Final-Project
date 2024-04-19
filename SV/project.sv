
/*module flopr #(parameter WIDTH = 8) ( 
  input  logic             clk, reset,
  input  logic [WIDTH-1:0] d, 
  output logic [WIDTH-1:0] q);

  always_ff @(posedge clk)
    if (reset) q <= #1 0;
    else       q <= #1 d;
endmodule*/

module game(output logic [63:0] q, input logic clk,  input logic reset,input logic [63:0]seed);
logic [63:0] y;
logic [63:0] d;


mux2 #(64) dut(q,seed,reset,y);
flopr #(64) gut(clk, reset,d,q);
datapath dp(y,d); 


endmodule
