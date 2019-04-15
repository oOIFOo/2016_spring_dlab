`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date:    11:26:45 11/23/2016 
// Design Name: 
// Module Name:    lab8 
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
module lab8(
  input clk,
  input reset,
  input button,
  output [7:0] led,
  output LCD_E,
  output LCD_RS,
  output LCD_RW,
  output [3:0] LCD_D
  );

  // declare system variables
  wire btn_level, btn_pressed;
  reg prev_btn_level;
  reg [127:0] row_A, row_B;
  reg [127:0] pixel_addr_msg;
  reg [127:0] pixel_data_msg;
  reg [15:0]  pixel_addr;
  reg [15:0]   pixel_data;

  // declare SRAM control signals
  wire [13:0] sram_addr;
  wire [7:0]  data_in;
  wire [7:0]  data_out;
  wire        we, en;
  
  ///////////////////////////////
   localparam [3:0] S_MAIN_IDLE = 0, S_MAIN_WAIT = 1, S_MAIN_COMPUTE = 2, S_MAIN_ANS = 3, S_MAIN_RESET = 4;
   reg  [2:0] P, P_next;
	wire [2:0]g[4:0];
	reg [7:0]f[4:0];
	assign g[0] = 3'b101;
	assign g[1] = 3'b110;
	assign g[2] = 3'b000;
	assign g[3] = 3'b010;
	assign g[4] = 3'b001;
	reg [15:0]sum;
	reg [15:0]ans;
	reg [15:0]addr;
	reg [2:0] idx;
	reg [2:0]counter;
	reg [15:0]finish;
	reg [15:0]tmp[4:0];


  assign led = finish;

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

  // ------------------------------------------------------------------------
  // The following code describes an initialized SRAM memory block that
  // stores an 160x90 8-bit graylevel image.
  sram ram0(.clk(clk), .we(we), .en(en),
            .addr(sram_addr), .data_i(data_in), .data_o(data_out));

  assign we = 0; // Make the SRAM read-only.
  assign en = 1; // Always enable the SRAM block.
  assign sram_addr = addr;
  assign data_in = 8'b0; // SRAM is read-only so we tie inputs to zeros.
  // End of the SRAM memory block.
  // ------------------------------------------------------------------------
  /*counter = 0;
	for (y = 1; y < 89; y++)
	{
		for (x = 0; x < 160; x++){
			sum = 0;
			for (k = 0; k < 5; k++){
				sum += f[(y*160+x)+(k-2)]*g[4-k];
			}
			if (abs(sum) > 200) counter++;
		}
	}
	printf("The number of edge pixels = %04x.\n", counter);*/
	always @(posedge clk) begin
		if(reset) P <= S_MAIN_WAIT;
		else P <= P_next;
	end
	
	always @(*) begin
		case(P)
			S_MAIN_IDLE:
				if(reset) P_next = S_MAIN_WAIT;
				else P_next = S_MAIN_IDLE;
			S_MAIN_WAIT:
				if(addr > 164) P_next = S_MAIN_COMPUTE;
				else  P_next = S_MAIN_WAIT;
			S_MAIN_COMPUTE:
				if(counter > 4) P_next = S_MAIN_ANS;
				else P_next = S_MAIN_COMPUTE;
			S_MAIN_ANS:
				P_next = S_MAIN_RESET;
			S_MAIN_RESET:
				if(finish > (160*89 - 1)) P_next = S_MAIN_IDLE;
				else P_next = S_MAIN_WAIT;
				
			default P_next = S_MAIN_IDLE;
		endcase
	end
	
	always @(posedge clk) begin
		if(reset) finish <= 164;
		else if(P == S_MAIN_RESET) finish <= finish + 1;
	end
	
	always @(posedge clk) begin
		if(reset) addr <= 160;
		else if(P == S_MAIN_WAIT) addr <= addr + 1;
	end
	
	always @(posedge clk) begin
		if(reset) ans <= 0;
		else if(P == S_MAIN_ANS && sum[14:0] > 200) ans <= ans + 1;
	end
	
	always @(posedge clk) begin
		if(P == S_MAIN_WAIT)begin
			f[0] <= f[1];
			f[1] <= f[2];
			f[2] <= f[3];
			f[3] <= f[4];
			f[4] <= data_out;
		end
	end
	
	always @(posedge clk) begin
		if(reset || P == S_MAIN_RESET) begin
			sum <= 0;
			counter <= 0;
		end
		/*else if(P == S_MAIN_COMPUTE) begin
			if(g[counter][2] == sum[15]) begin
				sum[14:0] <= sum[14:0] + g[counter][1:0] * f[counter][7:0];
			end
			else begin
				if(sum[14:0] >= g[counter][1:0] * f[counter][7:0]) begin
					sum[14:0] <= sum[14:0] - g[counter][1:0] * f[counter][7:0];
				end
				else begin
					sum[15] <= ~sum[15];
					sum[14:0] <= g[counter][1:0] * f[counter][7:0] - sum[14:0];
				end
			end
			counter <= counter + 1;
		end	*/	
		else if(P == S_MAIN_COMPUTE) begin
			if(counter == 0) begin
				tmp[0] <= g[0][1:0] * f[0][7:0];
				tmp[1] <= g[1][1:0] * f[1][7:0];
				tmp[3] <= g[3][1:0] * f[3][7:0];
				tmp[4] <= g[4][1:0] * f[4][7:0];
			end
			else if(counter == 1) begin
				tmp[0] <= tmp[0] + tmp[1];
				tmp[3] <= tmp[3] + tmp[4];
			end
			else if(counter == 2)begin
				if(tmp[0][14:0] >= tmp[3][14:0]) begin
					sum[14:0] <= tmp[0] - tmp[3];
				end
				else begin
					sum[14:0] <= tmp[3] - tmp[0];
				end
			end
			counter <= counter + 1;
		end
	end
  // ------------------------------------------------------------------------
  // The following code updates the 1602 LCD text messages.
  always @(posedge clk) begin
    if (reset) begin
      pixel_addr_msg <= "The edge pixel  ";
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      pixel_data_msg <= "  number is xxxx";
    end
    else begin
			pixel_data_msg[31:24] <= ((ans[15:12] > 9)? "7" : "0") + ans[15:12];
			pixel_data_msg[23:16] <= ((ans[11:8] > 9)? "7" : "0") + ans[11:8];
      pixel_data_msg[15:8] <= ((ans[7:4] > 9)? "7" : "0") + ans[7:4];
      pixel_data_msg[7:0] <= ((ans[3:0] > 9)? "7" : "0") + ans[3:0];
    end
  end
  // End of the 1602 LCD text-updating code.
  // ------------------------------------------------------------------------

  // ------------------------------------------------------------------------
  // The following code detects the positive edge of the button-press signal.
  always @(posedge clk) begin
    if (reset)
      prev_btn_level <= 1'b1;
    else
      prev_btn_level <= btn_level;
  end

  assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1'b1 : 1'b0;
  // End of button-press signal edge detector.
  // ------------------------------------------------------------------------

  // ------------------------------------------------------------------------
  // The main code that processes the user's button event.
  reg data_fetch;

  always @(posedge clk) begin
    if (reset) begin
      pixel_addr <= 16'hffff;
      data_fetch = 0;
    end
    else if (btn_pressed) begin
      pixel_addr <= pixel_addr + 1;
      data_fetch = 1;
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      row_A <= "Press WEST to do";
      row_B <= "edge detection..";
      pixel_data <= 8'b0;
    end
    else if (data_fetch) begin
      row_A <= pixel_addr_msg;
      row_B <= pixel_data_msg;
      pixel_data <= data_out;
    end
  end
  // End of the main code.
  // ------------------------------------------------------------------------

endmodule
