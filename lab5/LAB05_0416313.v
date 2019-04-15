`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date:    15:45:54 10/04/2016 
// Design Name: 
// Module Name:    lab5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a sample top module of lab 5: sd card reader.
//              The behavior of this module is as follows:
//              1. The moudle will read one block (512 bytes) of the SD card
//                 into an on-chip SRAM every time the user hit the WEST button.
//              2. The starting address of the disk block is #8192 (i.e., 0x2000).
//              3. A message will be printed on the UART about the block id and the
//                 first byte of the block.
//              4. After printing the message, the block address will be incremented
//                 by one, waiting for the next user button press.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
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

localparam [2:0] S_MAIN_INIT = 0, S_MAIN_IDLE = 1, S_MAIN_MSG1 = 2,
                 S_MAIN_READ = 3, S_MAIN_LOOP = 4, S_MAIN_HEX2TXT = 5,
                 S_MAIN_MSG2 = 6, S_MAIN_DONE = 7;
localparam [1:0] S_UART_IDLE = 0, S_UART_WAIT = 1,
                 S_UART_SEND = 2, S_UART_INCR = 3;
localparam MEM_SIZE = 85;
localparam MESSAGE_STR = 0;
localparam NUMBER_STR = 19;

// declare system variables
wire btn_level, btn_pressed;
reg  prev_btn_level;
reg  print_enable, print_done;
reg  [7:0] send_counter;
reg  [2:0] P, P_next;
reg  [1:0] Q, Q_next;
reg  [9:0] sd_counter;
reg  [7:0] byte0;
reg  [0:(MEM_SIZE-1)*8+7] data;
reg  [31:0] blk_addr;

reg [7:0]ans;

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

assign clk_sel = (init_finish)? clk : clk_500k; // clocks for the SD controller
assign led = sd_counter;

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
   data[0   :14*8+7] <= "The matrix is: ";
   data[15*8:16*8+7] <= {8'h0D, 8'h0A};
   data[17*8:18*8+7] <= {8'h5B , 8'h20};
	data[19*8:22*8+7] <= 0;
   data[23*8:24*8+7] <= {8'h44, 8'h20};
	data[25*8:28*8+7] <= 0;
   data[29*8:30*8+7] <= {8'h44, 8'h20};
	data[31*8:34*8+7] <= 0;
   data[35*8:38*8+7] <= {8'h20, 8'h5D, 8'h0A, 8'h0D};
   data[39*8:40*8+7] <= {8'h5B, 8'h20};
	data[41*8:44*8+7] <= 0;
   data[45*8:46*8+7] <= {8'h44, 8'h20};
	data[47*8:50*8+7] <= 0;
   data[51*8:52*8+7] <= {8'h44, 8'h20};
	data[53*8:56*8+7] <= 0;
   data[57*8:60*8+7] <= {8'h20, 8'h5D, 8'h0A, 8'h0D};
   data[61*8:62*8+7] <= {8'h5B, 8'h20};
	data[63*8:66*8+7] <= 0;
   data[67*8:68*8+7] <= {8'h44, 8'h20};
	data[69*8:72*8+7] <= 0;
   data[73*8:74*8+7] <= {8'h44, 8'h20};
	data[75*8:78*8+7] <= 0;
   data[79*8:82*8+7] <= {8'h20, 8'h5D, 8'h0A, 8'h0D};
   data[83*8:83*8+7] <= {8'h00};
  end
  else if(P == S_MAIN_HEX2TXT && ans == 8)begin
    case(sram_addr)
		12:data[19*8:19*8+7] <= byte0;
		13:data[20*8:20*8+7] <= byte0;
		14:data[21*8:21*8+7] <= byte0;
		15:data[22*8:22*8+7] <= byte0;
		30:data[25*8:25*8+7] <= byte0;
		31:data[26*8:26*8+7] <= byte0;
		32:data[27*8:27*8+7] <= byte0;
		33:data[28*8:28*8+7] <= byte0;
		48:data[31*8:31*8+7] <= byte0;
		49:data[32*8:32*8+7] <= byte0;
		50:data[33*8:33*8+7] <= byte0;
		51:data[34*8:34*8+7] <= byte0;
		18:data[41*8:41*8+7] <= byte0;
		19:data[42*8:42*8+7] <= byte0;
		20:data[43*8:43*8+7] <= byte0;
		21:data[44*8:44*8+7] <= byte0;
		36:data[47*8:47*8+7] <= byte0;
		37:data[48*8:48*8+7] <= byte0;
		38:data[49*8:49*8+7] <= byte0;
		39:data[50*8:50*8+7] <= byte0;
		54:data[53*8:53*8+7] <= byte0;
		55:data[54*8:54*8+7] <= byte0;
		56:data[55*8:55*8+7] <= byte0;
		57:data[56*8:56*8+7] <= byte0;
		24:data[63*8:63*8+7] <= byte0;
		25:data[64*8:64*8+7] <= byte0;
		26:data[65*8:65*8+7] <= byte0;
		27:data[66*8:66*8+7] <= byte0;
		42:data[69*8:69*8+7] <= byte0;
		43:data[70*8:70*8+7] <= byte0;
		44:data[71*8:71*8+7] <= byte0;
		45:data[72*8:72*8+7] <= byte0;
		60:data[75*8:75*8+7] <= byte0;
		61:data[76*8:76*8+7] <= byte0;
		62:data[77*8:77*8+7] <= byte0;
		63:data[78*8:78*8+7] <= byte0;
	endcase
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

// ------------------------------------------------------------------------
// The following code describes an SRAM memory block that is connected
// to the data output port of the SD controller.
// Once the read request is made to the SD controller, 512 bytes of data
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
  if (reset  || P == S_MAIN_MSG2 ||sd_counter == 512)
      sd_counter <= 0;
  else if (P == S_MAIN_LOOP && sd_valid)
		sd_counter <= sd_counter + 1;
  else if (P == S_MAIN_HEX2TXT)
		sd_counter <= sd_counter + 1;
end

always @(posedge clk) begin // Stores sram[0] in the register 'byte0'.
  if (reset) byte0 <= 8'b0;
  else if (en && P == S_MAIN_HEX2TXT) byte0 <= data_out;
end
//
// End of the SRAM memory block
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the main circuit that reads a SD card sector (512 bytes)
// and then print its byte.
//
always @(posedge clk) begin
  if (reset) P <= S_MAIN_INIT;
  else P <= P_next;
end

always @(*) begin // FSM next-state logic
  case (P)
    S_MAIN_INIT: // wait for SD card initialization
      if (init_finish) P_next = S_MAIN_IDLE;
      else P_next = S_MAIN_INIT;
    S_MAIN_IDLE: // wait for button click
      if (btn_pressed == 1) P_next = S_MAIN_MSG1;
      else P_next = S_MAIN_IDLE;
    S_MAIN_MSG1:
      if (print_done) P_next = S_MAIN_READ;
      else P_next = S_MAIN_MSG1;
    S_MAIN_READ: // issue a read request to the SD controller
      P_next = S_MAIN_LOOP;
    S_MAIN_LOOP: // wait for the input data to enter the SRAM buffer
      if (sd_counter == 512) P_next = S_MAIN_HEX2TXT;
      else P_next = S_MAIN_LOOP;
    S_MAIN_HEX2TXT:
		if(sram_addr > 63) P_next =  S_MAIN_MSG2;
		else P_next =  S_MAIN_HEX2TXT;
	S_MAIN_MSG2: // read byte 0 of the sector from sram[]
		P_next =  S_MAIN_DONE;
    S_MAIN_DONE:
      if (print_done) P_next = (ans == 8)?S_MAIN_IDLE : S_MAIN_READ;
      else P_next = S_MAIN_DONE;
  endcase
end

always @(posedge clk) begin
		if(reset || P == S_MAIN_READ) ans <= 0;
		else if(P == S_MAIN_HEX2TXT)begin
			case (sram_addr)
				2:ans <= ans + (byte0 == "D");
				3:ans <= ans + (byte0 == "L");
				4:ans <= ans + (byte0 == "A");			
				5:ans <= ans + (byte0 == "B");
				6:ans <= ans + (byte0 == "_");
				7:ans <= ans + (byte0 == "T");
				8:ans <= ans + (byte0 == "A");
				9:ans <= ans + (byte0 == "G");
			endcase
		end
end

// FSM output logics: print string control signals.
always @(*) begin
  if ((P == S_MAIN_IDLE && btn_pressed == 1) || (P == S_MAIN_MSG2 && ans == 8))
    print_enable = 1;
  else
    print_enable = 0;
end

// FSM output logic: controls the 'rd_req' and 'rd_addr' signals.
always @(*) begin
  rd_req = (P == S_MAIN_READ);
  rd_addr = blk_addr;
  
end

// SD card read address incrementer
always @(posedge clk) begin
  if (reset) blk_addr <= 32'h2000;
  else if(P == S_MAIN_MSG2)blk_addr <= blk_addr + 1;
  
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
    if (P == S_MAIN_IDLE || print_done)
      send_counter <= MESSAGE_STR;
    else if (P == S_MAIN_MSG2)
      send_counter <= NUMBER_STR;
    else
      send_counter <= send_counter + (Q == S_UART_SEND && Q_next == S_UART_INCR);
    print_done <= (print_enable)? 0 : (tx_byte == 8'h0);
  end
end
//
// End of the FSM of the print string controller
// ------------------------------------------------------------------------

endmodule
