`timescale 1ns / 1ps
module stimulus ();

   //logic        [63:0]grid;
   //logic 	[63:0]grid_evolve;
   logic [63:0] y;
   logic [63:0] d;
   logic        reset;
   logic [63:0] seed;
   logic        clk;
   logic [63:0] q;   
   
  // instantiate device under test
   
   game dut(q,clk,reset,seed);
   

   // 2 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end


   initial
     begin
    
	#0   seed = $r;	
		reset = 1'b1;
    #40 reset = 1'b0;

	//#20  seed = $random;	


	//#20  seed = $random;	
		

	//#20  seed = $random;	
		

	//#20  seed = $random;	
		

	//#20  seed = $random;	
		

	//#20  seed = $random;			
	
     end

   
endmodule
