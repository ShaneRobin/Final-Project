module clk_div (input logic clk, input logic rst, output logic clk_en);


   logic [27:0] clk_count;
   

   always_ff @(posedge clk) begin
      if (rst)begin
	clk_count <= 28'h0;
	clk_en <= 1'b0;
      end
      else if (clk_count >= 28'b0011101110011010110010100000)begin
      clk_en = ~clk_en;
      clk_count <= 28'h0;
      end
      else begin
	   clk_count <= clk_count + 1;
	   clk_en <= clk_en;
	  end
   end   
   
   //assign clk_en = clk_count[23];
   
endmodule // clk_div
