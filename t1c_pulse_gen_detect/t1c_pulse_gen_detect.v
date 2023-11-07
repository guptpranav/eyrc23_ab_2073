// AstroTinker Bot : Task 1C : Pulse Generator and Detector
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to design a module which will generate a 10us pulse and detect incoming pulse signal.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

// t1c_pulse_gen_detect
//Inputs : clk_50M, reset, echo_rx
//Output : trigger, distance, pulses, state

// module declaration
module t1c_pulse_gen_detect (
    input clk_50M, reset, echo_rx,
    output reg trigger, out,
    output reg [21:0] pulses,
    output reg [1:0] state
);

initial begin
    trigger = 0; out = 0; pulses = 0; state = 0;
end


//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

parameter WARMUP = 0, TRIGGER = 1, MEASURE = 2, RESULT = 3;
reg [2:0] current_state = WARMUP;
reg [1:0] since_reset = 0;
reg [21:0] counter = 0;

always @(posedge clk_50M) begin
    state <= current_state;
	if (reset) begin
        // reset all output and internal registers back to 0
        trigger <= 0;
        out <= 0;
        counter <= 0;
        pulses <= 0;
		since_reset <= 0;
        current_state <= WARMUP;
    end else begin
		counter <= 0;
        case (current_state)
            WARMUP: begin
                if(!reset) begin
                    // Generate a 1us trigger high signal (50 clock cycles at 50 MHz)
                    if (counter < 49-(since_reset>1 ? 1:since_reset)) begin
                        counter <= counter + 1;
                    end else begin
                        counter <= 0;
                        current_state <= TRIGGER;
						since_reset <= since_reset + 1;
                    end
                end else current_state <= WARMUP;
            end
            TRIGGER: begin
                if(!reset) begin
                    // Generate a 10us trigger high signal (500 clock cycles at 50 MHz)
                    if (counter < 500) begin
                        trigger <= 1;
                        counter <= counter + 1;
                    end else begin
                        trigger <= 0;
                        counter <= 0;
						if (echo_rx) pulses <= pulses + 1;
                        current_state <= MEASURE;
                    end
                end else current_state <= WARMUP;
            end
            MEASURE: begin
                if(!reset) begin
                    // Generate a 1ms measurement loop (50000 clock cycles at 50 MHz)
                    if (counter < 49999) begin
                        counter <= counter + 1;
                        if (echo_rx) pulses <= pulses + 1;
                    end else begin
                        if (echo_rx) pulses <= pulses + 1;
						if (pulses == 29410) out <= 1;
                        counter <= 0;
                        current_state <= RESULT;
                    end
                end
                else current_state <= WARMUP;
            end
            RESULT: begin
                if(!reset) begin
                    if (pulses == 29410) out <= 1;
                    counter <= 0;
					pulses <= 0;
                end
                current_state <= WARMUP;
            end
        endcase
    end
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
