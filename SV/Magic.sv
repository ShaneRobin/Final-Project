module Magic(clk,seed, start, rand_seed, reset, grid_out);
input logic clk;
input logic [63:0] seed;
input logic start; // this is a switch to fsm
input logic rand_seed; //this is a switch to fsm
input logic reset; //this is to reset fsm
output logic [63:0] grid_out; 
logic [63:0]shift_seed;

game job (grid_out, clk,logic flop_reset,seed,logic mux_start,logic show_rand_seed);
FSM fluk(clk, start, rand_seed, reset,mux_start,show_rand_seed,logic lfsr_begin);
lfsr64 band(seed, clk, lfsr_begin, shift_seed);






endmodule