module asymmetric_distributed_ram(clk, we, addr_a, in, addr_b, out);
parameter WIDTH_IN = 64;
parameter WIDTH_OUT = 8;
parameter DEPTH_IN = 32;
localparam RATIO = WIDTH_IN / WIDTH_OUT;
localparam LOG2_RATIO = log2(RATIO);
parameter DEPTH_OUT = DEPTH_IN * RATIO;
parameter ADDR_A_WIDTH = log2(DEPTH_IN-1);
parameter ADDR_B_WIDTH = log2(DEPTH_OUT-1);

input clk;
input we;
input [ADDR_A_WIDTH - 1:0] addr_a;
input [WIDTH_IN - 1:0] in;
input [ADDR_B_WIDTH - 1:0] addr_b;
output [WIDTH_OUT - 1:0] out;

reg [WIDTH_OUT - 1:0] ram_out [0: RATIO - 1];
genvar g;
generate for(g = 0; g < RATIO; g = g + 1) begin
    reg [WIDTH_OUT - 1:0] ram [0:DEPTH_IN - 1];
    always @(posedge clk) begin
        if(we)
            ram[addr_a] <= in[(g+1)*WIDTH_OUT - 1 -: WIDTH_OUT];
    end
    always @*
        ram_out[g] = ram[addr_b[ADDR_B_WIDTH - 1 -:ADDR_A_WIDTH]];
end
endgenerate

generate if(RATIO == 1)
        assign out = ram_out[0];
    else
        assign out = ram_out[addr_b[LOG2_RATIO-2:0]];
endgenerate
`include "common.vh"
endmodule
