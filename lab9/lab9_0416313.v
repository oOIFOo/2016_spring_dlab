`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Chiao Tung University
// Engineer: Chun-Jen Tsai
//
// Create Date:    14:24:54 11/29/2016 
// Design Name: 
// Module Name:    lab9 
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
module lab9(
  input clk,
  input reset,
  input  button,
  output [7:0] led,
  output LCD_E,
  output LCD_RS,
  output LCD_RW,
  output [3:0] LCD_D,
  input ROT_A,
  input ROT_B
  );

  // declare system variables
  wire btn_level, btn_pressed;
  reg prev_btn_level;
  reg [127:0] row_A, row_B;
  reg [2:0] pos;
  reg [7:0] led_on[0:7];
  reg press;
  reg [31:0]counter;
  reg light;
  reg [9:0]level;
  wire rot_event;
  wire rot_right;
  wire [31:0]maxtime;

  assign led = led_on[0];
  assign maxtime = (press == 0) ? 20000 : 5000;

  debounce btn_db0(
    .clk(clk),
    .btn_input(button),
    .btn_output(btn_level)
  );

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

  Rotation_direction RTD(
    .CLK(clk),
    .ROT_A(ROT_A),
    .ROT_B(ROT_B),
    .rotary_event(rot_event),
    .rotary_right(rot_right)
  );

  // ------------------------------------------------------------------------
  // The following code detects the positive edge of the button-press signal.
  always @(posedge clk) begin
    if (reset) begin
      prev_btn_level <= 1'b1;
    end
    else begin
      prev_btn_level <= btn_level;
    end
  end

  assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1'b1 : 1'b0;
  // End of button-press signal edge detector.
  // ------------------------------------------------------------------------

  // ------------------------------------------------------------------------
  // The following code updates the 1602 LCD text messages.
  always @(posedge clk) begin
    if (reset || btn_pressed) begin
      row_B <= "duty cycle:    %";
      level <= 5;
    end
    else begin
      case (pos)
      0: begin
        row_B [31: 8]<= "  5";
        level <= 5;
      end
      1: begin
        row_B [31: 8]<= " 25";
        level <= 25;
      end
      2: begin
        row_B [31: 8]<= " 50";
        level <= 50;
      end
      3: begin
        row_B [31: 8]<= " 75";
        level <= 75;
      end
      4: begin
        row_B [31: 8]<= "100";
        level <= 100;
      end
		default:begin
			row_B [31: 8]<= "100";
         level <= 100;
		end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if(reset) begin
      row_A <= "Frequency:    Hz";
      press <= 0;
    end
    else if (btn_pressed) begin
      press <= ~press;
    end
    else begin
      case (press)
      0: begin
        row_A [39:16]<= " 25";
      end
      1: begin
        row_A [39:16]<= "100";
      end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (reset || btn_pressed) begin
     counter <= 0;
    end
    else begin
      if(counter == maxtime * 100) counter <= 0;
      else if(counter < maxtime * level) begin
        led_on[0] <= 8'b11111111;
        counter <= counter + 1;
      end
      else begin
        led_on[0] <= 0;
        counter <= counter + 1;
      end
    end
  end
  
  // End of the 1602 LCD text-updating code.
  // ------------------------------------------------------------------------

  // ------------------------------------------------------------------------
  // Initialize the "*" positions on the 1602 LCD.
  // End of the "*" positions initialization.
  // ------------------------------------------------------------------------
//led_on <= 8'b11111111;//
  // ------------------------------------------------------------------------
  // Use the rotary input to adjust the led position.
  always@ (posedge clk) begin
    if (reset)
      pos <= 3'b100;
    else if (rot_event && rot_right && pos < 3'b111)
      pos <= pos + 1;
    else if (rot_event && !rot_right && pos > 3'b000)
      pos <= pos - 1;
  end
  // End of the rotary input code.
  // ------------------------------------------------------------------------

endmodule
