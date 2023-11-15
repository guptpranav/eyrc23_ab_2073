// AstroTinker Bot : Task 2A : UART Receiver
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to receive UART Rx data packet from receiver line and then update the rx_msg and rx_complete data lines.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Receiver

Input:  clk_50M - 50 MHz clock
        rx      - UART Receiver

Output: rx_msg      - read incoming message
        rx_complete - message received flag
*/

// module declaration
module uart_rx (
  input clk_50M, rx,
  output reg [7:0] rx_msg,
  output reg rx_complete
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin
    rx_msg = 0; rx_complete = 0;
end

// FSM States
parameter START = 0, STOP = 9, IDLE = 10;
parameter ONE = 1, TWO = 2, THREE = 3, FOUR = 4, FIVE = 5, SIX = 6, SEVEN = 7, EIGHT = 8;

reg [7:0] rx_temp = 8'b0;
reg [3:0] state = IDLE;
reg [9:0] cycle = 10'b1111111111;
reg [9:0] counter = 10'b0;

always @(posedge clk_50M) begin
	cycle = cycle+1;
    case (state)
		IDLE: begin
			rx_complete <= 0;
			if (!rx) begin
				state <= START;
			end
		end
		START: begin
			rx_temp <= 0;
			rx_complete <= 0;
			if (cycle == 434) begin
				cycle <= 0;
				state <= ONE;
			end
			rx_temp[7] <= rx;
		end
		ONE: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= TWO;
			end
			rx_temp[6] <= rx;
		end
		TWO: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= THREE;
			end
			rx_temp[5] <= rx;
		end
		THREE: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= FOUR;
			end
			rx_temp[4] <= rx;
		end
		FOUR: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= FIVE;
			end
			rx_temp[3] <= rx;
		end
		FIVE: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= SIX;
			end
			rx_temp[2] <= rx;
		end
		SIX: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= SEVEN;
			end
			rx_temp[1] <= rx;
		end
		SEVEN: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= EIGHT;
			end
			rx_temp[0] <= rx;
		end
		EIGHT: begin
			if (cycle == 434) begin
				cycle <= 0;
				state <= STOP;
			end
		end
		STOP: begin
			if (!rx) begin
				counter <= counter+1;
			end
			if (counter >= 433) begin
				rx_msg <= 0;
				state <= IDLE;
			end else if (cycle == 434) begin
				cycle <= 0;
				counter <= 0;
				state <= IDLE;
				rx_msg <= rx_temp;
				rx_complete <= 1;
			end
		end
	endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule