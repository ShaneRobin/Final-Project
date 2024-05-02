`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  
  // output  
  output logic [7:0] led,
  output logic       sseg_ca,
  output logic       sseg_cb,
  output logic       sseg_cc,
  output logic       sseg_cd,
  output logic       sseg_ce,
  output logic       sseg_cf,
  output logic       sseg_cg,
  output logic       sseg_dp,
  output logic [3:0] sseg_an,
  output logic [2:0] hdmi_d_p,  
  output logic [2:0] hdmi_d_n,   
  output logic       hdmi_clk_p,   
  output logic	     hdmi_clk_n,
   
  inout logic	     hdmi_cec,  
  inout logic	     hdmi_sda,   
  inout logic	     hdmi_scl,   
  input logic	     hdmi_hpd
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
   
  // Place Conway Game of Life instantiation here
logic [63:0] seed;
assign seed = 64'h00E7_0000_0000_E700;
//  start this is switch 0
//  rand_seed this is switch 1
//  reset this is switch 2
logic [63:0] grid_out;

clk_div clk1 (sysclk_125mhz, btn[2], logic clk_en);
Magic bullhonky (clk_en,seed, sw[0], sw[1], sw[2], grid_out);
  // HDMI
  // logic hdmi_out_en;
  //assign hdmi_out_en = 1'b0;
  hdmi_top test (grid_out, sysclk_125mhz, hdmi_d_p, hdmi_d_n, hdmi_clk_p, 
		         hdmi_clk_n, hdmi_cec, hdmi_sda, hdmi_scl, hdmi_hpd);
  
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(0),
  .digit1(0),
  .digit2(0),
  .digit3(0),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
