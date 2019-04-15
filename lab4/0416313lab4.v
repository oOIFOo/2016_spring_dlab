`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date:    06:30:08 10/03/2016 
// Design Name: 
// Module Name:    lab4 
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
module lab4(
    input clk,
    input reset,
    input rx,
    output tx,
    output [7:0] led
    );

localparam [1:0] S_INIT = 2'b00, S_PROMPT = 2'b01, S_WAIT_KEY = 2'b10, S_HELLO = 2'b11;
localparam [1:0] S_IDLE = 2'b00, S_WAIT = 2'b01, S_SEND = 2'b10, S_INCR = 2'b11;
localparam MEM_SIZE = 84;
localparam PROMPT_STR = 0;
localparam HELLO_STR = 25;

// declare system variables
wire enter_pressed;
wire [4:0] string_id;
reg print_enable, print_done;
reg [7:0] send_counter;
reg [1:0] P, P_next;
reg [1:0] Q, Q_next;
reg [7:0] data[0:MEM_SIZE-1];
reg [15:0] init_counter;
reg [7:0] number[0:9];
integer idx;

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
reg  [7:0] rx_temp;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;

// declare trans signals
reg [20:0]num;
reg [7:0] ans[3:0];
integer i;

assign enter_pressed  = (rx_temp == 8'h0D);
assign led = { 8'b0 };
assign tx_byte = data[send_counter];

uart uart(
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
    .recv_error(recv_error)
    );
		
always @(posedge clk) begin
  if (reset) begin
    data[ 0] <= 8'h45; 
    data[ 1] <= 8'h6E;
    data[ 2] <= 8'h74;
    data[ 3] <= 8'h65;
    data[ 4] <= 8'h72;
    data[ 5] <= 8'h20;
    data[ 6] <= 8'h61;
    data[ 7] <= 8'h20;
    data[ 8] <= 8'h64;
    data[ 9] <= 8'h65;
    data[10] <= 8'h63;
    data[11] <= 8'h69;
    data[12] <= 8'h6D;
    data[13] <= 8'h61;
    data[14] <= 8'h6C;
    data[15] <= 8'h20;
    data[16] <= 8'h6E;
    data[17] <= 8'h75;
    data[18] <= 8'h6D;
    data[19] <= 8'h62;
    data[20] <= 8'h65;
    data[21] <= 8'h72;
    data[22] <= 8'h3A;
    data[23] <= 8'h20;
    data[24] <= 8'h00;
	 
	  data[25] <= 8'h0D;
		data[26] <= 8'h0A;
		data[27] <= 8'h0D;
		data[28] <= 8'h0A;
    data[29] <= 8'h54;
    data[30] <= 8'h68;
    data[31] <= 8'h65;
    data[32] <= 8'h20;
    data[33] <= 8'h68;
    data[34] <= 8'h65;
    data[35] <= 8'h78;
	  data[36] <= 8'h61;
	  data[37] <= 8'h64;
	  data[38] <= 8'h65;
	  data[39] <= 8'h63;
	  data[40] <= 8'h69;
	  data[41] <= 8'h6D;
	  data[42] <= 8'h61;
	  data[43] <= 8'h6C;
	  data[44] <= 8'h20;
	  data[45] <= 8'h6E;
		data[46] <= 8'h75;
		data[47] <= 8'h6D;
	  data[48] <= 8'h62;
	  data[49] <= 8'h65;
 	  data[50] <= 8'h72;
	  data[51] <= 8'h20;
 	  data[52] <= 8'h69;
	  data[53] <= 8'h73;
	  data[54] <= 8'h3A;
	///////////////////////buttom
		data[59] <= 8'h0D;
		data[60] <= 8'h0A;
		data[61] <= 8'h0D;
		data[62] <= 8'h0A;
	  data[63] <= 8'h00;
		
		data[64] <= 8'h30;
		data[65] <= 8'h00;
	  data[66] <= 8'h31;
		data[67] <= 8'h00;
		data[68] <= 8'h32;
		data[69] <= 8'h00;
		data[70] <= 8'h33;
		data[71] <= 8'h00;
		data[72] <= 8'h34;
		data[73] <= 8'h00;
		data[74] <= 8'h35;
		data[75] <= 8'h00;
		data[76] <= 8'h36;
		data[77] <= 8'h00;
		data[78] <= 8'h37;
		data[79] <= 8'h00;
		data[80] <= 8'h38;
		data[81] <= 8'h00;
	  data[82] <= 8'h39;
		data[83] <= 8'h00;
  end
  else begin
    for (idx = 0; idx < MEM_SIZE; idx = idx + 1) data[idx] <= data[idx];
  end
end

// ------------------------------------------------------------------------
// Main FSM that reads the UART input and triggers
// the output of the string "Hello, World!".
//
always @(posedge clk) begin
  if (reset) P <= S_INIT;
  else P <= P_next;
end

always @(*) begin // FSM next-state logic
  case (P)
    S_INIT: // wait 1 ms for the UART controller to initialize.
	   if (init_counter < 50000) P_next = S_INIT;
		else P_next = S_PROMPT;
    S_PROMPT: // Print the prompt message.
      if (print_done) P_next = S_WAIT_KEY;
      else P_next = S_PROMPT;
    S_WAIT_KEY: // wait for <Enter> key.
      if (enter_pressed) P_next = S_HELLO;
      else P_next = S_WAIT_KEY;
    S_HELLO: // Print the hello message.
      if (print_done) P_next = S_PROMPT;
      else P_next = S_HELLO;
  endcase
end

// FSM output logics
assign string_id = (P_next == S_PROMPT)? PROMPT_STR : HELLO_STR;

always @(posedge clk) begin
  if (reset) print_enable <= 0;
	else if(received && rx_byte != 8'h0D) print_enable <= 1;
  else print_enable <= (P_next == S_PROMPT) | (P_next == S_HELLO);
end

// Initialization counter.
always @(posedge clk) begin
  if (reset) init_counter <= 0;
  else init_counter <= init_counter + 1;
end


always @(posedge clk) begin
  if (reset) Q <= S_IDLE;
  else Q <= Q_next;
end

always @(*) begin // FSM next-state logic
  case (Q)
    S_IDLE: // wait for print_string flag
      if (print_enable) Q_next = S_WAIT;
      else Q_next = S_IDLE;
    S_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_SEND;
      else Q_next = S_WAIT;
    S_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_INCR; // transmit next character
      else Q_next = S_SEND;
    S_INCR:
      if (tx_byte == 8'h0) Q_next = S_IDLE; // string transmission ends
      else Q_next = S_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q == S_WAIT)? 1 : 0;

// FSM-controlled send_counter incrementing data path
always @(posedge clk) begin
  if (reset)
    send_counter <= 0;
  else if (Q == S_INCR) begin
    // If (tx_byte == 8'h0), it means we hit the end of a string.
    send_counter <= (tx_byte == 8'h0)? string_id : send_counter + 1;
    print_done <= (tx_byte == 8'h0);
	end
	else if(received) begin
			if(rx_byte == 8'h30) send_counter <= 64;
			else if(rx_byte == 8'h31) send_counter <= 66;
			else if(rx_byte == 8'h32) send_counter <= 68;
			else if(rx_byte == 8'h33) send_counter <= 70;
			else if(rx_byte == 8'h34) send_counter <= 72;
			else if(rx_byte == 8'h35) send_counter <= 74;
			else if(rx_byte == 8'h36) send_counter <= 76;
			else if(rx_byte == 8'h37) send_counter <= 78;
			else if(rx_byte == 8'h38) send_counter <= 80;
			else if(rx_byte == 8'h39) send_counter <= 82;
	end
  else // 'print_done' and 'print_enable' are mutually exclusive!
    print_done <= ~print_enable;
end

always @(posedge clk) begin
  rx_temp <= (received)? rx_byte : 8'h0;
end
////////////////////////////////////////////////////////////////

always @(posedge clk) begin
		if(rx_temp == 8'h30) num = num * 10 + 0;
		else if(rx_temp == 8'h31) num = num * 10 + 1;
		else if(rx_temp == 8'h32) num = num * 10 + 2;
		else if(rx_temp == 8'h33) num = num * 10 + 3;
		else if(rx_temp == 8'h34) num = num * 10 + 4;
		else if(rx_temp == 8'h35) num = num * 10 + 5;
		else if(rx_temp == 8'h36) num = num * 10 + 6;
		else if(rx_temp == 8'h37) num = num * 10 + 7;
		else if(rx_temp == 8'h38) num = num * 10 + 8;
		else if(rx_temp == 8'h39) num = num * 10 + 9;

		if(enter_pressed) begin
			ans[0] = num % 16;
			num = num / 16;
			ans[1] = num % 16;
			num = num / 16;
			ans[2] = num % 16;
			num = num / 16;
			ans[3] = num % 16;
		end
		
		for(i = 0;i < 4;i = i + 1)
			if(ans[i] == 0) ans[i] = 8'h30;
			else if(ans[i] == 1) ans[i] = 8'h31;
			else if(ans[i] == 2) ans[i] = 8'h32;
			else if(ans[i] == 3) ans[i] = 8'h33;
			else if(ans[i] == 4) ans[i] = 8'h34;
			else if(ans[i] == 5) ans[i] = 8'h35;
			else if(ans[i] == 6) ans[i] = 8'h36;
			else if(ans[i] == 7) ans[i] = 8'h37;
			else if(ans[i] == 8) ans[i] = 8'h38;
			else if(ans[i] == 9) ans[i] = 8'h39;
			else if(ans[i] == 10) ans[i] = 8'h41;
			else if(ans[i] == 11) ans[i] = 8'h42;
			else if(ans[i] == 12) ans[i] = 8'h43;
			else if(ans[i] == 13) ans[i] = 8'h44;
			else if(ans[i] == 14) ans[i] = 8'h45;
			else if(ans[i] == 15) ans[i] = 8'h46;
			
		data[55] = ans[3];
		data[56] = ans[2];
		data[57] = ans[1];
		data[58] = ans[0];
		
		if(rx_temp == 8'h0D) num = 0;
end	
endmodule
