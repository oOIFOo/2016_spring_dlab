`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:34 10/03/2016 
// Design Name: 
// Module Name:    dddd 
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
/* 
(C) OOMusou 2008 http://oomusou.cnblogs.com

Filename    : counter10.v
Compiler    : Quartus II 7.2 SP3 + ModelSim-Altera 6.1g
Description : Demo how to write synchronous decimal counter
Release     : 07/13/2008 1.0
*/

module counter10 (
  input            clk,
  input            clr,
  input            load,
  input            en,
  input      [3:0] data,
  output reg [3:0] q,
  output reg       cout
);

always@(posedge clk) begin
  if (clr == 1'b1)
    q <= 0;
  else if (load == 1'b1)
    q <= data;
  else if (en == 1'b1) begin
    if (q == 9)
      q <= 0;
    else
      q <= q + 1;
  end
end

always@(q) begin
  if (q == 9)
    cout = 1;
  else
    cout = 0;
end

endmodule