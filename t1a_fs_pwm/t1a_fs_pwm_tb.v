module t1a_fs_pwm_tb;

reg	clk_50M;
reg	[3:0] duty_cycle;
wire pwm_signal;
wire clk_195KHz;
wire clk_3125KHz;

t1a_fs_pwm_bdf PWMBDF(clk_50M, duty_cycle, pwm_signal, clk_195KHz, clk_3125KHz);

initial begin
    clk_50M = 0;
    duty_cycle = 0;
end

always begin
    #5; clk_50M = ~clk_50M;
end

initial begin
    duty_cycle = 4'b0000; #2560;
    duty_cycle = 4'b0001; #2560;
    duty_cycle = 4'b0010; #2560;
    duty_cycle = 4'b0011; #2560;
    duty_cycle = 4'b0100; #2560;
    duty_cycle = 4'b0101; #2560;
    duty_cycle = 4'b0110; #2560;
    duty_cycle = 4'b0111; #2560;
    duty_cycle = 4'b1000; #2560;
    duty_cycle = 4'b0001; #2560;
    duty_cycle = 4'b0010; #2560;
    duty_cycle = 4'b1011; #2560;
    duty_cycle = 4'b1100; #2560;
    duty_cycle = 4'b1101; #2560;
    duty_cycle = 4'b1110; #2560;
    duty_cycle = 4'b1111; #2560;
    $stop;
end

endmodule