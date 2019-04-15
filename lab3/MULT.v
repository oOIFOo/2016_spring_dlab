`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:20 10/05/2016 
// Design Name: 
// Module Name:    morse 
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
module morse(
input clk,
input enable,
input [79:0] in_bits,
output reg [34:0] out_text,
output reg valid
    );
reg [12:0] tmp;
reg tail;
reg [4:0] i;
reg [1:0] next;
reg [79:0] in;
reg [2:0]number;
always@(posedge clk)
begin
	if(!tail)
	begin
		if(in[79] == 0)
		begin
			next <= next + 1;
		end
		else
			next <= 0;	
	end
end

always@(posedge clk)
begin
	if(!enable)
	begin
		tmp = 0;
		tail = 0;
		next = 0;
		in = in_bits;
		i = 0;
		out_text = 0;
		valid = 0;
		number = 0;
	end
end
			
always@(posedge clk)
begin
	if(enable && !tail)
	begin
		if(next != 2)
		begin
			tmp[i] <= in[79];
			i <= i + 1;
		end
		else if(next == 2)
		begin
			if(number < 5)
				tail <= 1;
			i <= 0;
		end
		if(number >= 4)
			valid <= 1;
		in <= in << 1;
	end
end

always@(posedge clk)
begin
	if(tail)
	begin
		tail <= 0;
		if(tmp[2:0] == 3'b111)
			if(tmp[6:4] == 3'b111)
				if(tmp[10:8] == 3'b111)
					out_text = {out_text[27:0] , 7'b1001111};//O
				else if(tmp[8])
					if(tmp[12:10] == 3'b111)
						out_text = {out_text[27:0] , 7'b1010001};//Q
					else if(tmp[10])
						out_text = {out_text[27:0] , 7'b1011010};//Z
					else
						out_text = {out_text[27:0] , 7'b1000111};//G
				else
					out_text = {out_text[27:0] , 7'b1001101};//M
			else if(tmp[4]) 
				if(tmp[8:6])
					if(tmp[12:10] == 3'b111)
						out_text = {out_text[27:0] , 7'b1011001};//Y
					else if(tmp[10])
						out_text = {out_text[27:0] , 7'b1000011};//C
					else
						out_text = {out_text[27:0] , 7'b1001011};//K
				else if(tmp[6])
					if(tmp[10:8] == 3'b111)
						out_text = {out_text[27:0] , 7'b1011000};//X
					else if(tmp[8])
						out_text = {out_text[27:0] , 7'b1000010};//B
					else
						out_text = {out_text[27:0] , 7'b1000100};//D
				else
					out_text = {out_text[27:0] , 7'b1001110};//N
			else
				out_text = {out_text[27:0] , 7'b1010100};//T
		else
			if(tmp[4:2] == 3'b111)
				if(tmp[8:6] == 3'b111)
					if(tmp[12:10] == 3'b111)
						out_text = {out_text[27:0] , 7'b1001010};//J
					else if(tmp[10])
						out_text = {out_text[27:0] , 7'b1010000};//P
					else
						out_text = {out_text[27:0] , 7'b1010111};//W
				else if(tmp[6])
					if(tmp[8])
						out_text = {out_text[27:0] , 7'b1001100};//L
					else
						out_text = {out_text[27:0] , 7'b1010010};//R
				else
					out_text = {out_text[27:0] , 7'b1000001};//A
			else if(tmp[2])
				if(tmp[6:4] == 3'b111)
					if(tmp[8])
						out_text = {out_text[27:0] , 7'b1000110};//F
					else
						out_text = {out_text[27:0] , 7'b1010101};//U
				else if(tmp[4])
					if(tmp[8:6] == 3'b111)
						out_text = {out_text[27:0] , 7'b1010110};//V
					else if(tmp[6])
						out_text = {out_text[27:0] , 7'b1001000};//H
						else
						out_text = {out_text[27:0] , 7'b1010011};//S
				else
					out_text = {out_text[27:0] , 7'b1001001};//I
			else
				out_text = {out_text[27:0] , 7'b1000101};//E
		//out_text <= tmp;
		number <= number + 1;		
		tmp <= 0;
	end
end
endmodule
