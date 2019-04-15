`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:47 11/22/2015 
// Design Name: 
// Module Name:    lcd 
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
module lab7(
    input clk,
    input reset,
    input  button,
    output LCD_E,
    output LCD_RS,
    output LCD_RW,
		output [7:0] led,
    output [3:0]LCD_D
    );

		// declare a SRAM memory block
		wire [15:0] data_in;
		wire [15:0] data_out;
		wire       we, en;
		wire [8:0] sram_addr;

    wire btn_level, btn_pressed;
    reg prev_btn_level;
    reg [127:0] row_A, row_B;
		reg [15:0]sram;
	  reg [4:0]counter;
	  reg direction;
	  reg start;
	  reg [31:0]tmp;
	  reg [31:0]tmp0;
	  reg [15:0]fibo[3:0];
	  reg finish;
	  reg [32:0]i_need_07_second;
	  reg [4:0]idx;
		
		assign led = fibo[0][15:8];
    
    LCD_module lcd0( 
      .clk(clk),
      .reset(reset),
      .row_A(row_A),
      .row_B(row_B),
      .LCD_E(LCD_E),
      .LCD_RS(LCD_RS),
      .LCD_RW(LCD_RW),
      .LCD_D(LCD_D)
    );
    
    debounce btn_db0(
      .clk(clk),
      .btn_input(button),
      .btn_output(btn_level)
   );
	 
		sram ram0(.clk(clk), .we(we), .en(en),
      .addr(sram_addr), 
			.data_i(data_in), 
			.data_o(data_out)
		);
		assign en = 1;
		assign we = (idx < 26) ? 1 : 0;
		assign sram_addr = (idx < 26) ? idx : counter;
		assign data_in = (idx < 2) ? 0 : (fibo[1] + fibo[0]);
		assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;
		
		always @(posedge clk) begin
      if (reset)
        prev_btn_level <= 1;
      else
        prev_btn_level <= btn_level;
    end
		
    always@(posedge clk) begin////////////what the fuck is SRAM? fucking DLAB////////
			if(reset)begin
				idx <= 1;
				fibo[0] <= 0;
				fibo[1] <= 1;
			end
			
			else if(idx < 26 && idx >2) begin 
				idx <= idx + 1;
				fibo[0] <= fibo[1];
				fibo[1] <= fibo[1] + fibo[0];
			end
			else if(idx < 3) begin
				idx <= idx + 1;
			end
		end
		
		always@(posedge clk) begin
			if(reset)begin
				i_need_07_second <= 0;
			end
			else if(i_need_07_second > 35000000)begin
				i_need_07_second <= 0;
				start <= 1;
			end
			else begin
				i_need_07_second <= i_need_07_second + 1;
				start <= 0;
			end
		end
		
		always@(posedge clk) begin
			if(reset)begin
				counter <= 2;
				direction <= 0;
			end
			if(btn_pressed) begin
				direction <= ~direction;
			end
			
			if(btn_pressed)begin
				if(direction) counter <= counter + 1;
				else counter <= counter - 1;
			end
			else if(i_need_07_second > 35000000) begin
				if(direction == 0) begin
					if(counter == 25)	counter <= 1;
                    else if(counter == 26) counter <= 2;
					else counter <= counter + 1;
				end
				else if(direction == 1) begin
					if(counter == 1) counter <= 25;
                    else if(counter == 0) counter <= 24;
					else counter <= counter - 1;
				end
			end
		end
		
		always@(posedge clk) begin
			if(reset || !(start == 1)) begin
				finish <= 0;
			end
			else if(start == 1) begin
				finish <= 1;
			end
		end
		
    always @(posedge clk) begin
      if (reset) begin
        row_A <= {"Fibo #01 is 0000"}; // "Hello, fucking dlab"
        row_B <= {"Fibo #02 is 0001"}; // Demo of the shit.
      end
      else if (finish) begin
				if(direction == 0)begin
					row_A <= row_B;
					row_B[127:80] <= "Fibo #";
					row_B[79:72] <= counter[4] + "0";
					row_B[71:64] <= counter[3:0] + (counter[3:0] > 9 ? "7":"0");
					row_B[63:32] <= " is ";
					row_B[31:24] <= data_out[15:12] + (data_out[15:12] > 9 ? "7":"0");
					row_B[23:16] <= data_out[11:8] + (data_out[11:8] > 9 ? "7":"0");
					row_B[15:8] <= data_out[7:4] + (data_out[7:4] > 9 ? "7":"0");
					row_B[7:0] <= data_out[3:0] + (data_out[3:0] > 9 ? "7":"0");
				end
				else if (direction == 1)begin
					row_B <= row_A;
					row_A[127:80] <= "Fibo #";
					row_A[79:72] <= counter[4] + "0";
					row_A[71:64] <= counter[3:0] + (counter[3:0] > 9 ? "7":"0");
					row_A[63:32] <= " is ";
					row_A[31:24] <= data_out[15:12] + (data_out[15:12] > 9 ? "7":"0");
					row_A[23:16] <= data_out[11:8] + (data_out[11:8] > 9 ? "7":"0");
					row_A[15:8] <= data_out[7:4] + (data_out[7:4] > 9 ? "7":"0");
					row_A[7:0] <= data_out[3:0] + (data_out[3:0] > 9 ? "7":"0");
				end
      end
    end
endmodule
