// AstroTinker Bot : Task 2A : UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_50M - 50 MHz clock
        data    - 8-bit data line to transmit
Output: tx      - UART Transmission Line
*/

// module declaration
module uart_tx(
    input  clk_50M,
    input  [7:0] data,
    output reg tx
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin
	tx = 0;
end

parameter START=0, DATA=1, STOP=2, IDLE=3;

reg [2:0] current_state = START;
reg [21:0] counter = 0;
reg [4:0] idx = 0;

always @(posedge clk_50M) begin
	case(current_state)
		START: begin
			if(data) begin
				if(counter<433) begin
					tx <= 0;
					counter = counter+1;
				end else begin
					current_state <= DATA;
					counter <= 0;
				end
			end else begin 
				tx = 1;
				current_state <= IDLE;
			end
		end
		DATA: begin
			if(idx<8) begin
				if(counter<433) begin
					tx <= data[idx];
					counter <= counter+1;
				end else begin
					idx <= idx+1;
					counter <= 0;
				end
			end else begin
				tx <= 1;
				current_state <= STOP;
				counter <= 0;
				idx <= 0;
			end
		end
		STOP: begin
			if(counter<432) begin
				tx <= 1;
				counter <= counter+1;
			end else if(data) begin
				current_state <= START;
				counter <= 0;
			end else begin
				current_state <= IDLE;
				counter <= 0;
			end
		end
		IDLE: begin
			if(!data) begin
				tx<=1;
			end else begin
				tx <= 0;
				current_state <= START;
			end
		end
	endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule