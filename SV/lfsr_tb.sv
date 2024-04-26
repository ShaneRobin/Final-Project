// testbench to prove maximal LFSR

   //logic variables to route input and output to DUT
module tb (seed, clk, reset, shift_seed);
  input logic seed;
  input logic clk;
  input logic reset;
  output logic shift_seed;
  integer handle3;
  integer desc3;
   //create file handles to write results to a file

   // instantiate device under test (small LFSR)
  lfsr band(seed, clk, reset, shift_seed);
   //set up a clock signal
   always     
     begin
	clk = 1; #1; clk = 0; #1;
     end
   initial
     begin
         handle3 = $fopen("lfsr_out.out");
         desc3 = handle3;
     end

   always @(posedge clk)
     begin
		//output your results to a file 
     $fdisplay (desc3, "%h %h || %b "
      seed, shift_seed, reset,)

     end

   // check results on falling edge of clk
   always @(negedge clk) begin
		if(~reset) begin
		//check if your output equals the initial output 
		//if so, report how many iterations it took to repeat
		//this should be (2^n) - 1
		//if the output never repeats for 2^n iterations, report that
		end
	end
   
endmodule // tb

