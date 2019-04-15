`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Chiao Tung University
// Engineer: Ya-Chiu Wu
// 
// Create Date:    16:12:38 11/02/2016 
// Module Name:    lab5
// 
// Description:    Lab5 top module
//////////////////////////////////////////////////////////////////////////////////
module lab5(
    // General system I/O ports
    input  clk,
    input  reset,
    input  button,
    input  rx,
    output tx,
    output [7:0] led,

    // SD card specific I/O ports
    output cs,
    output sclk,
    output mosi,
    input  miso
    );

localparam [3:0] S_arr_aIN_INIT = 0, S_arr_aIN_IDLE = 1, S_arr_aIN_INCR = 2,
                 S_arr_aIN_READ = 3, S_arr_aIN_LOOP = 4, S_arr_aIN_FIND_arr_aTRIX = 5,
                 S_arr_aIN_MSG2 = 6, S_arr_aIN_DONE = 7, S_cal = 8, S_DTOH = 9 ,S_REST = 10; 
localparam [1:0] S_UART_IDLE = 0, S_UART_WAIT = 1,
                 S_UART_SEND = 2, S_UART_INCR = 3;
localparam MEM_SIZE = 400;
localparam MESSAGE_STR = 0;

// declare system variables
wire btn_level, btn_pressed;
wire tag_notfound;
reg  prev_btn_level;
reg  print_enable, print_done;
reg  [7:0] send_counter;
reg  [2:0] P, P_next;
reg  [1:0] Q, Q_next;
reg  [9:0] sd_counter;
reg  [31:0] byte4;
reg  [0:(MEM_SIZE-1)*8+7] data;
reg  [0:7*8+7] tag;
reg  [31:0] blk_addr;

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;

// declare SD card interface signals
wire clk_sel;
wire clk_500k;
reg  rd_req;
reg  [31:0] rd_addr;
wire init_finish;
wire [7:0] sd_dout;
wire sd_valid;

// declare a SRAM memory block
wire [7:0] data_in;
wire [7:0] data_out;
wire       we, en;
wire [8:0] sram_addr;

//calculate the arr_ans multiple
reg [15:0] arr_a[15:0];
reg [15:0] arr_b[15:0];
reg [15:0] arr_ans[15:0];
reg [15:0] t0[3:0];
reg [15:0] t1[3:0];
reg [15:0] t2[3:0];
reg [15:0] t3[3:0];
reg [7:0] byte0;
reg  [15:0] byte2;

integer x;////control arry a
integer y;////control arry b
integer x0;////control arry a
integer y0;////control arry b
integer counter;
integer debug;
integer tmp;
reg i;
reg  [7:0]temp,temp1,temp2;

assign clk_sel = (init_finish)? clk : clk_500k; // clocks for the SD controller
assign led = arr_b[1];

debounce btn_db0(
  .clk(clk),
  .btn_input(button),
  .btn_output(btn_level));

uart uart0(
  .clk(clk),
  .rst(reset),
  .rx(rx),
  .tx(tx),
  .transmit(transmit),
  .tx_byte(tx_byte),
  .received(received),
  .rx_byte(rx_byte),
  .is_receiving(is_receiving),
  .is_transmitting(is_transmitting),
  .recv_error(recv_error));

sd_card sd_card0(
  .cs(cs),
  .sclk(sclk),
  .mosi(mosi),
  .miso(miso),

  .clk(clk_sel),
  .rst(reset),
  .rd_req(rd_req),
  .block_addr(rd_addr),
  .init_finish(init_finish),
  .dout(sd_dout),
  .sd_valid(sd_valid));

clk_divider#(100) clk_divider0(
  .clk(clk),
  .rst(reset),
  .clk_out(clk_500k));

// Text messages configuration circuit.
always @(posedge clk) begin
  if (reset) begin
    data[0   :13*8+7] <= "The result is:";
    data[14*8:15*8+7] <= { 8'h0D, 8'h0A };
    data[16*8:41*8+7] <= "[ 0000, 0000, 0000 ,0000 ]";
    data[42*8:43*8+7] <= { 8'h0D, 8'h0A };
    data[44*8:69*8+7] <= "[ 0000, 0000, 0000 ,0000 ]";
    data[70*8:71*8+7] <= { 8'h0D, 8'h0A };
    data[72*8:97*8+7] <= "[ 0000, 0000, 0000 ,0000 ]";
	  data[98*8:99*8+7] <= { 8'h0D, 8'h0A };
    data[100*8:125*8+7] <= "[ 0000, 0000, 0000 ,0000 ]";
    data[126*8:130*8+7] <= { 8'h0D, 8'h0A, 8'h0D, 8'h0A, 8'h00 };
    data[130*8:399*8+7] <= 0;
  end
  else if(sd_counter == 512 + 149)begin
    // print arr_ans
    data[18*8:18*8+7] <= arr_ans[0][15:12] + (arr_ans[0][15:12]>9?"7":"0");
    data[19*8:19*8+7] <= arr_ans[0][11:8] + (arr_ans[0][11:8]>9?"7":"0");
    data[20*8:20*8+7] <= arr_ans[0][7:4] + (arr_ans[0][7:4]>9?"7":"0");
    data[21*8:21*8+7] <= arr_ans[0][3:0] + (arr_ans[0][3:0]>9?"7":"0");
		
		data[24*8:24*8+7] <= arr_ans[1][15:12] + (arr_ans[0][15:12]>9?"7":"0");
    data[25*8:25*8+7] <= arr_ans[1][11:8] + (arr_ans[1][11:8]>9?"7":"0");
    data[26*8:26*8+7] <= arr_ans[1][7:4] + (arr_ans[1][7:4]>9?"7":"0");
    data[27*8:27*8+7] <= arr_ans[1][3:0] + (arr_ans[1][3:0]>9?"7":"0");
		
		data[30*8:30*8+7] <= arr_ans[2][15:12] + (arr_ans[2][15:12]>9?"7":"0");
    data[31*8:31*8+7] <= arr_ans[2][11:8] + (arr_ans[2][11:8]>9?"7":"0");
    data[32*8:32*8+7] <= arr_ans[2][7:4] + (arr_ans[2][7:4]>9?"7":"0");
    data[33*8:33*8+7] <= arr_ans[2][3:0] + (arr_ans[2][3:0]>9?"7":"0");
		
		data[36*8:36*8+7] <= arr_ans[3][15:12] + (arr_ans[3][15:12]>9?"7":"0");
    data[37*8:37*8+7] <= arr_ans[3][11:8] + (arr_ans[3][11:8]>9?"7":"0");
    data[38*8:38*8+7] <= arr_ans[3][7:4] + (arr_ans[3][7:4]>9?"7":"0");
    data[39*8:39*8+7] <= arr_ans[3][3:0] + (arr_ans[3][3:0]>9?"7":"0");
		
		data[46*8:46*8+7] <= arr_ans[4][15:12] + (arr_ans[4][15:12]>9?"7":"0");
    data[47*8:47*8+7] <= arr_ans[4][11:8] + (arr_ans[4][11:8]>9?"7":"0");
    data[48*8:48*8+7] <= arr_ans[4][7:4] + (arr_ans[4][7:4]>9?"7":"0");
    data[49*8:49*8+7] <= arr_ans[4][3:0] + (arr_ans[4][3:0]>9?"7":"0");
		
		data[52*8:52*8+7] <= arr_ans[5][15:12] + (arr_ans[5][15:12]>9?"7":"0");
    data[53*8:53*8+7] <= arr_ans[5][11:8] + (arr_ans[5][11:8]>9?"7":"0");
    data[54*8:54*8+7] <= arr_ans[5][7:4] + (arr_ans[5][7:4]>9?"7":"0");
    data[55*8:55*8+7] <= arr_ans[5][3:0] + (arr_ans[5][3:0]>9?"7":"0");
		
		data[58*8:58*8+7] <= arr_ans[6][15:12] + (arr_ans[6][15:12]>9?"7":"0");
    data[59*8:59*8+7] <= arr_ans[6][11:8] + (arr_ans[6][11:8]>9?"7":"0");
    data[60*8:60*8+7] <= arr_ans[6][7:4] + (arr_ans[6][7:4]>9?"7":"0");
    data[61*8:61*8+7] <= arr_ans[6][3:0] + (arr_ans[6][3:0]>9?"7":"0");
		
		data[64*8:64*8+7] <= arr_ans[7][15:12] + (arr_ans[7][15:12]>9?"7":"0");
    data[65*8:65*8+7] <= arr_ans[7][11:8] + (arr_ans[7][11:8]>9?"7":"0");
    data[66*8:66*8+7] <= arr_ans[7][7:4] + (arr_ans[7][7:4]>9?"7":"0");
    data[67*8:67*8+7] <= arr_ans[7][3:0] + (arr_ans[7][3:0]>9?"7":"0");
		
		data[74*8:74*8+7] <= arr_ans[8][15:12] + (arr_ans[8][15:12]>9?"7":"0");
    data[75*8:75*8+7] <= arr_ans[8][11:8] + (arr_ans[8][11:8]>9?"7":"0");
    data[76*8:76*8+7] <= arr_ans[8][7:4] + (arr_ans[8][7:4]>9?"7":"0");
    data[77*8:77*8+7] <= arr_ans[8][3:0] + (arr_ans[8][3:0]>9?"7":"0");
		
		data[80*8:80*8+7] <= arr_ans[9][15:12] + (arr_ans[9][15:12]>9?"7":"0");
    data[81*8:81*8+7] <= arr_ans[9][11:8] + (arr_ans[9][11:8]>9?"7":"0");
    data[82*8:82*8+7] <= arr_ans[9][7:4] + (arr_ans[9][7:4]>9?"7":"0");
    data[83*8:83*8+7] <= arr_ans[9][3:0] + (arr_ans[9][3:0]>9?"7":"0");
		
		data[86*8:86*8+7] <= arr_ans[10][15:12] + (arr_ans[10][15:12]>9?"7":"0");
    data[87*8:87*8+7] <= arr_ans[10][11:8] + (arr_ans[10][11:8]>9?"7":"0");
    data[88*8:88*8+7] <= arr_ans[10][7:4] + (arr_ans[10][7:4]>9?"7":"0");
    data[89*8:89*8+7] <= arr_ans[10][3:0] + (arr_ans[10][3:0]>9?"7":"0");
		
		data[92*8:92*8+7] <= arr_ans[11][15:12] + (arr_ans[11][15:12]>9?"7":"0");
    data[93*8:93*8+7] <= arr_ans[11][11:8] + (arr_ans[11][11:8]>9?"7":"0");
    data[94*8:94*8+7] <= arr_ans[11][7:4] + (arr_ans[11][7:4]>9?"7":"0");
    data[95*8:95*8+7] <= arr_ans[11][3:0] + (arr_ans[11][3:0]>9?"7":"0");
		
		data[102*8:102*8+7] <= arr_ans[12][15:12] + (arr_ans[12][15:12]>9?"7":"0");
    data[103*8:103*8+7] <= arr_ans[12][11:8] + (arr_ans[12][11:8]>9?"7":"0");
    data[104*8:104*8+7] <= arr_ans[12][7:4] + (arr_ans[12][7:4]>9?"7":"0");
    data[105*8:105*8+7] <= arr_ans[12][3:0] + (arr_ans[12][3:0]>9?"7":"0");
		
		data[108*8:108*8+7] <= arr_ans[13][15:12] + (arr_ans[13][15:12]>9?"7":"0");
    data[109*8:109*8+7] <= arr_ans[13][11:8] + (arr_ans[13][11:8]>9?"7":"0");
    data[110*8:110*8+7] <= arr_ans[13][7:4] + (arr_ans[13][7:4]>9?"7":"0");
    data[111*8:111*8+7] <= arr_ans[13][3:0] + (arr_ans[13][3:0]>9?"7":"0");
		
		data[114*8:114*8+7] <= arr_ans[14][15:12] + (arr_ans[14][15:12]>9?"7":"0");
    data[115*8:115*8+7] <= arr_ans[14][11:8] + (arr_ans[14][11:8]>9?"7":"0");
    data[116*8:116*8+7] <= arr_ans[14][7:4] + (arr_ans[14][7:4]>9?"7":"0");
    data[117*8:117*8+7] <= arr_ans[14][3:0] + (arr_ans[14][3:0]>9?"7":"0");
		
		data[120*8:120*8+7] <= arr_ans[15][15:12] + (arr_ans[15][15:12]>9?"7":"0");
    data[121*8:121*8+7] <= arr_ans[15][11:8] + (arr_ans[15][11:8]>9?"7":"0");
    data[122*8:122*8+7] <= arr_ans[15][7:4] + (arr_ans[15][7:4]>9?"7":"0");
    data[123*8:123*8+7] <= arr_ans[15][3:0] + (arr_ans[15][3:0]>9?"7":"0");
    end
end

always@(*)begin
	case(byte0)
		"0":tmp = 0;
		"1":tmp = 1;
		"2":tmp = 2;
		"3":tmp = 3;
		"4":tmp = 4;
		"5":tmp = 5;
		"6":tmp = 6;
		"7":tmp = 7;
		"8":tmp = 8;
		"9":tmp = 9;
		"A":tmp = 10;
		"B":tmp = 11;
		"C":tmp = 12;
		"D":tmp = 13;
		"E":tmp = 14;
		"F":tmp = 15;
		default tmp = 99;
		endcase	
end

always @(posedge clk) begin // Stores sram[0] in the register 'byte0'.
  if (reset) byte0 <= 8'b0;
  else if (en && P == S_arr_aIN_FIND_arr_aTRIX) byte0 <= data_out;
end

always@(posedge clk) begin
	if(reset)begin
		arr_a[0]<=0;
		arr_a[1]<=0;
		arr_a[2]<=0;
		arr_a[3]<=0;
		arr_a[4]<=0;
		arr_a[5]<=0;
		arr_a[6]<=0;
		arr_a[7]<=0;
		arr_a[8]<=0;
		arr_a[9]<=0;
		arr_a[10]<=0;
		arr_a[11]<=0;
		arr_a[12]<=0;
		arr_a[13]<=0;
		arr_a[14]<=0;
		arr_a[15]<=0;
		
		arr_b[0]<=0;
		arr_b[1]<=0;
		arr_b[2]<=0;
		arr_b[3]<=0;
		arr_b[4]<=0;
		arr_b[5]<=0;
		arr_b[6]<=0;
		arr_b[7]<=0;
		arr_b[8]<=0;
		arr_b[9]<=0;
		arr_b[10]<=0;
		arr_b[11]<=0;
		arr_b[12]<=0;
		arr_b[13]<=0;
		arr_b[14]<=0;
		arr_b[15]<=0;
		x0 <= 0;
		y0 <= 0;
		counter <= 0;
		end
		else begin
arr_a[0] <= (sd_counter == 512 + 15)? temp : arr_a[0];
  arr_a[1] <= (sd_counter == 512 + 31)? temp : arr_a[1];
  arr_a[2] <= (sd_counter == 512 + 47)? temp : arr_a[2];////////////////////////////////////////////////ROW
  arr_a[3] <= (sd_counter == 512 + 63)? temp : arr_a[3];
  
  arr_a[4] <= (sd_counter == 512 + 19)? temp : arr_a[4];
  arr_a[5] <= (sd_counter == 512 + 35)? temp : arr_a[5];
  arr_a[6] <= (sd_counter == 512 + 51)? temp : arr_a[6];
  arr_a[7] <= (sd_counter == 512 + 67)? temp : arr_a[7];
  
  arr_a[8] <= (sd_counter == 512 + 23)? temp : arr_a[8];
  arr_a[9] <= (sd_counter == 512 + 39)? temp : arr_a[9];
  arr_a[10] <= (sd_counter == 512 + 55)? temp : arr_a[10];
  arr_a[11] <= (sd_counter == 512 + 71)? temp : arr_a[11];
  
  arr_a[12] <= (sd_counter == 512 + 27)? temp : arr_a[12];
  arr_a[13] <= (sd_counter == 512 + 43)? temp : arr_a[13];
  arr_a[14] <= (sd_counter == 512 + 59)? temp : arr_a[14];
  arr_a[15] <= (sd_counter == 512 + 75)? temp : arr_a[15];
  
//////////////////////////READ arr_aTRIX B///////////////////////////////////////////////////////////  
  
  arr_b[0] <= (sd_counter == 512 + 79)? temp : arr_b[0];
  arr_b[4] <= (sd_counter == 512 + 83)? temp : arr_b[4];
  arr_b[8] <= (sd_counter == 512 + 87)? temp : arr_b[8];////////////////////////////////////////////////COL
  arr_b[12] <= (sd_counter == 512 + 91)? temp : arr_b[12];
  
  arr_b[1] <= (sd_counter == 512 + 95)? temp : arr_b[1];
  arr_b[5] <= (sd_counter == 512 + 99)? temp : arr_b[5];
  arr_b[9] <= (sd_counter == 512 + 103)? temp : arr_b[9];
  arr_b[13] <= (sd_counter == 512 + 107)? temp : arr_b[13];
 
  arr_b[2] <= (sd_counter == 512 + 111)? temp : arr_b[2];
  arr_b[6] <= (sd_counter == 512 + 115)? temp : arr_b[6];
  arr_b[10] <= (sd_counter == 512 + 119)? temp : arr_b[10];
  arr_b[14] <= (sd_counter == 512 + 123)? temp : arr_b[14];
  
  arr_b[3] <= (sd_counter == 512 + 127)? temp : arr_b[3];
  arr_b[7] <= (sd_counter == 512 + 131)? temp : arr_b[7];
  arr_b[11] <= (sd_counter == 512 + 135)? temp : arr_b[11];
  arr_b[15] <= (sd_counter == 512 + 139)? temp : arr_b[15];
	end
end
always @(posedge clk) begin
  if(reset)begin
	temp = 0;
	temp1 = 0;
	temp2 = 0;
  end
  if(sd_counter == 512 + 13 || sd_counter == 512 + 17 || sd_counter == 512 + 21 || sd_counter == 512 + 25 ||
	 sd_counter == 512 + 29 || sd_counter == 512 + 33 || sd_counter == 512 + 37 || sd_counter == 512 + 41 ||
	 sd_counter == 512 + 45 || sd_counter == 512 + 49 || sd_counter == 512 + 53 || sd_counter == 512 + 57 ||
	 sd_counter == 512 + 61 || sd_counter == 512 + 65 || sd_counter == 512 + 69 || sd_counter == 512 + 73 ||
	 sd_counter == 512 + 77 || sd_counter == 512 + 81 || sd_counter == 512 + 85 || sd_counter == 512 + 89 ||
	 sd_counter == 512 + 93 || sd_counter == 512 + 97 || sd_counter == 512 + 101|| sd_counter == 512 + 105||
	 sd_counter == 512 + 109|| sd_counter == 512 + 113|| sd_counter == 512 + 117|| sd_counter == 512 + 121||
	 sd_counter == 512 + 125|| sd_counter == 512 + 129|| sd_counter == 512 + 133|| sd_counter == 512 + 137)begin
    if(byte2[15:8] > "9") temp1 = byte2[15:8] - "7";
    else temp1 = byte2[15:8] - "0";
    
    if(byte2[7:0] > "9") temp2 = byte2[7:0] - "7";
    else temp2 = byte2[7:0] - "0";
    temp = (16*temp1 + temp2);
  end
end

always @(posedge clk) begin
  if (reset)
    tag <= 0;
  else begin
    tag[0  :3*8+7] <= (sd_counter == 512 + 5)? byte4 : tag[0  :3*8+7];
		tag[4*8:7*8+7] <= (sd_counter == 512 + 9)? byte4 : tag[4*8:7*8+7];
  end
end

// Enable one cycle of btn_pressed per each button hit.
assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;

always @(posedge clk) begin
  if (reset)
    prev_btn_level <= 0;
  else
    prev_btn_level <= btn_level;
end


always@(posedge clk)begin
		if(sd_counter >= 512 + 141 && sd_counter <= 512 + 145)begin 
			 if(sd_counter!=512+145)begin
			 t0[0] <= arr_a[0] * arr_b[0 + sd_counter - 141 - 512];
			 t0[1] <= arr_a[1] * arr_b[4 + sd_counter - 141 - 512];
			 t0[2] <= arr_a[2] * arr_b[8 + sd_counter - 141 - 512];
			 t0[3] <= arr_a[3] * arr_b[12 + sd_counter - 141 - 512];
			 t1[0] <= arr_a[4] * arr_b[0 + sd_counter - 141 - 512];
			 t1[1] <= arr_a[5] * arr_b[4 + sd_counter - 141 - 512];
			 t1[2] <= arr_a[6] * arr_b[8 + sd_counter - 141 - 512];
			 t1[3] <= arr_a[7] * arr_b[12 + sd_counter - 141 - 512];
			 t2[0] <= arr_a[8] * arr_b[0 + sd_counter - 141 - 512];
			 t2[1] <= arr_a[9] * arr_b[4 + sd_counter - 141 - 512];
			 t2[2] <= arr_a[10] * arr_b[8 + sd_counter - 141 - 512];
			 t2[3] <= arr_a[11] * arr_b[12 + sd_counter - 141 - 512];
			 t3[0] <= arr_a[12] * arr_b[0 + sd_counter - 141 - 512];
			 t3[1] <= arr_a[13] * arr_b[4 + sd_counter - 141 - 512];
			 t3[2] <= arr_a[14] * arr_b[8 + sd_counter - 141 - 512];
			 t3[3] <= arr_a[15] * arr_b[12 + sd_counter - 141 - 512];
			 end
			 if(sd_counter!=512+141)begin
			 arr_ans[0 + sd_counter - 142 - 512] <= t0[0]+t0[1]+t0[2]+t0[3];
			 arr_ans[4 + sd_counter - 142 - 512] <= t1[0]+t1[1]+t1[2]+t1[3];
			 arr_ans[8 + sd_counter - 142 - 512] <= t2[0]+t2[1]+t2[2]+t2[3];
			 arr_ans[12 + sd_counter - 142 - 512] <= t3[0]+t3[1]+t3[2]+t3[3];
			 end
		end
end



// ------------------------------------------------------------------------
// The following code describes an SRAM memory block that is connected
// to the data output port of the SD controller.
// Once the read request is arr_ade to the SD controller, 512 bytes of data
// will be sequentially read into the SRAM memory block, one byte per
// clock cycle (as long as the sd_valid signal is high).
sram ram0(.clk(clk), .we(we), .en(en),
          .addr(sram_addr), .data_i(data_in), .data_o(data_out));

assign we = sd_valid;     // Write data into SRAM when sd_valid is high.
assign en = 1;             // Always enable the SRAM block.
assign data_in = sd_dout;  // Input data always comes from the SD controller.

// Set the driver of the SRAM address signal.
assign sram_addr = sd_counter[8:0];

always @(posedge clk) begin // Controller of the 'sd_counter' signal.
  if (reset || P == S_arr_aIN_READ)
    sd_counter <= 0;
  else if ((P == S_arr_aIN_LOOP && sd_valid) || (P == S_arr_aIN_FIND_arr_aTRIX))
    sd_counter <= sd_counter + 1;
end

always @(posedge clk) begin // Shift sram[sram_addr] to the register 'byte4'.
  if (reset) byte4 <= 32'b0;
  else if (en && P == S_arr_aIN_FIND_arr_aTRIX) byte4 <= {byte4[23:0], data_out };
end
//
// End of the SRAM memory block
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the arr_ain circuit that reads a SD card sector (512 bytes)
// and then search the tag.
//
always @(posedge clk) begin
  if (reset) P <= S_arr_aIN_INIT;
  else P <= P_next;
end

assign tag_notfound = ((tag != "arr_aTX_TAG") && (sd_counter == 512 + 10));

always @(*) begin // FSM next-state logic
  case (P)
    S_arr_aIN_INIT: // wait for SD card initialization
      if (init_finish) P_next = S_arr_aIN_IDLE;
      else P_next = S_arr_aIN_INIT;
    S_arr_aIN_IDLE: // wait for button click
      if (btn_pressed == 1) P_next = S_arr_aIN_READ;
      else P_next = S_arr_aIN_IDLE;
    S_arr_aIN_READ: // issue a read request to the SD controller
      P_next = S_arr_aIN_LOOP;
    S_arr_aIN_LOOP:// wait for the input data to enter the SRAM buffer
      if (sd_counter == 512) P_next = S_arr_aIN_FIND_arr_aTRIX;
      else P_next = S_arr_aIN_LOOP;
    S_arr_aIN_FIND_arr_aTRIX:
      if (sd_counter == 512 + 150) P_next = S_arr_aIN_MSG2;
      else if (tag_notfound) P_next = S_arr_aIN_INCR;
      else P_next = S_arr_aIN_FIND_arr_aTRIX;
    S_arr_aIN_INCR:
      P_next = S_arr_aIN_READ;
    S_arr_aIN_MSG2:
      P_next = S_arr_aIN_DONE;
    S_arr_aIN_DONE:
      if (print_done) P_next = S_arr_aIN_IDLE;
      else P_next = S_arr_aIN_DONE;
  endcase
end

// FSM output logics: print string control signals.
always @(*) begin
  if (P == S_arr_aIN_MSG2)
    print_enable = 1;
  else
    print_enable = 0;
end

// FSM output logic: controls the 'rd_req' and 'rd_addr' signals.
always @(*) begin
  rd_req = (P == S_arr_aIN_READ);
  rd_addr = blk_addr;
end

// SD card read address incrementer
always @(posedge clk) begin
  if (reset || P == S_arr_aIN_IDLE) blk_addr <= 32'h2000;
  else blk_addr <= blk_addr + (P == S_arr_aIN_INCR);
end
//
// End of the FSM of the SD card reader
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the controller to send a string to the UART.
//
always @(posedge clk) begin
  if (reset) Q <= S_UART_IDLE;
  else Q <= Q_next;
end

always @(*) begin // FSM next-state logic
  case (Q)
    S_UART_IDLE: // wait for print_string flag
      if (print_enable) Q_next = S_UART_WAIT;
      else Q_next = S_UART_IDLE;
    S_UART_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_UART_SEND;
      else Q_next = S_UART_WAIT;
    S_UART_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_UART_INCR; // transmit next character
      else Q_next = S_UART_SEND;
    S_UART_INCR:
      if (tx_byte == 8'h0) Q_next = S_UART_IDLE; // string transmission ends
      else Q_next = S_UART_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_UART_WAIT)? 1 : 0;
assign tx_byte = data[{ send_counter, 3'b000 } +: 8];

// Send_counter incrementing circuit.
always @(posedge clk) begin
  if (reset) begin
    send_counter <= MESSAGE_STR;
    print_done <= 0;
  end
  else begin
    if (P == S_arr_aIN_IDLE)
      send_counter <= MESSAGE_STR;
    else
      send_counter <= send_counter + (Q == S_UART_SEND && Q_next == S_UART_INCR);
    print_done <= (print_enable)? 0 : (tx_byte == 8'h0);
  end
end
//
// End of the FSM of the print string controller
// ------------------------------------------------------------------------

endmodule
