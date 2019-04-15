`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:44:52 10/02/2016
// Design Name:   counter
// Module Name:   C:/xilinx/demo/test.v
// Project Name:  demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg reset;
	reg east;
	reg west;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.clk(clk), 
		.reset(reset), 
		.east(east), 
		.west(west), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		east = 0;
		west = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
      west = 1;
		// Add stimulus here
		#100;
		west = 0;
		#100;
		west = 1;
		#100;
		west = 0;
	end
   always
	begin
	#50
	clk = ~clk;
	end
endmodule

