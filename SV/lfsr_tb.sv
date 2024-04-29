// testbench to prove maximal LFSR

   //logic variables to route input and output to DUT
module stimulus ();
  logic [15:0]seed;
  logic clk;
  logic reset;
  logic [15:0]shift_seed;
  integer handle3;
  integer desc3;
  integer counter;
  
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
     $fdisplay (desc3, "%b %b || %b || %d",
      seed, shift_seed, reset, counter);
      

     end



   // check results on falling edge of clk
   always @(negedge clk) 
    begin 
  
		if(~reset) begin
		//check if your output equals the initial output 
    if (shift_seed != seed)
		//if so, report how many iterations it took to repeat
      begin 
      counter = counter + 1;
      end
    if (shift_seed == seed && counter != 0)begin
    $fdisplay(desc3, "%b", counter);
    $finish;
    end
		//this should be (2^n) - 1
		//if the output never repeats for 2^n iterations, report that
    if (counter == (65545)) begin
    $finish;  
    begin
    $display("%d This seed does not repeat", counter);
    $finish;
		end
    end
    end
	end
   initial
   begin 
    #0 assign seed = 64'h00E7_0000_0000_E700;
 #0 reset = 1'b1;
 #0 counter = 32'b0;
 #10 reset = 1'b0;
   end

endmodule // tb

