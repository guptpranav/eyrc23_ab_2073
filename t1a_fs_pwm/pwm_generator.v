// AstroTinker Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 3.125MHz Clock Frequency to 195.125KHz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_3125KHz, duty_cycle
//Output : clk_195KHz, pwm_signal


module pwm_generator(
    input clk_3125KHz,
    input [3:0] duty_cycle,
    output reg clk_195KHz, pwm_signal
);

initial begin
    clk_195KHz = 0; pwm_signal = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

// declaring registers
reg [2:0] counter_CLK = 0;  // counts 0 to 7 to scale down clock frequency
reg [3:0] counter_PWM = 0;  // counts 0 to 15 to enforce duty cycle in PWM

// sensitivity list -> trigger at positive edge of 50MHz clock
always @ (posedge clk_3125KHz) begin
    if (!counter_CLK) clk_195KHz = ~clk_195KHz;     // toggles clock signal
    counter_CLK = counter_CLK + 1'b1;               // increment counter_CLK, after 7 it resets to 0
    pwm_signal = counter_PWM < duty_cycle ? 1:0;    // toggle PWM signal
    counter_PWM = counter_PWM + 1'b1;               // increment counter_PWM, after 15 it resets to 0
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
