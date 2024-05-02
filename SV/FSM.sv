module FSM (clk, start, rand_seed, reset,mux_start,show_rand_seed,lfsr_begin);
   input logic  clk;
   input logic  start;
   input logic  rand_seed;
   input logic 	reset;
   output logic mux_start;
   output logic show_rand_seed;
   output logic lfsr_begin;
   

   typedef enum 	logic [1:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	   
    if (start && rand_seed) nextstate <= S3; 
	else if (start) nextstate <= S1;
    else if (rand_seed) nextstate <= S2;
    else nextstate <= S0;
    mux_start = 0;  //only show manual seed
    show_rand_seed = 0;
    lfsr_begin = 0;

       end
       S2: begin
    
    if (start && rand_seed) nextstate <= S3; 
	else if (start) nextstate <= S1;
    else if (rand_seed) nextstate <= S2;
    else nextstate <= S0;
    mux_start = 1;  //Start game manual 
    show_rand_seed = 0;
    lfsr_begin = 0;
       end
       S3: begin
	if (start && rand_seed) nextstate <= S3; 
	else if (start) nextstate <= S1;
    else if (rand_seed) nextstate <= S2;
    else nextstate <= S0;
    mux_start = 1;  //Start game w/ rand seed
    show_rand_seed = 1;
    lfsr_begin = 0;
       end
       S1: begin
    if (start && rand_seed) nextstate <= S3; 
	else if (start) nextstate <= S1;
    else if (rand_seed) nextstate <= S2;
    else nextstate <= S0;
    mux_start = 1;  //Show rand seed
    show_rand_seed = 1;
    lfsr_begin = 1;
       end
       default: begin
    mux_start = 0;  //only show manual seed
    show_rand_seed = 0;
    lfsr_begin = 0;	  	  
	  nextstate <= S0;
       end
     endcase
       endmodule