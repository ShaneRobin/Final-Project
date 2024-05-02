module FSM (clk,rand_seed,start ,reset,mux_start,show_rand_seed,lfsr_begin);
   input logic  clk;
   input logic  start; //sw0
   input logic  rand_seed; //sw1
   input logic 	reset; //sw3
   output logic mux_start;
   output logic show_rand_seed;
   output logic lfsr_begin;
   //rand_seed is sw0
   // Start is sw1
   // RESET is sw2

   typedef enum 	logic [1:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin //reset state, sets seed
	   
          if (start && rand_seed) nextstate <= S3; 
	      else if (start) nextstate <= S1;
          else if (rand_seed) nextstate <= S2;
          else nextstate <= S0;
              mux_start = 1;       //this is wrong mux_start needs flipped, or renamed to mux_stop
              show_rand_seed = 1;  //this is correct
              lfsr_begin = 1;      //lfsr begin grabs manual seed when true

       end
       S1: begin     //s1 gets manual seed and runs from S0
              if (start && rand_seed) nextstate <= S3; 
	            else if (start) nextstate <= S1;
              else if (rand_seed) nextstate <= S2;
              else nextstate <= S0;
              mux_start = 0;       //this is wrong mux_start needs flipped, or renamed to mux_stop
              show_rand_seed = 0;  //this is correct
              lfsr_begin = 1;      //lfsr begin grabs manual seed when true
       end
       S2: begin // s2 runs lfsr and shows rand seed
    
             if (start && rand_seed) nextstate <= S3; 
	         else if (start) nextstate <= S1;
             else if (rand_seed) nextstate <= S2;
             else nextstate <= S0;
              mux_start = 1;       //this is wrong mux_start needs flipped, or renamed to mux_stop
              show_rand_seed = 1;  //this is correct
              lfsr_begin = 0;      //lfsr begin grabs manual seed when true
       end
       S3: begin // s3 loads lfsr and runs it    
	         if (start && rand_seed) nextstate <= S3; 
	         else if (start) nextstate <= S1;
             else if (rand_seed) nextstate <= S2;
             else  nextstate <= S0;
             mux_start = 0;       //this is wrong mux_start need s flipped, or renamed to mux_stop
             show_rand_seed = 0; //this is correct
             lfsr_begin = 0;      //this is correct
       end
       
       default: begin
            mux_start = 0;  //only show manual seed
            show_rand_seed = 0;
            lfsr_begin = 0;	  	  
	          nextstate <= S0;
       end
     endcase
       endmodule