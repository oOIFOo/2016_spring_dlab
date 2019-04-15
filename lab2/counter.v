`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:49 10/02/2016 
// Design Name: 
// Module Name:    counter 
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
module counter(
    input clk,
    input reset,
    input east,
    input west,
    output reg [7:0] led
    );
reg [30:0] delay;
reg on , skip;
always@(posedge clk)
begin
	if((east || west) && skip == 0)
		skip = 1;
	else if(skip == 0)
		delay = 0;
	else
		delay = delay + 1;
	if(reset == 1)
		begin
			on = 0;
			led = 0;
			skip = 0;
		end		
/*	if(delay >= 31'd1000000)
	begin*/
		if((east||west))
			on <= 1;
		else 
			on <= 0;
			skip = 0;
		if(on == 0)	
		begin
			if(reset)
			begin
				led = 0;
			end
			else if(led == 7 && east)
			begin
				led = 7;
			end
			else if(led == -8 && west)
			begin
				led = -8;
			end
			else if(east)
				led = led + 1;
			else if(west)
				led = led - 1;
		end
	//end
end



endmodule
