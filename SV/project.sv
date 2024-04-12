
module flopr #(parameter WIDTH = 8) ( 
  input  logic             clk, reset,
  input  logic [WIDTH-1:0] d, 
  output logic [WIDTH-1:0] q);

  always_ff @(posedge clk)
    if (reset) q <= #1 0;
    else       q <= #1 d;
endmodule

module game(input logic d, output  logic q, input logic clk,  input logic reset,);

flopr #(64)dut(d,q,clk, reset);
    

datapath #(64)dp(d,q);
    input logic d; 
    output logic q;

endmodule