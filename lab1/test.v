`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:35:24 09/25/2016
// Design Name:   MULT
// Module Name:   C:/xilinx/DEMO/test.v
// Project Name:  DEMO
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MULT
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
	reg enable;
	reg [7:0] A;
	reg [7:0] B;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	MULT uut (
		.clk(clk), 
		.enable(enable), 
		.A(A), 
		.B(B), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		enable = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		enable = 1;
		A = 8'b00100101;
		B = 8'b00001111;
	end
     
	always
	begin
	#50
	clk = ~clk;
	end
endmodule

