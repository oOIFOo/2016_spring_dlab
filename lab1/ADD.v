`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:46 09/21/2016 
// Design Name: 
// Module Name:    ADD 
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
module FA_1bit(A, B, Cin, sum, carry); 
input A, B, Cin; 
output sum, carry;
assign sum = Cin ^ A ^ B; 
assign carry = (A & B) | (Cin & B) | (Cin & A); 
endmodule

