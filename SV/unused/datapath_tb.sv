`timescale 1ns / 1ps
module stimulus ();

   logic        [63:0]grid;
   logic 	[63:0]grid_evolve;

   logic        clk;   
   
  // instantiate device under test
   datapath dut (grid, grid_evolve);

   // 2 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end


   initial
     begin
    
	#0   grid = $random;	
		

	#20  grid = $random;	


	#20  grid = $random;	
		

	#20  grid = $random;	
		

	#20  grid = $random;	
		

	#20  grid = $random;	
		

	#20  grid = $random;			
	
     end

   
endmodule
