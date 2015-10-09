module dual_port_block_ram(clk, wr_a, addr_a, d_a, q_a, wr_b, addr_b, d_b, q_b);
parameter WIDTH = 64;
parameter DEPTH = 512;
parameter LOG2_DEPTH = log2(DEPTH - 1);
input clk;
input wr_a;
input [LOG2_DEPTH - 1:0] addr_a;
input [WIDTH - 1:0] d_a;
output reg [WIDTH - 1:0] q_a;
input wr_b;
input [LOG2_DEPTH - 1:0] addr_b;
input [WIDTH - 1:0] d_b;
output reg [WIDTH - 1:0] q_b;

reg [WIDTH - 1:0] ram [0:DEPTH - 1];
always @(posedge clk) begin
    if(wr_a)
        ram[addr_a] <= d_a;
    q_a <= ram[addr_a];
end
always @(posedge clk) begin
    if(wr_b)
        ram[addr_b] <= d_b;
    q_b <= ram[addr_b];
end
`include "common.vh"
endmodule
