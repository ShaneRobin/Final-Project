module Magic(clk,seed, start, rand_seed, reset, grid_out);
input logic clk;
input logic [63:0] seed;
input logic start; // this is a switch to fsm
input logic rand_seed; //this is a switch to fsm
input logic reset; //this is to reset fsm
output logic [63:0] grid_out; 

// start is sw 0
// rand_ seed is sw1
// reset is sw2

logic [63:0]shift_seed;

logic flop_reset;
logic mux_start;
logic show_rand_seed;
logic lfsr_begin;

FSM fluk(clk, start, rand_seed, reset,mux_start,show_rand_seed,lfsr_begin);

lfsr64 band(seed, clk, lfsr_begin, shift_seed);

game job (grid_out, clk,flop_reset,shift_seed,mux_start,show_rand_seed);


endmodule