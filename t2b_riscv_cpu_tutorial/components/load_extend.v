
// load_extend.v - logic for extending the data and addr for loading word, half and byte


module load_extend (
    input [31:0] y,
    input [ 2:0] sel,
    output reg [31:0] data
);

always @(*) begin
    case (sel)
    3'b000: data = {{24{y[7]}}, y[7:0]};    // signed byte
    3'b001: data = {{16{y[15]}}, y[15:0]};  // signed half
    3'b010: data = y;                       // signed word
    3'b011: data = {24'b0, y[7:0]};         // unsigned byte
    3'b100: data = {16'b0, y[15:0]};        // unsigned half
    default: data = y;
    endcase
end

endmodule
