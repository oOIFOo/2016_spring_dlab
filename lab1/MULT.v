`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:32 09/21/2016 
// Design Name: 
// Module Name:    MULT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MULT(
	input wire clk,
	input wire enable,
	input wire [7:0] A,
	input wire [7:0] B,
	output wire [15:0] out
);
	reg [15:0]sum;
	integer i, j;
	wire [15:0] t;

	assign out = sum;
	always @( posedge clk )
	if( ~enable ) begin 
		i <= 8;
		j <= 0;
		sum <= 0;
	end
	
	else 
	begin	
		if(i > 0)
		begin
			i <= i - 1;
			sum = sum << 1;
			if(B[i - 1] == 1)
			begin	
				sum = sum + A;			
			end		
		end
	end
	
endmodule
